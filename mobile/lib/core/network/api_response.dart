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
      message = error;
    } else if (error is Map) {
      message = error['message'] ?? 'Unknown error occurred';
    } else {
      message = 'Unknown error occurred';
    }
    return ApiException(
      message: message,
      statusCode: statusCode,
      data: json,
    );
  }
}

String _extractErrorMessage(dynamic error) {
  if (error is String) return error;
  if (error is Map) return error['message'] ?? 'Request failed';
  return 'Request failed';
}

T parseApiResponse<T>(
  Map<String, dynamic> json,
  T Function(dynamic data) parser,
) {
  if (json['success'] == true) {
    return parser(json['data']);
  } else {
    throw ApiException(
      message: _extractErrorMessage(json['error']),
      data: json,
    );
  }
}

List<T> parseApiResponseList<T>(
  Map<String, dynamic> json,
  T Function(Map<String, dynamic>) parser,
) {
  if (json['success'] == true) {
    final data = json['data'] as List;
    return data.map((e) => parser(e as Map<String, dynamic>)).toList();
  } else {
    throw ApiException(
      message: _extractErrorMessage(json['error']),
      data: json,
    );
  }
}
