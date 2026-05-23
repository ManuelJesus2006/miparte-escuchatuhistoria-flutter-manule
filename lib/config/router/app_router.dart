import 'package:escucha_tu_historia_front/presentation/screens/ruta_search_screen.dart';
import 'package:escucha_tu_historia_front/presentation/screens/rutas_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/rutas',
  routes: [
    GoRoute(path: '/rutas', builder: (context, state) => RutasScreen()),
    GoRoute(path: '/rutasSearch', builder: (context, state) => RutaSearchScreen(),)
  ],
);
