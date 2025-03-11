package com.umu.prompts.infrastructure.api.rest.model;

import java.net.URI;
import java.util.Objects;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonValue;
import com.umu.prompts.infrastructure.api.rest.model.DataBaseTypeDTO;
import org.openapitools.jackson.nullable.JsonNullable;
import java.time.OffsetDateTime;
import jakarta.validation.Valid;
import jakarta.validation.constraints.*;
import io.swagger.v3.oas.annotations.media.Schema;


import java.util.*;
import jakarta.annotation.Generated;

/**
 * MigrationRequestDTO
 */

@Generated(value = "org.openapitools.codegen.languages.SpringCodegen", date = "2025-03-11T17:59:49.331557300+01:00[Europe/Madrid]", comments = "Generator version: 7.7.0")
public class MigrationRequestDTO {

  private DataBaseTypeDTO sourceDatabaseType;

  private DataBaseTypeDTO targetDatabaseType;

  private String applicationRequirements;

  private String applicationArchitecture;

  private String underlyingTechnologies;

  private String databaseSchema;

  private String databaseDocuments;

  private String migrationRequirements;

  public MigrationRequestDTO() {
    super();
  }

  /**
   * Constructor with only required parameters
   */
  public MigrationRequestDTO(DataBaseTypeDTO sourceDatabaseType, DataBaseTypeDTO targetDatabaseType, String applicationRequirements, String applicationArchitecture, String underlyingTechnologies, String databaseSchema, String migrationRequirements) {
    this.sourceDatabaseType = sourceDatabaseType;
    this.targetDatabaseType = targetDatabaseType;
    this.applicationRequirements = applicationRequirements;
    this.applicationArchitecture = applicationArchitecture;
    this.underlyingTechnologies = underlyingTechnologies;
    this.databaseSchema = databaseSchema;
    this.migrationRequirements = migrationRequirements;
  }

  public MigrationRequestDTO sourceDatabaseType(DataBaseTypeDTO sourceDatabaseType) {
    this.sourceDatabaseType = sourceDatabaseType;
    return this;
  }

  /**
   * Get sourceDatabaseType
   * @return sourceDatabaseType
   */
  @NotNull @Valid 
  @Schema(name = "sourceDatabaseType", requiredMode = Schema.RequiredMode.REQUIRED)
  @JsonProperty("sourceDatabaseType")
  public DataBaseTypeDTO getSourceDatabaseType() {
    return sourceDatabaseType;
  }

  public void setSourceDatabaseType(DataBaseTypeDTO sourceDatabaseType) {
    this.sourceDatabaseType = sourceDatabaseType;
  }

  public MigrationRequestDTO targetDatabaseType(DataBaseTypeDTO targetDatabaseType) {
    this.targetDatabaseType = targetDatabaseType;
    return this;
  }

  /**
   * Get targetDatabaseType
   * @return targetDatabaseType
   */
  @NotNull @Valid 
  @Schema(name = "targetDatabaseType", requiredMode = Schema.RequiredMode.REQUIRED)
  @JsonProperty("targetDatabaseType")
  public DataBaseTypeDTO getTargetDatabaseType() {
    return targetDatabaseType;
  }

  public void setTargetDatabaseType(DataBaseTypeDTO targetDatabaseType) {
    this.targetDatabaseType = targetDatabaseType;
  }

  public MigrationRequestDTO applicationRequirements(String applicationRequirements) {
    this.applicationRequirements = applicationRequirements;
    return this;
  }

  /**
   * The requirements of the application as the operations that the application supports and the queries that it executes
   * @return applicationRequirements
   */
  @NotNull 
  @Schema(name = "applicationRequirements", description = "The requirements of the application as the operations that the application supports and the queries that it executes", requiredMode = Schema.RequiredMode.REQUIRED)
  @JsonProperty("applicationRequirements")
  public String getApplicationRequirements() {
    return applicationRequirements;
  }

  public void setApplicationRequirements(String applicationRequirements) {
    this.applicationRequirements = applicationRequirements;
  }

  public MigrationRequestDTO applicationArchitecture(String applicationArchitecture) {
    this.applicationArchitecture = applicationArchitecture;
    return this;
  }

  /**
   * The architecture of the application
   * @return applicationArchitecture
   */
  @NotNull 
  @Schema(name = "applicationArchitecture", description = "The architecture of the application", requiredMode = Schema.RequiredMode.REQUIRED)
  @JsonProperty("applicationArchitecture")
  public String getApplicationArchitecture() {
    return applicationArchitecture;
  }

  public void setApplicationArchitecture(String applicationArchitecture) {
    this.applicationArchitecture = applicationArchitecture;
  }

