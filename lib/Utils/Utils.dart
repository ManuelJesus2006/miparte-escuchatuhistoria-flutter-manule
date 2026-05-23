import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class Utils {
  static String transformToMinutes(double seconds) {
    return (seconds/60).toStringAsFixed(0);
  }

  static String transformToKilometer(double kilometers) {
    return (kilometers/1000).toStringAsFixed(1);
  }

  static String showUXDifficulty(int difficult) {
    switch(difficult){
      case 0: return "Fácil";
      case 1: return "Medio";
      case 2: return "Difícil";
      default: return "unknown";
    }
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

  
}
  //Prueba de idiomas
  /* static String stringExploreMartos(String idiomaActual) {
    if (idiomaActual == 'es') return "Explorar Martos";
    else return "Explore Martos";
  }

  static String stringAudioguide(String idiomaActual) {
    if (idiomaActual == 'es') return "Audioguía";
    else return "Audioguide";
  }

  static String stringDiscoverRoute(String idiomaActual) {
    if (idiomaActual == 'es') return "Descubre esta ruta";
    else return "Discover this route";
  }

  static String stringShowDetail(String idiomaActual) {
    if (idiomaActual == 'es') return 'Ver detalles';
    else return "Show detail";
  }

  static String stringSmartGuide(String idiomaActual) {
    if (idiomaActual == 'es') return "✨ GUÍA INTELIGENTE";
    else return "✨ SMART GUIDE";
  }

  static String stringWhatWannaSeeToday(String idiomaActual) {
    if (idiomaActual == 'es') return "¿Qué quieres ver hoy?";
    else return "What do you want to see today?";
  }

  static String stringDescriptionAI(String idiomaActual) {
    if (idiomaActual == 'es') return "Genera ruta personalizada basada en tu ubicación actual y el tiempo que tienes disponible";
    else return "Generate a personalized route based on your actual location and your available time";
  }

  static String stringGenerateFromHere(String idiomaActual) {
    if (idiomaActual == 'es') return 'Generar una ruta desde aquí';
    else return "Generate a route right now";
  } */
