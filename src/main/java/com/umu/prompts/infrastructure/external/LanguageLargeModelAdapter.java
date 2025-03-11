package com.umu.prompts.infrastructure.external;

import com.umu.prompts.domain.ports.out.external.LanguageLargeModelPort;
import com.umu.prompts.infrastructure.api.rest.model.MigrationRequestDTO;
import com.umu.prompts.infrastructure.api.rest.model.MigrationResponseDTO;
import com.umu.prompts.infrastructure.external.builder.PromptBuilder;
import com.umu.prompts.infrastructure.external.format.FormatMigrationResponse;
import java.util.Objects;
import java.util.UUID;
import lombok.RequiredArgsConstructor;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.chat.client.advisor.MessageChatMemoryAdvisor;
import org.springframework.ai.chat.client.advisor.api.Advisor;
import org.springframework.ai.chat.memory.ChatMemory;
import org.springframework.ai.chat.prompt.Prompt;
import org.springframework.stereotype.Component;

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
