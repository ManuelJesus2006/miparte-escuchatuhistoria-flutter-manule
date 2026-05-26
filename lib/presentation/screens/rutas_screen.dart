import 'package:escucha_tu_historia_front/Utils/ui_utils.dart';
import 'package:escucha_tu_historia_front/config/app_colors.dart';
import 'package:escucha_tu_historia_front/presentation/widgets/card_ruta.dart';
import 'package:escucha_tu_historia_front/presentation/widgets/empty_monuments_widget.dart';
import 'package:escucha_tu_historia_front/provider/rutas_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RutasScreen extends StatefulWidget {
  const RutasScreen({super.key});

  @override
  State<RutasScreen> createState() => _RutasScreenState();
}

class _RutasScreenState extends State<RutasScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<RutasProvider>(context, listen: false).cargarRutas();
    });
  }

  @override
  Widget build(BuildContext context) {
    final rutasProvider = Provider.of<RutasProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: rutasProvider.cargando
            ? Center(child: UIUtils.splashLoader(width: 150))
            : RefreshIndicator(
                color: AppColors.primaryGreen,
                onRefresh: () async => await rutasProvider.refreshData(),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),

                        // Header estilo monuments
                        _headerWidget(context),
                        const SizedBox(height: 20),

                        // Buscador estilo monuments
                        _searchBarWidget(context, rutasProvider),
                        const SizedBox(height: 20),

                        // Chips de filtro estilo monuments
                        _filterChipsWidget(
                          context,
                          rutasProvider
                        ),
                        const SizedBox(height: 20),

                        // Banner IA estilo monuments
                        _aiBannerWidget(context),
                        const SizedBox(height: 24),

                        // Lista de rutas filtradas
                        _rutasListWidget(rutasProvider),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget _headerWidget(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : AppColors.textPrimary;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'MARTOS, JAÉN',
              style: TextStyle(
                color: AppColors.primaryGreen,
                fontWeight: FontWeight.w800,
                fontSize: 12,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Rutas",
              style: TextStyle(
                color: textColor,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _searchBarWidget(
    BuildContext context,
    RutasProvider rutasProvider
  ) {
    return SearchBar(
      hintText: 'Buscar ruta...',
      hintStyle: const WidgetStatePropertyAll(
        TextStyle(color: AppColors.primaryGreen, fontWeight: FontWeight.w600),
      ),
      leading: const Icon(Icons.search, color: AppColors.primaryGreen),
      backgroundColor: WidgetStatePropertyAll(Theme.of(context).cardColor),
      elevation: const WidgetStatePropertyAll(2),
      shadowColor: const WidgetStatePropertyAll(Colors.black26),
      shape: const WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      ),
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(vertical: 8, horizontal: 14),
      ),
      onChanged: (value) {
        rutasProvider.onInputSearchChange(value);
      },
    );
  }

  Widget _filterChipsWidget(
    BuildContext context,
    RutasProvider rutasProvider
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: rutasProvider.tagsRutas.map((tag) {
          final isSelected = rutasProvider.selectedTag == tag.name;
          return GestureDetector(
            onTap: () => rutasProvider.changeSelectedTag(tag.name),
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryGreen
                    : Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(20),
                border: isSelected
                    ? Border.all(color: AppColors.primaryGreen)
                    : Border.all(
                        color: isDark
                            ? Colors.grey.shade700
                            : Colors.grey.shade300,
                      ),
              ),
              child: Text(
                UIUtils.translateRouteTag(tag),
                style: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : (isDark ? Colors.white : AppColors.textPrimary),
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _aiBannerWidget(
    BuildContext context
  ) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.primaryGreen, AppColors.secondaryGreen],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.auto_awesome, color: Colors.white, size: 16),
                      SizedBox(width: 8),
                      Text(
                        'IA Generativa',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '¿Qué quieres ver hoy?',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Genera una ruta personalizada basada en tu ubicación.',
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF54CFAE),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 27,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _rutasListWidget(
    RutasProvider rutasProvider
  ) {
    final filtradas = rutasProvider.rutas.where((ruta) => ruta.isActive).where((
      ruta,
    ) {
      final coincideTag =
          rutasProvider.selectedTag == 'TODO' ||
          ruta.tag?.name == rutasProvider.selectedTag;
      final coincideBusqueda = ruta.name.toLowerCase().contains(
        rutasProvider.inputBusqueda.toLowerCase(),
      );
      return coincideTag && coincideBusqueda;
    }).toList();

    if (filtradas.isEmpty) {
      return Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
        child: rutasProvider.rutas.isEmpty
            ? const EmptyMonumentsWidget(type: 0) // Sin datos en absoluto
            : const EmptyMonumentsWidget(
                type: 1,
              ), // Hay rutas pero el filtro no encuentra nada
      );
    }

    return Column(
      children: filtradas.map((ruta) => CardRuta(ruta: ruta)).toList(),
    );
  }
}
