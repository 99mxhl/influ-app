import 'package:flutter/foundation.dart';

/// Exception thrown when API returns an error or response is malformed.
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  ApiException({
    required this.message,
    this.statusCode,
    this.data,
  });

  @override
  String toString() => message;

  factory ApiException.fromResponse(Map<String, dynamic> json, int? statusCode) {
    final error = json['error'];
    String message;
    if (error is String) {
      message = _sanitizeErrorMessage(error);
    } else if (error is Map) {
      message = _sanitizeErrorMessage(error['message']?.toString() ?? 'Unknown error occurred');
    } else {
      message = 'Unknown error occurred';
    }
    return ApiException(
      message: message,
      statusCode: statusCode,
      data: json,
    );
  }

  /// Parses validation errors from backend response.
  /// Returns a map of field names to error messages.
  static Map<String, String> parseValidationErrors(Map<String, dynamic> json) {
    final error = json['error'];
    if (error is Map && error['details'] is Map) {
      final details = error['details'] as Map;
      return details.map((key, value) => MapEntry(
        key.toString(),
        _sanitizeErrorMessage(value?.toString() ?? 'Invalid value'),
      ));
    }
    return {};
  }
}

/// Sanitizes error messages to prevent XSS-like content.
/// Strips HTML tags and limits length.
String _sanitizeErrorMessage(String message) {
  // Remove HTML tags
  final stripped = message.replaceAll(RegExp(r'<[^>]*>'), '');
  // Limit length
  if (stripped.length > 500) {
    return '${stripped.substring(0, 500)}...';
  }
  return stripped;
}

String _extractErrorMessage(dynamic error) {
  if (error is String) return _sanitizeErrorMessage(error);
  if (error is Map) {
    return _sanitizeErrorMessage(error['message']?.toString() ?? 'Request failed');
  }
  return 'Request failed';
}

/// Validates that [json] has the expected API response structure.
/// Throws [ApiException] if malformed.
void _validateResponseStructure(Map<String, dynamic> json) {
  if (!json.containsKey('success')) {
    throw ApiException(
      message: 'Invalid API response: missing success field',
      data: json,
    );
  }
  if (json['success'] != true && json['success'] != false) {
    throw ApiException(
      message: 'Invalid API response: success must be boolean',
      data: json,
    );
  }
}

/// Parses a successful API response with a single data object.
///
/// Validates response structure and catches parsing errors.
/// Throws [ApiException] on failure.
T parseApiResponse<T>(
  Map<String, dynamic> json,
  T Function(dynamic data) parser,
) {
  try {
    _validateResponseStructure(json);

    if (json['success'] == true) {
      if (!json.containsKey('data')) {
        throw ApiException(
          message: 'Invalid API response: missing data field',
          data: json,
        );
      }
      return parser(json['data']);
    } else {
      throw ApiException(
        message: _extractErrorMessage(json['error']),
        data: json,
      );
    }
  } on ApiException {
    rethrow;
  } on TypeError catch (e) {
    if (kDebugMode) {
      debugPrint('API response type error: $e');
    }
    throw ApiException(
      message: 'Invalid response format from server',
      data: json,
    );
  } catch (e) {
    if (kDebugMode) {
      debugPrint('API response parsing error: $e');
    }
    throw ApiException(
      message: 'Failed to parse server response',
      data: json,
    );
  }
}

/// Parses a successful API response with a list of data objects.
///
/// Validates response structure and catches parsing errors.
/// Throws [ApiException] on failure.
List<T> parseApiResponseList<T>(
  Map<String, dynamic> json,
  T Function(Map<String, dynamic>) parser,
) {
  try {
    _validateResponseStructure(json);

    if (json['success'] == true) {
      final data = json['data'];
      if (data == null) {
        return [];
      }
      if (data is! List) {
        throw ApiException(
          message: 'Invalid API response: data must be a list',
          data: json,
        );
      }
      // Validate list doesn't exceed reasonable size
      if (data.length > 10000) {
        throw ApiException(
          message: 'Response too large',
          data: {'itemCount': data.length},
        );
      }
      return data.map((e) {
        if (e is! Map<String, dynamic>) {
          throw ApiException(
            message: 'Invalid item in response list',
            data: e,
          );
        }
        return parser(e);
      }).toList();
    } else {
      throw ApiException(
        message: _extractErrorMessage(json['error']),
        data: json,
      );
    }
  } on ApiException {
    rethrow;
  } on TypeError catch (e) {
    if (kDebugMode) {
      debugPrint('API response list type error: $e');
    }
    throw ApiException(
      message: 'Invalid response format from server',
      data: json,
    );
  } catch (e) {
    if (kDebugMode) {
      debugPrint('API response list parsing error: $e');
    }
    throw ApiException(
      message: 'Failed to parse server response',
      data: json,
    );
  }
}

/// Safely parses an optional field from a map.
/// Returns null if field is missing or wrong type.
T? safeParseField<T>(Map<String, dynamic> json, String field) {
  final value = json[field];
  if (value is T) return value;
  return null;
}

/// Safely parses a required field from a map.
/// Throws [ApiException] if field is missing or wrong type.
T requireField<T>(Map<String, dynamic> json, String field) {
  final value = json[field];
  if (value is T) return value;
  throw ApiException(
    message: 'Missing or invalid field: $field',
    data: json,
  );
}
