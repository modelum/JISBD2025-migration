package com.umu.prompts.infrastructure.api.rest.controller;

import com.umu.prompts.domain.ports.usecases.MigrateDatabaseUseCase;
import com.umu.prompts.infrastructure.api.rest.MigrationApi;
import com.umu.prompts.infrastructure.api.rest.model.MigrationRequestDTO;
import com.umu.prompts.infrastructure.api.rest.model.MigrationResponseDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

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
