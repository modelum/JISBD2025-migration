package com.umu.prompts.infrastructure.api.rest.model;

import java.net.URI;
import java.util.Objects;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonCreator;
import org.openapitools.jackson.nullable.JsonNullable;
import java.time.OffsetDateTime;
import jakarta.validation.Valid;
import jakarta.validation.constraints.*;
import io.swagger.v3.oas.annotations.media.Schema;


import java.util.*;
import jakarta.annotation.Generated;

/**
 * MigrationResponseDTO
 */

@Generated(value = "org.openapitools.codegen.languages.SpringCodegen", date = "2025-03-11T17:59:49.331557300+01:00[Europe/Madrid]", comments = "Generator version: 7.7.0")
public class MigrationResponseDTO {

  private String scriptForMigrateSchema;

  private String metadataForMigrateSchema;

  private String guidelinesForValidateSchema;

  private String scriptForDataMigration;

  private String metadataForDataMigration;

  private String scriptForDataValidation;

  private String metadataForDataValidation;

  public MigrationResponseDTO() {
    super();
  }

  /**
   * Constructor with only required parameters
   */
  public MigrationResponseDTO(String scriptForMigrateSchema, String metadataForMigrateSchema, String guidelinesForValidateSchema, String scriptForDataMigration, String metadataForDataMigration, String scriptForDataValidation, String metadataForDataValidation) {
    this.scriptForMigrateSchema = scriptForMigrateSchema;
    this.metadataForMigrateSchema = metadataForMigrateSchema;
    this.guidelinesForValidateSchema = guidelinesForValidateSchema;
    this.scriptForDataMigration = scriptForDataMigration;
    this.metadataForDataMigration = metadataForDataMigration;
    this.scriptForDataValidation = scriptForDataValidation;
    this.metadataForDataValidation = metadataForDataValidation;
  }

  public MigrationResponseDTO scriptForMigrateSchema(String scriptForMigrateSchema) {
    this.scriptForMigrateSchema = scriptForMigrateSchema;
    return this;
  }

  /**
   * The script to migrate the schema
   * @return scriptForMigrateSchema
   */
  @NotNull 
  @Schema(name = "scriptForMigrateSchema", description = "The script to migrate the schema", requiredMode = Schema.RequiredMode.REQUIRED)
  @JsonProperty("scriptForMigrateSchema")
  public String getScriptForMigrateSchema() {
    return scriptForMigrateSchema;
  }

  public void setScriptForMigrateSchema(String scriptForMigrateSchema) {
    this.scriptForMigrateSchema = scriptForMigrateSchema;
  }

  public MigrationResponseDTO metadataForMigrateSchema(String metadataForMigrateSchema) {
    this.metadataForMigrateSchema = metadataForMigrateSchema;
    return this;
  }

  /**
   * Information about the schema migration
   * @return metadataForMigrateSchema
   */
  @NotNull 
  @Schema(name = "metadataForMigrateSchema", description = "Information about the schema migration", requiredMode = Schema.RequiredMode.REQUIRED)
  @JsonProperty("metadataForMigrateSchema")
  public String getMetadataForMigrateSchema() {
    return metadataForMigrateSchema;
  }

  public void setMetadataForMigrateSchema(String metadataForMigrateSchema) {
    this.metadataForMigrateSchema = metadataForMigrateSchema;
  }

  public MigrationResponseDTO guidelinesForValidateSchema(String guidelinesForValidateSchema) {
    this.guidelinesForValidateSchema = guidelinesForValidateSchema;
    return this;
  }

  /**
   * Guidelines to validate the schema migration
   * @return guidelinesForValidateSchema
   */
  @NotNull 
  @Schema(name = "guidelinesForValidateSchema", description = "Guidelines to validate the schema migration", requiredMode = Schema.RequiredMode.REQUIRED)
  @JsonProperty("guidelinesForValidateSchema")
  public String getGuidelinesForValidateSchema() {
    return guidelinesForValidateSchema;
  }

  public void setGuidelinesForValidateSchema(String guidelinesForValidateSchema) {
    this.guidelinesForValidateSchema = guidelinesForValidateSchema;
  }

  public MigrationResponseDTO scriptForDataMigration(String scriptForDataMigration) {
    this.scriptForDataMigration = scriptForDataMigration;
    return this;
  }

  /**
   * The script to migrate the data stored in the database
   * @return scriptForDataMigration
   */
  @NotNull 
  @Schema(name = "scriptForDataMigration", description = "The script to migrate the data stored in the database", requiredMode = Schema.RequiredMode.REQUIRED)
  @JsonProperty("scriptForDataMigration")
  public String getScriptForDataMigration() {
    return scriptForDataMigration;
  }

