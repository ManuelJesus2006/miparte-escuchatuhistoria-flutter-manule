import 'package:escucha_tu_historia_front/models/ruta_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  // Capitaliza la primera letra de un texto y deja el resto en minusculas
  static String capitalizeTag(String tag) {
    if (tag.isEmpty) return tag;
    return tag[0].toUpperCase() + tag.substring(1).toLowerCase();
  }

  // Formatea números grandes añadiendo el sufijo K o M (ej: 1500 -> 1.5K)
  static String formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    } else {
      return number.toString();
    }
  }

  static String formatearFecha(DateTime fecha) {
    final diff = DateTime.now().difference(fecha);
    if (diff.inMinutes < 1) return 'Hace un momento';
    if (diff.inMinutes < 60) return 'Hace ${diff.inMinutes} min';
    if (diff.inHours < 24) return 'Hace ${diff.inHours} h';
    if (diff.inDays == 1) return 'Ayer';
    if (diff.inDays < 7) return 'Hace ${diff.inDays} días';
    return DateFormat('dd/MM/yyyy').format(fecha);
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