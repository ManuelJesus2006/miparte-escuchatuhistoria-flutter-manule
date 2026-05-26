import 'package:escucha_tu_historia_front/models/ruta_model.dart';
import 'package:http/http.dart';

class RutasServices{
  String urlBaseRender = "https://backend-tfg-escuchatuhistoria.onrender.com/";
  String urlBaseFly = "https://backend-tfg.fly.dev/";

  Future<List<Ruta>> getAllRutas()async{
    List<Ruta> rutas = [];
    //Aún no se pueden hacer peticiones
    Uri uri = Uri.parse("${urlBaseFly}api/v1/public/route");
    
    Response response = await get(uri);

    if (response.statusCode != 200) return rutas; 
    rutas = rutaFromJson(response.body);

    return rutas;
  }
}
