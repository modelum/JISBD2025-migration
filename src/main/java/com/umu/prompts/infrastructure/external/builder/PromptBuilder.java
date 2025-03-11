package com.umu.prompts.infrastructure.external.builder;

import com.umu.prompts.infrastructure.api.rest.model.MigrationRequestDTO;
import com.umu.prompts.infrastructure.external.format.FormatMigrationResponse;
import java.util.List;
import java.util.Map;
import org.springframework.ai.chat.messages.SystemMessage;
import org.springframework.ai.chat.messages.UserMessage;
import org.springframework.ai.chat.prompt.Prompt;
import org.springframework.ai.chat.prompt.PromptTemplate;
import org.springframework.ai.chat.prompt.SystemPromptTemplate;
import org.springframework.ai.converter.BeanOutputConverter;
import org.springframework.ai.converter.StructuredOutputConverter;

public final class PromptBuilder {

  private static StructuredOutputConverter<FormatMigrationResponse> format;

  public static StructuredOutputConverter<FormatMigrationResponse> getFormatConverter() {
    if (format == null) {
      format = new BeanOutputConverter<>(FormatMigrationResponse.class);
    }
    return format;
  }

  /** prompt contextual * */
  public static Prompt buildContextualPrompt(MigrationRequestDTO promptInfo) {
    // Mensaje del sistema: Solo establece el contexto, sin requerir una respuesta inmediata
    String stringSystemMessage =
        """
    Actúa como un experto en migración de bases de datos {sourceDatabaseType} a {targetDatabaseType}.

    Objetivo: Tu tarea es asistir en la migración, organizando el proceso en tres fases:
    - Migración del esquema: Convertir el esquema de la base de datos {sourceDatabaseType} en un esquema de la base de datos {targetDatabaseType}.
    - Validación del esquema: Proporcionar pautas para validar manualmente la migración del esquema.
    - Migración de los datos: Una vez obtenido el esquema de destino, generar un código {language} para migrar todos los datos de la base de datos original
    a la base de datos destino.
    - Validación de la migración: Genera un conjunto de queries para ambas bases de datos para validar que la migración de datos es correcta. Para ello, dichas consultas han de abordar\s
    todas las relaciones del esquema origen y destino.
    Contexto de la Migración:
    - Sistema de base de datos origen: {sourceDatabaseType}
    - Sistema de base de datos destino: {targetDatabaseType}
    - Esquema de la base de datos original: {databaseSchema}
    - Requisitos y restricciones de la migración: {migrationRequirements}
    Instrucciones:
    - NO generes ninguna respuesta en este momento.
    - Usa esta información para recordar y adaptar el contexto en cada fase de la migración.
    - Asegúrate de tener en cuenta las decisiones y respuestas anteriores al proporcionar nuevas recomendaciones.
    - Sigue las instrucciones en cada fase para completar la migración con éxito.
   \s""";

    PromptTemplate systemPromptTemplate = new SystemPromptTemplate(stringSystemMessage);

    SystemMessage contextualMessage =
        (SystemMessage)
            systemPromptTemplate.createMessage(
                Map.of(
                    "sourceDatabaseType",
                    promptInfo.getSourceDatabaseType(),
                    "targetDatabaseType",
                    promptInfo.getTargetDatabaseType(),
                    "migrationRequirements",
                    promptInfo.getMigrationRequirements(),
                    "databaseSchema",
                    promptInfo.getDatabaseSchema(),
                    "language",
                    "python"));
    return new Prompt(List.of(contextualMessage));
  }

