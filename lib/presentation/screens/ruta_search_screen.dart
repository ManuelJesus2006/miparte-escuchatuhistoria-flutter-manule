import 'package:escucha_tu_historia_front/presentation/widgets/card_ruta.dart';
import 'package:escucha_tu_historia_front/provider/ruta_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RutaSearchScreen extends StatelessWidget {
  const RutaSearchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final rutaProvider = Provider.of<RutaProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Row(
                //Fila para el input y boton de vuelta
                children: [
                  IconButton(
                    onPressed: () {
                      context.pop(); //Botón de vuelta
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  Expanded(
                    //Ponemos expanded para que no sobresalga de la pantalla el contenido
                    child: TextField(
                      onChanged: (value) {
                        rutaProvider.onInputSearchChange(value);
                      },
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: "Introduzca una ruta",
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.green[900],
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(
                            color: Colors.green[900]!,
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(
                            color: Colors.green[700]!,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Builder(
                    builder: (context) {
                      final filtradas = rutaProvider.rutas
                          .where((ruta) => !ruta.isActive)
                          .where(
                            (ruta) => ruta.name.toLowerCase().contains(
                              rutaProvider.inputBusqueda.toLowerCase(),
                            ),
                          )
                          .toList();

                      if (filtradas.isEmpty) {
                        return Center(
                          child: Text(
                            'No se han encontrado rutas',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        );
                      }

                      return Column(
                        children: filtradas
                            .map((ruta) => CardRuta(ruta: ruta))
                            .toList(),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
