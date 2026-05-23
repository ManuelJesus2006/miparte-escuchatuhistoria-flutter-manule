import 'package:escucha_tu_historia_front/Utils/Utils.dart';
import 'package:escucha_tu_historia_front/models/ruta_model.dart';
import 'package:flutter/material.dart';

class CardRuta extends StatelessWidget {
  CardRuta({super.key, required this.ruta});

  Ruta ruta;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          clipBehavior: Clip.hardEdge,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image(
                    image: NetworkImage(ruta.monuments[1].pictures[0].url),
                    width: double.infinity,
                    height: size.height * 0.2, //Ponemos aquí el tamaño de la imagen variable según el dispositivo
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null)
                        return child; //Child es la imagen ya cargada
                      return Utils.splashLoader(width: 50);
                    },
                  ),
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.65),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.headphones, color: Colors.white, size: 14),
                          SizedBox(width: 4),
                          Text(
                            "Audioguía",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Estrella arriba derecha
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.star, color: Colors.yellow, size: 14),
                          SizedBox(width: 4),
                          Text(
                            ruta.averageScore.toStringAsFixed(1),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ruta.name,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      ruta.description,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.timer),
                            SizedBox(width: 5),
                            Text(
                              "${Utils.transformToMinutes(ruta.estimatedTimeSeconds)} min",
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        SizedBox(width: 20),
                        Row(
                          children: [
                            Icon(Icons.straighten),
                            SizedBox(width: 5),
                            Text(
                              "${Utils.transformToKilometer(ruta.totalDistanceMeters)} km",
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        SizedBox(width: 20),
                        Row(
                          children: [
                            Icon(Icons.directions_walk),
                            SizedBox(width: 5),
                            Text(
                              Utils.showUXDifficulty(ruta.difficult),
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextButton(
                  onPressed: () {},
                  /*  async {
                    final monumentos = await MonumentoService()
                        .getMonumentoByIds(ruta.monuments);
                    mapsProvider.setMonumentos(monumentos);
                    print('Monumentos encontrados: ${monumentos.length}');
                    print('Monumentos en provider: ${mapsProvider.monumentos.length}');
                    context.push('/maps');
                  }, */

                  /* Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetalleScreen(rutaMock: mock),
                    ), 
                  ),*/
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(10),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.green, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Ver detalle",
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.green[900],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}