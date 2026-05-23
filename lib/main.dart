import 'package:escucha_tu_historia_front/config/router/app_router.dart';
import 'package:escucha_tu_historia_front/provider/config_provider.dart';
import 'package:escucha_tu_historia_front/provider/ruta_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ConfigProvider()),
        ChangeNotifierProvider(create: (_) => RutaProvider()),
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}