  public void setScriptForDataMigration(String scriptForDataMigration) {
    this.scriptForDataMigration = scriptForDataMigration;
  }

  public MigrationResponseDTO metadataForDataMigration(String metadataForDataMigration) {
    this.metadataForDataMigration = metadataForDataMigration;
    return this;
  }

  /**
   * Information about the data migration
   * @return metadataForDataMigration
   */
  @NotNull 
  @Schema(name = "metadataForDataMigration", description = "Information about the data migration", requiredMode = Schema.RequiredMode.REQUIRED)
  @JsonProperty("metadataForDataMigration")
  public String getMetadataForDataMigration() {
    return metadataForDataMigration;
  }

  public void setMetadataForDataMigration(String metadataForDataMigration) {
    this.metadataForDataMigration = metadataForDataMigration;
  }

  public MigrationResponseDTO scriptForDataValidation(String scriptForDataValidation) {
    this.scriptForDataValidation = scriptForDataValidation;
    return this;
  }

  /**
   * The script to validate the data migration
   * @return scriptForDataValidation
   */
  @NotNull 
  @Schema(name = "scriptForDataValidation", description = "The script to validate the data migration", requiredMode = Schema.RequiredMode.REQUIRED)
  @JsonProperty("scriptForDataValidation")
  public String getScriptForDataValidation() {
    return scriptForDataValidation;
  }

  public void setScriptForDataValidation(String scriptForDataValidation) {
    this.scriptForDataValidation = scriptForDataValidation;
  }

  public MigrationResponseDTO metadataForDataValidation(String metadataForDataValidation) {
    this.metadataForDataValidation = metadataForDataValidation;
    return this;
  }

  /**
   * Information about the data validation
   * @return metadataForDataValidation
   */
  @NotNull 
  @Schema(name = "metadataForDataValidation", description = "Information about the data validation", requiredMode = Schema.RequiredMode.REQUIRED)
  @JsonProperty("metadataForDataValidation")
  public String getMetadataForDataValidation() {
    return metadataForDataValidation;
  }

  public void setMetadataForDataValidation(String metadataForDataValidation) {
    this.metadataForDataValidation = metadataForDataValidation;
  }

  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    MigrationResponseDTO migrationResponseDTO = (MigrationResponseDTO) o;
    return Objects.equals(this.scriptForMigrateSchema, migrationResponseDTO.scriptForMigrateSchema) &&
        Objects.equals(this.metadataForMigrateSchema, migrationResponseDTO.metadataForMigrateSchema) &&
        Objects.equals(this.guidelinesForValidateSchema, migrationResponseDTO.guidelinesForValidateSchema) &&
        Objects.equals(this.scriptForDataMigration, migrationResponseDTO.scriptForDataMigration) &&
        Objects.equals(this.metadataForDataMigration, migrationResponseDTO.metadataForDataMigration) &&
        Objects.equals(this.scriptForDataValidation, migrationResponseDTO.scriptForDataValidation) &&
        Objects.equals(this.metadataForDataValidation, migrationResponseDTO.metadataForDataValidation);
  }

  @Override
  public int hashCode() {
    return Objects.hash(scriptForMigrateSchema, metadataForMigrateSchema, guidelinesForValidateSchema, scriptForDataMigration, metadataForDataMigration, scriptForDataValidation, metadataForDataValidation);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class MigrationResponseDTO {\n");
    sb.append("    scriptForMigrateSchema: ").append(toIndentedString(scriptForMigrateSchema)).append("\n");
    sb.append("    metadataForMigrateSchema: ").append(toIndentedString(metadataForMigrateSchema)).append("\n");
    sb.append("    guidelinesForValidateSchema: ").append(toIndentedString(guidelinesForValidateSchema)).append("\n");
    sb.append("    scriptForDataMigration: ").append(toIndentedString(scriptForDataMigration)).append("\n");
    sb.append("    metadataForDataMigration: ").append(toIndentedString(metadataForDataMigration)).append("\n");
    sb.append("    scriptForDataValidation: ").append(toIndentedString(scriptForDataValidation)).append("\n");
    sb.append("    metadataForDataValidation: ").append(toIndentedString(metadataForDataValidation)).append("\n");
    sb.append("}");
    return sb.toString();
  }

  /**
   * Convert the given object to string with each line indented by 4 spaces
   * (except the first line).
   */
  private String toIndentedString(Object o) {
    if (o == null) {
      return "null";
    }
    return o.toString().replace("\n", "\n    ");
  }
}

