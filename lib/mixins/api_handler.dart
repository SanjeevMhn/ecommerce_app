import 'package:dio/dio.dart';

mixin ApiHandler {
  String handleError(DioException error) {
    String message = "Something went wrong. Please try again.";

    if (error.type == DioExceptionType.connectionTimeout) {
      message = "Connection timed out. Check your internet.";
    } else if (error.response != null) {
      // Handle specific status codes from your backend
      switch (error.response?.statusCode) {
        case 400:
          message = error.response?.data['message'] ?? "Invalid request.";
          break;
        case 401:
          message = "Unauthorized. Please log in again.";
          // You could trigger a logout event here
          break;
        case 403:
          message = "You don't have permission to access this.";
          break;
        case 500:
          message = "Server error. Mochi is working on it!";
          break;
      }
    }

    return message;
  }
}