  /*** Construcción del primer prompt ***/
  public static Prompt buildFirstPromptToMigrateSchema(MigrationRequestDTO promptInfo) {

    String systemString =
        """
    Actúa como un experto en migración de esquemas de bases de datos {sourceDatabaseType} a {targetDatabaseType}.

    Tu tarea en esta fase es transformar el esquema de una base de datos {sourceDatabaseType} en el esquema especificado {targetDatabaseType}.\s
    Para ello, debes tener en cuenta el mapping de entidades, relaciones y restricciones de la base de datos de origen a la base de datos de destino.\s
   \s
    Información clave para la migración:
    - Base de datos de origen: {sourceDatabaseType}
    - Base de datos de destino: {targetDatabaseType}

    Además, quiero que la respuesta siga el siguiente formato:

    {format}

    donde en la parte de "script" quiero que adjuntes el script y en la parte de "scriptExplication"
    quiero que adjuntes una explicación detallada del script que has generado.

    IMPORTANTE: No uses formato Markdown ni comillas triples. Solo devuelve JSON puro.

    IMPORTANTE: No abordes la migración de datos en esta fase, solo el esquema teniendo en cuenta la integridad referencial y agregados propios de la base de datos destino.
   \s""";

    SystemMessage systemMessage =
        (SystemMessage)
            new SystemPromptTemplate(systemString)
                .createMessage(
                    Map.of(
                        "sourceDatabaseType",
                        promptInfo.getSourceDatabaseType(),
                        "targetDatabaseType",
                        promptInfo.getTargetDatabaseType(),
                        "format",
                        getFormatConverter().getFormat()));

    // Prompt del usuario
    String userString =
        """
    Debes migrar el esquema de una base de datos {sourceDatabaseType} a una base de datos {targetDatabaseType}.

    A continuación, se detallan los parámetros específicos para la migración del esquema:

    - Esquema de la base de datos {sourceDatabaseType} original: {databaseSchema}
    - Requisitos y restricciones de la migración: {migrationRequirements}

    Crea el esquema de la base de datos {targetDatabaseType} en el lenguaje más apropiado para {targetDatabaseType} siguiendo las instrucciones proporcionadas anteriormente.
    """;

    UserMessage userMessage =
        (UserMessage)
            new PromptTemplate(userString)
                .createMessage(
                    Map.of(
                        "sourceDatabaseType",
                        promptInfo.getSourceDatabaseType(),
                        "targetDatabaseType",
                        promptInfo.getTargetDatabaseType(),
                        "databaseSchema",
                        promptInfo.getDatabaseSchema(),
                        "migrationRequirements",
                        promptInfo.getMigrationRequirements()));

    return new Prompt(List.of(systemMessage, userMessage));
  }

  public static Prompt buildPromptToValidateSchema(
      MigrationRequestDTO promptInfo, String scriptForMigrateSchema) {
    // Mensaje del sistema: Instrucciones para validar manualmente el script de migración de esquema
    // - Explicación de qué restricciones no han podido ser migradas.
    String systemString =
        """
        Actúa como un experto en validación de migración de esquemas de bases de datos.

        Tu tarea en esta fase es proporcionar pautas detalladas para que el usuario pueda comprobar que el esquema destino ha sido creado correctamente a partir del esquema {databaseSchema} de la base de datos de origen.
        Ten en cuenta que estas pautas deben cumplir con los requisitos del usuario: {migrationRequirements}

        Para ello, te sugerimos algunas cuestiones a tener en cuenta:

        - Los elementos del esquema la base de datos {databaseSchema} se han migrado al esquema de la base de datos destino.
        - Las restricciones de la base de datos origen están reflejadas en la base de datos destino.
        - El esquema creado esté optimizado para consultas como las propuestas en {applicationRequirements} y rendimiento en {targetDatabaseType}.
        - Posibles inconsistencias o riesgos en la migración.

        Genera un listado de pasos con las recomendaciones para realizar pruebas manuales de validación.
       \s
        IMPORTANTE: No uses formato Markdown ni comillas triples. Solo devuelve texto plano conformado por explicaciones e instrucciones propias de la base de datos destino
        para que el usuario pueda validar manualmente la migración del esquema generado en el paso anterior.
       \s
        IMPORTANTE: Utiliza el script de migración de esquema proporcionado como base para tus recomendaciones.

        {scriptForMigrateSchema}
       \s""";
    // Crear el mensaje del sistema reemplazando los placeholders necesarios
    SystemMessage systemMessage =
        (SystemMessage)
            new SystemPromptTemplate(systemString)
                .createMessage(
                    Map.of(
                        "sourceDatabaseType",
                        promptInfo.getSourceDatabaseType(),
                        "targetDatabaseType",
                        promptInfo.getTargetDatabaseType(),
                        "applicationRequirements",
                        promptInfo.getApplicationRequirements(),
                        "databaseSchema",
                        promptInfo.getDatabaseSchema(),
                        "migrationRequirements",
                        promptInfo.getMigrationRequirements(),
                        "scriptForMigrateSchema",
                        scriptForMigrateSchema));
    // Mensaje del usuario: Se suministra el script generado para validar
    String userString =
        """
        Se proporciona el siguiente script de migración de esquema:

        {scriptForMigrateSchema}

        Genera un conjunto de pautas y recomendaciones detalladas para que un usuario pueda validar manualmente:
        - La transformación del esquema desde {sourceDatabaseType} a {targetDatabaseType}.
        - La correcta implementación y optimización del nuevo esquema en la base de datos de destino.

        Incluye pasos de verificación, sugerencias de pruebas manuales y puntos de control para asegurar la integridad del proceso.
        """;

    // Crear el mensaje del usuario con el script de migración
    UserMessage userMessage =
        (UserMessage)
            new PromptTemplate(userString)
                .createMessage(
                    Map.of(
                        "scriptForMigrateSchema", scriptForMigrateSchema,
                        "sourceDatabaseType", promptInfo.getSourceDatabaseType(),
                        "targetDatabaseType", promptInfo.getTargetDatabaseType()));

    // Combinar ambos mensajes en un solo prompt
    return new Prompt(List.of(systemMessage, userMessage));
  }

