package com.umu.prompts.domain.ports.usecases;

import com.umu.prompts.infrastructure.api.rest.model.MigrationRequestDTO;
import com.umu.prompts.infrastructure.api.rest.model.MigrationResponseDTO;

public interface MigrateDatabaseUseCase {

  MigrationResponseDTO migrateDatabase(
          MigrationRequestDTO specification);
}
