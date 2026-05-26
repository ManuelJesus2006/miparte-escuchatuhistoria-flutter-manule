import 'package:flutter/material.dart';
import '../data/models/ruta_model.dart';
import '../../../core/services/api_service.dart';
import '../../../core/constants/app_constants.dart';

class RutasProvider with ChangeNotifier {
  List<Ruta> rutas = [];
  List<TagRuta> tagsRutas = [];
  String selectedTag = "TODO";
  String inputBusqueda = "";
  bool cargando = false;
  String? errorMensaje;

  final ApiService _api;

  RutasProvider({ApiService? apiService}) : _api = apiService ?? ApiService() {
    cargarRutas();
  }

  Future<void> cargarRutas() async {
    cargando = true;
    errorMensaje = null;
    notifyListeners();

    try {
      // Petición al endpoint centralizado
      final data = await _api.get(AppConstants.routesEndpoint);
      final lista = data as List;

      // Mapeamos las rutas utilizando el modelo unificado
      rutas = lista
          .map((e) => Ruta.fromJson(e as Map<String, dynamic>))
          .toList();

      // Extraemos y procesamos los Tags de las rutas de manera dinámica
      _procesarTags();
    } on ApiException catch (e) {
      errorMensaje = e.message;
    } catch (e) {
      errorMensaje = 'Error inesperado al cargar las rutas.';
    }

    cargando = false;
    notifyListeners();
  }

  // Extrae los nombres de los tags únicos y añade la opción 'TODO'
  void _procesarTags() {
    final List<TagRuta> tagsUnfiltered = [];
    for (var ruta in rutas) {
      if (ruta.tag != null && ruta.tag != null) {
        tagsUnfiltered.add(ruta.tag!);
      }
    }
    tagsRutas = tagsUnfiltered.toSet().toList();
    tagsRutas.insert(0, TagRuta(id: 0, name: "TODO", colorHex: "", createdAt: DateTime.now()));
  }

  void changeSelectedTag(String newTag) {
    selectedTag = newTag;
    notifyListeners();
  }

  void onInputSearchChange(String newValue) {
    inputBusqueda = newValue;
    notifyListeners();
  }

  void resetData() {
    selectedTag = "TODO";
    inputBusqueda = "";
    rutas = [];
    tagsRutas = [];
    notifyListeners();
  }

  // Método alias para soportar la acción de Pull to Refresh de la vista
  Future<void> refreshData() async {
    await cargarRutas();
  }
}