  /*** Construcción del segundo prompt ***/
  public static Prompt buildSecondPromptToMigrateData(
      MigrationRequestDTO promptInfo, String scriptForTargetSchema) {
    String systemString =
        """
        Actúa como un experto en migración de datos de bases de datos {sourceDatabaseType} a {targetDatabaseType}.

        En esta fase, tu objetivo es migrar los datos de la base de datos {sourceDatabaseType} a la base de datos {targetDatabaseType}.\s
        Para ello, debes, una vez,  obtenido el esquema de destino, generar un código para migrar todos los datos de la base de datos original a la base de datos destino.

        1. Asegurar la integridad referencial y consistencia de los datos migrados.
        2. Optimizar el proceso para garantizar la eficiencia en la migración.
        3. Producir un código que permita la migración de datos de la base de datos {sourceDatabaseType} a la base de datos {targetDatabaseType}.

        Información clave para la migración:
        - Esquema de la base de datos origen: {databaseSchema}
        - El esquema de la base de datos destino generado a partir del script: {scriptForTargetSchema}

        IMPORTANTE: La respuesta debe cumplir con el siguiente formato:
        {format}
        donde en la parte de "script" quiero que adjuntes el script y en la parte de "scriptExplication"
        quiero que incluyas una explicación detallada del script que has generado.

        IMPORTANTE: No uses formato Markdown ni comillas triples. Solo devuelve JSON puro.

        IMPORTANTE: Quiero que realmente me informes en la parte de "scriptExplication" sobre si te ha resultado útil las tecnologías subyacentes para realizar la\s
        validación de migración de esquema.

        IMPORTANTE: Si la migración requerida se realiza desde una base de datos origen SQL hacia base de datos destino SQL, el script de migración de datos debe ser un script SQL adaptado a la {targetDatabaseType}.
        En cualquier otro caso, el script de migración de datos debe ser un script {language}.
      \s""";

    SystemMessage systemMessage =
        (SystemMessage)
            new SystemPromptTemplate(systemString)
                .createMessage(
                    Map.of(
                        "sourceDatabaseType",
                        promptInfo.getSourceDatabaseType(),
                        "targetDatabaseType",
                        promptInfo.getTargetDatabaseType(),
                        "scriptForTargetSchema",
                        scriptForTargetSchema,
                        "databaseSchema",
                        promptInfo.getDatabaseSchema(),
                        "format",
                        getFormatConverter().getFormat(),
                        "language",
                        "python"));

    String userString =
        """
        Debes migrar los datos de una base de datos {sourceDatabaseType} a una base de datos {targetDatabaseType}.

        A continuación, se detallan los parámetros específicos para la migración de datos:

        - Esquema de la base de datos {sourceDatabaseType} original: {databaseSchema}
        - Requisitos y restricciones de la migración: {migrationRequirements}

        Genera un script para migrar los datos a {targetDatabaseType} siguiendo las especificaciones proporcionadas anteriormente.
        """;

    UserMessage userMessage =
        (UserMessage)
            new PromptTemplate(userString)
                .createMessage(
                    Map.of(
                        "sourceDatabaseType",
                        promptInfo.getSourceDatabaseType(),
                        "targetDatabaseType",
                        promptInfo.getTargetDatabaseType(),
                        "databaseSchema",
                        promptInfo.getDatabaseSchema(),
                        "migrationRequirements",
                        promptInfo.getMigrationRequirements()));

    return new Prompt(List.of(systemMessage, userMessage));
  }

