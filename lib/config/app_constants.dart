// Constantes globales de la aplicación
// Aquí centralizamos la URL base del backend y otras configuraciones
class AppConstants {
  AppConstants._(); // Constructor privado → no se puede instanciar

  // URL base del backend desplegado en Render
  static const String baseUrl =
      'http://backend-tfg-escuchatuhistoria.onrender.com/api/v1';

  // Prefijos de los endpoints públicos (usuario)
  static const String publicPrefix = '/public';

  // Endpoints de monumentos
  static const String monumentsEndpoint = '$publicPrefix/monuments';

  // Endpoints de rutas
  static const String routesEndpoint = '$publicPrefix/route';

  // Endpoints de noticias
  static const String newsEndpoint = '$publicPrefix/news';

  // Endpoints de control de secciones (feature flags)
  static const String controlEndpoint = '$publicPrefix/control';

  // Timeout para las peticiones HTTP
  // 60 segundos porque el backend en Render (plan gratuito) puede tardar
  // hasta ~50s en arrancar si lleva un rato inactivo (cold start)
  static const Duration requestTimeout = Duration(seconds: 60);

  // Ruta de la animación Lottie compartida con Alfonso (splash + loading)
  static const String splashAnimation = 'assets/animations/splash_screen.json';

}
