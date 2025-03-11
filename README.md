# Puesta en marcha

Para ejecutar el proyecto, es necesario tener instalado Java 17 y Maven. A continuación, se detallan los pasos para ejecutar el proyecto:

1. Clonar el repositorio:

2. Configurar la variable de entorno `OPENAI_API_KEY` con la clave de la API de OpenAI.
3. Ejecutar el siguiente comando en la raíz del proyecto para compilar y construir el proyecto:

```bash
mvn clean install
```

4. Ejecutar el siguiente comando para ejecutar el proyecto:

```bash
mvn spring-boot:run
```

# Desarrollo de un API REST con Spring Boot y OpenAI

Este proyecto está estructurado mediante el uso de una arquitectura hexagonal, es decir: se divide en capas, donde cada una tiene una responsabilidad específica. La capa de dominio contiene las clases, la capa de aplicación contiene los servicios con los distintos casos de uso y la capa de infraestructura contiene los adaptadores de entrada (Controlador REST) y los puertos de salida de nuestra aplicación (Api que proporciona OpenAI para interactuar con sus modelos).

En este caso, puesto que no tenemos lógica de negocio sino que la principa lógica se encuentra en el modelo de OpenAI, la capa de aplicación se reduce a un único servicio que se encarga de interactuar con el modelo de OpenAI, por otro lado, la capa de dominio no tiene definida ninguna clase que pueda resultar de interés para el usuario, por lo que la capa de infraestructura es la que más interés tiene.

Comencemos explicando desde la capa de infraestructura:

En esta capa encontramos dos módulos, el primero es el controlador REST (./infrastructure/api) que se encarga de recibir las peticiones HTTP y llamar al servicio de la capa de aplicación, el segundo módulo es el adaptador de salida que se encarga de interactuar con el modelo de OpenAI (./infrastructure/external).

**Controlador REST**

El controlador REST se encuentra en el paquete `com.umu.prompts.infrastructure.api.rest.controller` y contiene un único controlador llamado `MigrationController` que se encarga de recibir las peticiones HTTP y llamar al servicio de la capa de aplicación.

```java

@RequiredArgsConstructor
@RestController
public class MigrationController implements MigrationApi {

  private final MigrateDatabaseUseCase migrateDatabaseUseCase;

  @Override
  @PostMapping("/api/v1/migrations")
  public ResponseEntity<MigrationResponseDTO> migrateDatabase(@RequestBody MigrationRequestDTO migrationRequestDTO) {
    return ResponseEntity.ok(migrateDatabaseUseCase.migrateDatabase(migrationRequestDTO));
  }
}
```

Como podemos ver en el código anterior, el controlador recibe una petición POST en la ruta `/api/v1/migrations` y llama al servicio `migrateDatabaseUseCase` pasándole el objeto `migrationRequestDTO` que contiene los datos necesarios para realizar la migración de la base de datos.

Posteriormente, el controlador devuelve una respuesta HTTP con el objeto `MigrationResponseDTO` que contiene el resultado de la migración.

En cuanto al servicio de la capa de aplicación, se encuentra en el paquete `com.umu.prompts.application.usecase` y contiene un único servicio llamado `MigrateDatabaseUseCase` que se encarga de realizar la migración de la base de datos.

```java

@Service
@RequiredArgsConstructor
public class MigrateDatabaseUseCaseImpl implements MigrateDatabaseUseCase {

  private final LanguageLargeModelPort languageLargeModelPort;

  @Override
  public MigrationResponseDTO migrateDatabase(MigrationRequestDTO specification) {
    return languageLargeModelPort.migrateDatabase(specification);
  }
}
```

el cual hace la llamada al puerto de salida `languageLargeModelPort` pasándole el objeto `specification` que contiene los datos necesarios para realizar la migración de la base de datos.

Aunque puede resultar redundante esta estructura para un proyecto tan simple, es importante tener en cuenta que esta arquitectura es escalable y facilita la incorporación de nuevas funcionalidades en el futuro como por ejemplo un servicio de autovalidación de migración de esquema utilizando también el modelo de OpenAI o el modelo especificado por el usuario lo cual es uno de los objetivos de este proyecto.

