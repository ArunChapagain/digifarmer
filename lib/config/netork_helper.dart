abstract class ApiResults {
  int? statusCode;
}

class ApiSuccess extends ApiResults {
  final dynamic data;

  ApiSuccess(this.data, [int? statusCode]) {
    this.statusCode = statusCode;
  }
}

class ApiFailure extends ApiResults {
  final String message;
  final Map<String, dynamic>? additionalData;

  ApiFailure({required this.message, int? statusCode, this.additionalData}) {
    this.statusCode = statusCode;
  }

  factory ApiFailure.fromJson(Map<String, dynamic> json) {
    return ApiFailure(
      message: json['message'] ?? 'Unknown error',
      additionalData: json['data'] as Map<String, dynamic>?,
      statusCode: json['statusCode'] as int?,
    );
  }

  @override
  String toString() {
    return 'ApiFailure(message: $message, additionalData: $additionalData, statusCode: $statusCode)';
  }
}
