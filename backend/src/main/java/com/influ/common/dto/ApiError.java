package com.influ.common.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Builder;
import lombok.Getter;

import java.util.Map;

@Getter
@Builder
@JsonInclude(JsonInclude.Include.NON_NULL)
public class ApiError {

    private final String code;
    private final String message;
    private final Map<String, String> details;

    public static ApiError of(String code, String message) {
        return ApiError.builder()
                .code(code)
                .message(message)
                .build();
    }

    public static ApiError of(String code, String message, Map<String, String> details) {
        return ApiError.builder()
                .code(code)
                .message(message)
                .details(details)
                .build();
    }
}