En esta fase incipiente del proyecto y como se puede ver en el fichero `application.yml` se ha configurado el puerto de salida para que se comunique con el modelo de OpenAI.

```yaml
spring:
  application:
    name: spring-migration-AI-api

  ai:
    openai:
      api-key: ${OPENAI_API_KEY} # Variable de entorno
      chat:
        options:
          model: gpt-4o-mini # Modelo
          temperature: 0.5 # Ajusta la creatividad
```

Por último, en el adaptador de salida `LanguageLargeModelAdapter` se encuentra la lógica de comunicación con el modelo de OpenAI.

```java

@RequiredArgsConstructor
@Component
public final class LanguageLargeModelAdapter implements LanguageLargeModelPort {

  private final ChatClient chatClient;
  private final ChatMemory chatMemory;

  @Override
  public MigrationResponseDTO migrateDatabase(MigrationRequestDTO promptInfo) {

    String conversationId = UUID.randomUUID().toString();

    // La memoria se recupera y se añade como una colección de mensajes al prompt
    Advisor advisor = new MessageChatMemoryAdvisor(chatMemory);

    // Contexto
    Prompt promptToContext = PromptBuilder.buildContextualPrompt(promptInfo);
    this.chatClient.prompt(promptToContext).call();
    chatMemory.add(conversationId, promptToContext.getInstructions());

    // Paso 1: Migración del esquema
    Prompt promptToMigrateSchema = PromptBuilder.buildFirstPromptToMigrateSchema(promptInfo);
    FormatMigrationResponse responseForMigrateSchema =
        PromptBuilder.getFormatConverter()
            .convert(
                Objects.requireNonNull(
                    this.chatClient
                        .prompt(promptToMigrateSchema)
                        .advisors(advisor)
                        .call()
                        .content()));

    chatMemory.add(conversationId, promptToMigrateSchema.getInstructions());

    Prompt promptToValidateSchema =
        PromptBuilder.buildPromptToValidateSchema(promptInfo, responseForMigrateSchema.script());
    String guidelinesForValidateSchema =
        this.chatClient.prompt(promptToValidateSchema).advisors(advisor).call().content();
    chatMemory.add(conversationId, promptToValidateSchema.getInstructions());

    // Paso 2: Migración de los datos
    Prompt promptToMigrateData =
        PromptBuilder.buildSecondPromptToMigrateData(promptInfo, responseForMigrateSchema.script());
    FormatMigrationResponse responseForMigrateData =
        PromptBuilder.getFormatConverter()
            .convert(
                Objects.requireNonNull(
                    this.chatClient
                        .prompt(promptToMigrateData)
                        .advisors(advisor)
                        .call()
                        .content()));
    chatMemory.add(conversationId, promptToMigrateData.getInstructions());

    // Paso 3: Validación de la migración de datos
    Prompt promptToValidateMigration =
        PromptBuilder.buildThirdPromptToValidateMigration(
            promptInfo, responseForMigrateData.script());
    FormatMigrationResponse scriptForValidation =
        PromptBuilder.getFormatConverter()
            .convert(
                Objects.requireNonNull(
                    this.chatClient
                        .prompt(promptToValidateMigration)
                        .advisors(advisor)
                        .call()
                        .content()));

    // Vacíamos la memoria
    chatMemory.clear(conversationId);

    return new MigrationResponseDTO(
        responseForMigrateSchema.script(),
        responseForMigrateSchema.scriptExplication(),
        guidelinesForValidateSchema,
        responseForMigrateData.script(),
        responseForMigrateData.scriptExplication(),
        scriptForValidation.script(),
        scriptForValidation.scriptExplication());
  }
}
```

En este adaptador se realiza la comunicación con el modelo de OpenAI mediante el cliente `ChatClient` y se construyen los distintos `Prompt` que se le pasan al modelo para obtener las respuestas necesarias para realizar la migración de la base de datos utilizando la clase `PromptBuilder` en la cual especificamos los distintos prompts y el formato de salida de las respuestas del modelo gpt-4o-mini de OpenAI.
