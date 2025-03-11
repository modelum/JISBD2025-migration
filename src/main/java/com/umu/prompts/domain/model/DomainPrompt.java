package com.umu.prompts.domain.model;

import com.umu.prompts.domain.model.enums.DataBaseType;
import java.util.UUID;
import lombok.Builder;

@Builder
public record DomainPrompt(
    UUID id,
    DataBaseType sourceDataBaseType,
    DataBaseType targetDataBaseType,
    String sourceDataBaseSchema,
    String specification) {}
