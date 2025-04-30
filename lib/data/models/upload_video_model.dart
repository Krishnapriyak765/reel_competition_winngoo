class UploadResponse {
  final bool success;
  final String? message;

  UploadResponse({required this.success, this.message});

  factory UploadResponse.fromJson(Map<String, dynamic> json) {
    return UploadResponse(
      success: json['success'] ?? false,
      message: json['message'],
    );
  }
}
