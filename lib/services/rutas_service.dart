import 'dart:convert';

import 'package:escucha_tu_historia_front/models/ruta_model.dart';
import 'package:http/http.dart';

class RutasServices{
  String urlBase = "https://backend-tfg-escuchatuhistoria.onrender.com/";

  Future<List<Ruta>> getAllRutas()async{
    List<Ruta> rutas = [];
    //Aún no se pueden hacer peticiones
    Uri uri = Uri.parse("${urlBase}api/v1/public/route");
    
    Response response = await get(uri);

    if (response.statusCode != 200) return rutas; 
    rutas = rutaFromJson(response.body);

    return rutas;
  }
}

/*final datosRutasMock = [
    {
        "id": "111e8400-e29b-41d4-a716-446655440001",
        "name": "Paseo Histórico Familiar",
        "description": "Ruta suave por el centro ideal para hacer con niños y conocer lo básico.",
        "difficulty": 0,
        "rating" : 2.5,
        "activate": true,
        "tag_id": 9,
        "total_distance_meters": 1141.21,
        "estimated_time_seconds": 380.4,
        "monuments": [
            "550e8400-e29b-41d4-a716-446655440002",
            "550e8400-e29b-41d4-a716-44665544000f"
        ]
    },
    {
        "id": "111e8400-e29b-41d4-a716-446655440002",
        "name": "Senda del Patrimonio Marteño",
        "description": "Recorrido completo por los principales monumentos civiles y religiosos.",
        "difficulty": 1,
        "rating" : 1.5,
        "activate": true,
        "tag_id": 8,
        "total_distance_meters": 310.45,
        "estimated_time_seconds": 103.48,
        "monuments": [
            "550e8400-e29b-41d4-a716-446655440004",
            "550e8400-e29b-41d4-a716-446655440005",
            "550e8400-e29b-41d4-a716-446655440006"
        ]
    },
    {
        "id": "111e8400-e29b-41d4-a716-446655440003",
        "name": "Desafío de la Peña",
        "description": "Ruta de senderismo exigente que conecta el casco antiguo con la zona alta.",
        "difficulty": 2,
        "rating" : 4.5,
        "activate": false,
        "tag_id": 7,
        "total_distance_meters": 790.97,
        "estimated_time_seconds": 263.66,
        "monuments": [
            "550e8400-e29b-41d4-a716-446655440008",
            "550e8400-e29b-41d4-a716-44665544000d"
        ]
    }
];*/