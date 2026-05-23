import 'package:escucha_tu_historia_front/models/ruta_model.dart';
import 'package:escucha_tu_historia_front/services/rutas_service.dart';
import 'package:flutter/material.dart';

class RutaProvider with ChangeNotifier {
  String selectedTag = "";
  String inputBusqueda = "";
  List<Ruta> rutas = [];
  List<String> tagsRutas = [];

  void chargeRutasAndTags() async {
    //Reseteamos primero los datos:
    resetData();
    List<String> tagsUnfiltered = [];
    List<String> rgbUnfiltered = [];
    rutas = await RutasServices().getAllRutas();
    rutas.forEach((ruta) {
      tagsUnfiltered.add(ruta.tag.name);
      rgbUnfiltered.add(ruta.tag.colorHex);
    });
    tagsRutas = tagsUnfiltered.toSet().toList();
    tagsRutas.insert(0, "TODO"); //Insertamos el filtro de todo
    selectedTag = "TODO";
    notifyListeners();
  }

  void resetData(){
    selectedTag = "";
    rutas = [];
    tagsRutas = [];
    notifyListeners();
  }

  void onInputSearchChange(String newValue){
    inputBusqueda = newValue;
    notifyListeners();
  }

  void changeSelectedTag(String newTag) {
    selectedTag = newTag;
    notifyListeners();
  }

  void refreshData() async {
    List<String> tagsUnfiltered = [];
    List<String> rgbUnfiltered = [];
    rutas = await RutasServices().getAllRutas();
    rutas.forEach((ruta) {
      tagsUnfiltered.add(ruta.tag.name);
      rgbUnfiltered.add(ruta.tag.colorHex);
    });
    tagsRutas = tagsUnfiltered.toSet().toList();
    tagsRutas.insert(0, "TODO"); //Insertamos el filtro de todo
    selectedTag = "TODO";
    notifyListeners();
  }
}
