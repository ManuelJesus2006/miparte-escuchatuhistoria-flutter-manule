import 'dart:convert';
import 'dart:io';
import 'package:escucha_tu_historia_front/config/app_constants.dart';
import 'package:http/http.dart' as http;

// Excepción personalizada para errores de la API
class ApiException implements Exception {
  final int? statusCode;
  final String message;

  const ApiException({this.statusCode, required this.message});

  @override
  String toString() => 'ApiException($statusCode): $message';
}

// Servicio HTTP centralizado
// Todos los providers usan este servicio en lugar de llamar directamente a http
class ApiService {
  final http.Client _client;

  ApiService({http.Client? client}) : _client = client ?? http.Client();

  // Construye la URI completa a partir del path y los query params opcionales
  Uri _buildUri(String path, [Map<String, String>? queryParams]) {
    final uri = Uri.parse('${AppConstants.baseUrl}$path');
    if (queryParams != null && queryParams.isNotEmpty) {
      return uri.replace(queryParameters: queryParams);
    }
    return uri;
  }

  // Petición GET — devuelve el body ya decodificado como dynamic
  Future<dynamic> get(
    String path, {
    Map<String, String>? queryParams,
  }) async {
    final uri = _buildUri(path, queryParams);

    try {
      final response = await _client
          .get(uri, headers: {'Content-Type': 'application/json'})
          .timeout(AppConstants.requestTimeout);

      return _handleResponse(response);
    } on SocketException {
      throw const ApiException(
        message: 'Sin conexión a internet. Comprueba tu red.',
      );
    } on HttpException {
      throw const ApiException(message: 'Error de red inesperado.');
    } on FormatException {
      throw const ApiException(message: 'Respuesta del servidor no válida.');
    }
  }

  // Petición POST — envía body JSON y devuelve la respuesta decodificada
  Future<dynamic> post(String path, Map<String, dynamic> body) async {
    final uri = _buildUri(path);

    try {
      final response = await _client
          .post(
            uri,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(body),
          )
          .timeout(AppConstants.requestTimeout);

      return _handleResponse(response);
    } on SocketException {
      throw const ApiException(
        message: 'Sin conexión a internet. Comprueba tu red.',
      );
    } on HttpException {
      throw const ApiException(message: 'Error de red inesperado.');
    } on FormatException {
      throw const ApiException(message: 'Respuesta del servidor no válida.');
    }
  }

  // Interpreta el código de respuesta HTTP y lanza excepción si hay error
  dynamic _handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        if (response.body.isEmpty) return null;
        return jsonDecode(response.body);
      case 404:
        throw ApiException(
          statusCode: 404,
          message: 'Recurso no encontrado.',
        );
      case 500:
      case 503:
        throw ApiException(
          statusCode: response.statusCode,
          message: 'Error en el servidor. Intenta más tarde.',
        );
      default:
        throw ApiException(
          statusCode: response.statusCode,
          message: 'Error inesperado (${response.statusCode}).',
        );
    }
  }
}
