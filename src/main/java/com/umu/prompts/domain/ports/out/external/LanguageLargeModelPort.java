package com.umu.prompts.domain.ports.out.external;

import com.umu.prompts.infrastructure.api.rest.model.MigrationRequestDTO;
import com.umu.prompts.infrastructure.api.rest.model.MigrationResponseDTO;

public interface LanguageLargeModelPort {
  /**
   * Método para enviar peticiones a la API de ChatGPT
   *F
   * @param promptInfo - Esta variable almacena la información para completar la promptTemplate
   * @return Retorna una cadena de texto que contiene únicamente el texto de la migración del
   *     esquema requerida
   */
  MigrationResponseDTO migrateDatabase(MigrationRequestDTO promptInfo);
}
