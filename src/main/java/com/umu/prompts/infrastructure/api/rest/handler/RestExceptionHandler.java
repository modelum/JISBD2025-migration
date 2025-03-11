package com.umu.prompts.infrastructure.api.rest.handler;

import com.umu.prompts.infrastructure.api.rest.model.ProblemDetail;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.context.request.WebRequest;

@RestControllerAdvice
public class RestExceptionHandler {

  @ExceptionHandler({IllegalArgumentException.class})
  public ResponseEntity<Object> handleIllegalArgumentException(
      IllegalArgumentException ex, WebRequest request) {
    return createResponseEntity(
        HttpStatus.BAD_REQUEST.value(),
        createProblemDetail(
            HttpStatus.BAD_REQUEST.value(),
            "Illegal Argument",
            ex.getMessage(),
            request.getDescription(false)));
  }

  private ProblemDetail createProblemDetail(
      Integer status, String title, String detail, String instance) {
    ProblemDetail problemDetail = new ProblemDetail();
    problemDetail.setTitle(title);
    problemDetail.setStatus(status);
    problemDetail.setDetail(detail);
    problemDetail.setInstance(instance);
    return problemDetail;
  }

  private ResponseEntity<Object> createResponseEntity(Integer status, ProblemDetail errorDto) {
    return ResponseEntity.status(status)
        .header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_PROBLEM_JSON_VALUE)
        .body(errorDto);
  }
}
