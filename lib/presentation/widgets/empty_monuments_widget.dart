import 'package:escucha_tu_historia_front/config/app_colors.dart';
import 'package:flutter/material.dart';

class EmptyMonumentsWidget extends StatefulWidget {
  // 0 = sin monumentos por parte del back,
  // 1 = sin moumentos por parte de busqueda del usuario
  final int type;
  const EmptyMonumentsWidget({super.key, required this.type});

  @override
  State<EmptyMonumentsWidget> createState() => _EmptyMonumentsWidgetState();
}

class _EmptyMonumentsWidgetState extends State<EmptyMonumentsWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeIn);
    _scale = Tween<double>(
      begin: 0.7,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeTransition(
        opacity: _fade,
        child: ScaleTransition(
          scale: _scale,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryGreen.withAlpha(26),
                ),
                child: const Icon(
                  Icons.highlight_remove_rounded,
                  size: 100,
                  color: AppColors.primaryGreen,
                ),
              ),
              const SizedBox(height: 24),
               Text(
                "No se han encontrado resultados",
                style: TextStyle(
                  color: AppColors.primaryGreen,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              widget.type == 0
              ?  Text(
                "Hubo un error al cargar los monumentos",
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.primaryGreen, fontSize: 14),
              )
              : Text(
                "Prueba con otros términos de búsqueda",
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.primaryGreen, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
