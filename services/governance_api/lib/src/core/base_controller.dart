import 'dart:convert';
import 'package:shelf/shelf.dart';

/// [BaseController] - The foundational class for the Max OOP MVC architecture.
/// Provides standardized utilities for response formatting, telemetry, and error handling.
abstract class BaseController {
  /// Success response with JSON encoding.
  Response success(dynamic data) {
    return Response.ok(
      jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
  }

  /// Standardized error response.
  Response error(String message, {int statusCode = 500}) {
    return Response(
      statusCode,
      body: jsonEncode({'error': message, 'status': 'failed'}),
      headers: {'Content-Type': 'application/json'},
    );
  }

  /// Not Found response.
  Response notFound(String entity) {
    return error('$entity not found', statusCode: 404);
  }
}
