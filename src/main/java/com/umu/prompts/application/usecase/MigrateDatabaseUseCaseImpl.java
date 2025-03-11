package com.umu.prompts.application.usecase;

import com.umu.prompts.domain.ports.out.external.LanguageLargeModelPort;
import com.umu.prompts.domain.ports.usecases.MigrateDatabaseUseCase;
import com.umu.prompts.infrastructure.api.rest.model.MigrationRequestDTO;
import com.umu.prompts.infrastructure.api.rest.model.MigrationResponseDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class MigrateDatabaseUseCaseImpl implements MigrateDatabaseUseCase {

  private final LanguageLargeModelPort languageLargeModelPort;

  @Override
  public MigrationResponseDTO migrateDatabase(MigrationRequestDTO specification) {
    return languageLargeModelPort.migrateDatabase(specification);
  }
}