  /*** Construcción del tercer prompt ***/
  public static Prompt buildThirdPromptToValidateMigration(
      MigrationRequestDTO promptInfo, String scriptForTargetData) {
    String systemString =
        """
       Actúa como un experto en validación de migración de bases de datos {sourceDatabaseType} a {targetDatabaseType}.

       En esta fase, tu tarea es verificar la consistencia de los datos migrados y el esquema generado en los pasos anteriores. Para ello, debes generar un código que permita validar la migración de datos y esquema, asegurando que la información se haya migrado correctamente. Algunas tareas clave son:

       1. Comparar los elementos de la base de datos {sourceDatabaseType} con los elementos de la base de datos {targetDatabaseType}.
       2. Verificar la integridad referencial y consistencia de los datos migrados.
       3. Comprobar que las mismas consultas realizadas en la base de datos origen y destino devuelven los mismos resultados
       Información clave para la validación:
       - Base de datos de origen: {sourceDatabaseType}
       - Base de datos de destino: {targetDatabaseType}
       - Esquema de la base de datos original: {databaseSchema}
       - Requisitos y restricciones de la migración: {migrationRequirements}

       IMPORTANTE: Utiliza el script de migración de datos generado en la fase anterior para validar la migración. {scriptForTargetData}

       IMPORTANTE: Es crucial que la respuesta debe cumplir con el siguiente formato:
       {format}
       donde en la parte de "script" quiero que adjuntes el script y en la parte de "scriptExplication"
       quiero que incluyas un informe detallado sobre la migración y validación de datos.
       
       IMPORTANTE: No uses formato Markdown ni comillas triples. Solo devuelve JSON puro ajustado al formato especificado.
       \s""";

    SystemMessage systemMessage =
        (SystemMessage)
            new SystemPromptTemplate(systemString)
                .createMessage(
                    Map.of(
                        "sourceDatabaseType",
                        promptInfo.getSourceDatabaseType(),
                        "targetDatabaseType",
                        promptInfo.getTargetDatabaseType(),
                        "scriptForTargetData",
                        scriptForTargetData,
                        "format",
                        getFormatConverter().getFormat(),
                        "databaseSchema",
                        promptInfo.getDatabaseSchema(),
                        "migrationRequirements",
                        promptInfo.getMigrationRequirements()));

    String userString =
        """
    Debes validar la migración de datos y esquema de una base de datos {sourceDatabaseType} a una base de datos {targetDatabaseType}.
    La validación de los datos debe comprobar no sólo que los datos se hayan migrado bien,
    sino también que las consultas a la base de datos que haya podido especificar el usuario en {applicationRequirements}
    se pueden ejecutar correctamente en la base de datos destino.

    A continuación, se detallan los parámetros específicos para la validación de la migración:

    - Esquema {sourceDatabaseType} original: {databaseSchema}
    - Requisitos y restricciones de la migración: {migrationRequirements}
    - Requisitos de la aplicación: {applicationRequirements}

    Genera un script para validar la migración de datos y esquema a la base de datos {targetDatabaseType} siguiendo las especificaciones proporcionadas anteriormente.
    """;

    UserMessage userMessage =
        (UserMessage)
            new PromptTemplate(userString)
                .createMessage(
                    Map.of(
                        "sourceDatabaseType",
                        promptInfo.getSourceDatabaseType(),
                        "targetDatabaseType",
                        promptInfo.getTargetDatabaseType(),
                        "databaseSchema",
                        promptInfo.getDatabaseSchema(),
                        "migrationRequirements",
                        promptInfo.getMigrationRequirements(),
                        "applicationRequirements",
                        promptInfo.getApplicationRequirements()));

    return new Prompt(List.of(systemMessage, userMessage));
  }
}