  public MigrationRequestDTO underlyingTechnologies(String underlyingTechnologies) {
    this.underlyingTechnologies = underlyingTechnologies;
    return this;
  }

  /**
   * The technologies used to build the application
   * @return underlyingTechnologies
   */
  @NotNull 
  @Schema(name = "underlyingTechnologies", description = "The technologies used to build the application", requiredMode = Schema.RequiredMode.REQUIRED)
  @JsonProperty("underlyingTechnologies")
  public String getUnderlyingTechnologies() {
    return underlyingTechnologies;
  }

  public void setUnderlyingTechnologies(String underlyingTechnologies) {
    this.underlyingTechnologies = underlyingTechnologies;
  }

  public MigrationRequestDTO databaseSchema(String databaseSchema) {
    this.databaseSchema = databaseSchema;
    return this;
  }

  /**
   * The schema of the database.
   * @return databaseSchema
   */
  @NotNull 
  @Schema(name = "databaseSchema", description = "The schema of the database.", requiredMode = Schema.RequiredMode.REQUIRED)
  @JsonProperty("databaseSchema")
  public String getDatabaseSchema() {
    return databaseSchema;
  }

  public void setDatabaseSchema(String databaseSchema) {
    this.databaseSchema = databaseSchema;
  }

  public MigrationRequestDTO databaseDocuments(String databaseDocuments) {
    this.databaseDocuments = databaseDocuments;
    return this;
  }

  /**
   * examples of the documents in the database
   * @return databaseDocuments
   */
  
  @Schema(name = "databaseDocuments", description = "examples of the documents in the database", requiredMode = Schema.RequiredMode.NOT_REQUIRED)
  @JsonProperty("databaseDocuments")
  public String getDatabaseDocuments() {
    return databaseDocuments;
  }

  public void setDatabaseDocuments(String databaseDocuments) {
    this.databaseDocuments = databaseDocuments;
  }

  public MigrationRequestDTO migrationRequirements(String migrationRequirements) {
    this.migrationRequirements = migrationRequirements;
    return this;
  }

  /**
   * The requirements to migrate the database
   * @return migrationRequirements
   */
  @NotNull 
  @Schema(name = "migrationRequirements", description = "The requirements to migrate the database", requiredMode = Schema.RequiredMode.REQUIRED)
  @JsonProperty("migrationRequirements")
  public String getMigrationRequirements() {
    return migrationRequirements;
  }

  public void setMigrationRequirements(String migrationRequirements) {
    this.migrationRequirements = migrationRequirements;
  }

  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }
    MigrationRequestDTO migrationRequestDTO = (MigrationRequestDTO) o;
    return Objects.equals(this.sourceDatabaseType, migrationRequestDTO.sourceDatabaseType) &&
        Objects.equals(this.targetDatabaseType, migrationRequestDTO.targetDatabaseType) &&
        Objects.equals(this.applicationRequirements, migrationRequestDTO.applicationRequirements) &&
        Objects.equals(this.applicationArchitecture, migrationRequestDTO.applicationArchitecture) &&
        Objects.equals(this.underlyingTechnologies, migrationRequestDTO.underlyingTechnologies) &&
        Objects.equals(this.databaseSchema, migrationRequestDTO.databaseSchema) &&
        Objects.equals(this.databaseDocuments, migrationRequestDTO.databaseDocuments) &&
        Objects.equals(this.migrationRequirements, migrationRequestDTO.migrationRequirements);
  }

  @Override
  public int hashCode() {
    return Objects.hash(sourceDatabaseType, targetDatabaseType, applicationRequirements, applicationArchitecture, underlyingTechnologies, databaseSchema, databaseDocuments, migrationRequirements);
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder();
    sb.append("class MigrationRequestDTO {\n");
    sb.append("    sourceDatabaseType: ").append(toIndentedString(sourceDatabaseType)).append("\n");
    sb.append("    targetDatabaseType: ").append(toIndentedString(targetDatabaseType)).append("\n");
    sb.append("    applicationRequirements: ").append(toIndentedString(applicationRequirements)).append("\n");
    sb.append("    applicationArchitecture: ").append(toIndentedString(applicationArchitecture)).append("\n");
    sb.append("    underlyingTechnologies: ").append(toIndentedString(underlyingTechnologies)).append("\n");
    sb.append("    databaseSchema: ").append(toIndentedString(databaseSchema)).append("\n");
    sb.append("    databaseDocuments: ").append(toIndentedString(databaseDocuments)).append("\n");
    sb.append("    migrationRequirements: ").append(toIndentedString(migrationRequirements)).append("\n");
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

