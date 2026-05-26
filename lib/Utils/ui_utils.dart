import 'package:escucha_tu_historia_front/models/ruta_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class UIUtils {
  // Formateadores y transformadores de datos

  // Convierte segundos a minutos redondeando sin decimales
  static String transformToMinutes(double seconds) {
    return (seconds / 60).toStringAsFixed(0);
  }

  // Convierte metros a kilometros con 1 decimal
  static String transformToKilometer(double meters) {
    return (meters / 1000).toStringAsFixed(1);
  }

  /// Devuelve el texto de dificultad según el ID recibido.
  static String showUXDifficulty(int difficult) {
    switch (difficult) {
      case 0:
        return "Fácil";
      case 1:
        return "Medio";
      case 2:
        return "Difícil";
      default:
        return "unknown";
    }
  }

  // Utilidades de UI

  // Retorna el color correspondiente a partir de un String Hexadecimal (ej: #FFFFFF o 0xFFFFFF)
  static Color colorFromHex(String hexColor) {
    final normalizedHex = hexColor
        .toUpperCase()
        .replaceAll('#', '')
        .replaceAll('0X', '');
    final buffer = StringBuffer();
    if (normalizedHex.length == 6) buffer.write('FF');
    buffer.write(normalizedHex);
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  // Retorna el loader de la Splash Screen con un efecto de opacidad animado
  static Widget splashLoader({
    double opacity = 1.0,
    double? width,
    String assetPath = 'assets/animations/splash_screen.json',
  }) {
    return Center(
      child: AnimatedOpacity(
        opacity: opacity,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
        child: Lottie.asset(
          assetPath,
          width: width ?? 250,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  static String translateRouteTag(TagRuta tag) {
    switch (tag.id){
      case 0: return "Todo";
      case 8: return "Patrimonio";
      case 7: return "Aventura";
      case 9: return "Familiar";
      case 6: return "Mixto";
      default: return "Unknown";
    }
  }
}