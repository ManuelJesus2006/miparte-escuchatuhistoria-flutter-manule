
import 'package:escucha_tu_historia_front/Utils/ui_utils.dart';
import 'package:escucha_tu_historia_front/config/app_colors.dart';
import 'package:escucha_tu_historia_front/models/ruta_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CardRuta extends StatelessWidget {
  const CardRuta({super.key, required this.ruta});

  final Ruta ruta;

  String? _getImageUrl() {
    for (final monument in ruta.monuments) {
      if (monument.pictures.isNotEmpty) {
        return monument.pictures.first.url;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = _getImageUrl();

    return GestureDetector(
      onTap: () {
        //Aquí iría la pantalla de Miguel de mapa de visualización de la ruta
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen con badges encima
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  child: imageUrl != null
                      ? Image.network(
                          imageUrl,
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return SizedBox(
                              height: 180,
                              width: double.infinity,
                              child: UIUtils.splashLoader(width: 100),
                            );
                          },
                          errorBuilder: (_, __, ___) => _placeholder(),
                        )
                      : _placeholder(),
                ),
                // Badge puntuación arriba a la derecha
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(140),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.star, size: 14, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          ruta.averageScore.toStringAsFixed(1),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Badge audioguía abajo a la izquierda
                Positioned(
                  bottom: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(140),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.headphones, color: Colors.white, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          'Audioguía',
                          style: const TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Contenido
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tag de la ruta
                  if (ruta.tag != null) _tagWidget(ruta.tag!),
                  const SizedBox(height: 8),

                  // Nombre
                  Text(
                    ruta.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Descripción
                  Text(
                    ruta.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Métricas: tiempo, distancia, dificultad
                  Row(
                    children: [
                      _metricChip(
                        Icons.timer_outlined,
                        '${UIUtils.transformToMinutes(ruta.estimatedTimeSeconds)} min',
                      ),
                      const SizedBox(width: 12),
                      _metricChip(
                        Icons.straighten,
                        '${UIUtils.transformToKilometer(ruta.totalDistanceMeters)} km',
                      ),
                      const SizedBox(width: 12),
                      _metricChip(
                        Icons.directions_walk,
                        UIUtils.showUXDifficulty(ruta.difficult),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      height: 180,
      width: double.infinity,
      color: Colors.grey[200],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.image_outlined, size: 40, color: Colors.grey[400]),
          const SizedBox(height: 8),
          Text(
            'Imagen no disponible',
            style: TextStyle(color: Colors.grey[500], fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _tagWidget(TagRuta tag) {
    final color = tag.colorHex.isNotEmpty
        ? UIUtils.colorFromHex(tag.colorHex)
        : AppColors.primaryGreen;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        tag.name,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _metricChip(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 15, color: AppColors.textSecondary),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
