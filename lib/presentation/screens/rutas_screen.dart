import 'package:escucha_tu_historia_front/Utils/Utils.dart';
import 'package:escucha_tu_historia_front/models/ruta_model.dart';
import 'package:escucha_tu_historia_front/presentation/widgets/card_ruta.dart';
import 'package:escucha_tu_historia_front/provider/config_provider.dart';
import 'package:escucha_tu_historia_front/provider/ruta_provider.dart';
import 'package:escucha_tu_historia_front/services/rutas_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RutasScreen extends StatefulWidget {
  const RutasScreen({super.key});

  @override
  State<RutasScreen> createState() => _RutasScreenState();
}

class _RutasScreenState extends State<RutasScreen> {
  //Método para que cada vez que acceda a la pantalla se cargen las rutas
  @override
  void initState() {
    super.initState();
    //Future.microtask para acceder al provider de forma segura
    Future.microtask(() {
      Provider.of<RutaProvider>(context, listen: false).chargeRutasAndTags();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final rutaProvider = Provider.of<RutaProvider>(context);
    int index = -1;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green[900],
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
          BottomNavigationBarItem(icon: Icon(Icons.museum), label: "Visitar"),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Guardados",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Mapa"),
        ],
      ),
      appBar: AppBar(
        title: Text("Explorar Martos"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: rutaProvider.rutas.isNotEmpty
                ? () {
                    context.push('/rutasSearch');
                  }
                : null,
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: rutaProvider.rutas.isEmpty
          ? Center(child: Utils.splashLoader(width: 150))
          : RefreshIndicator(
              onRefresh: () async {
                rutaProvider.refreshData();
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      showTags(rutaProvider, index),
                      SizedBox(height: 10),
                      _cardGuiaInteligente(),
                      SizedBox(height: 10),

                      //Aquí iría un future builder, como no tenemos api todavía voy a hacerlo a pelo con un array de strings
                      if (rutaProvider.selectedTag == "TODO")
                        Column(
                          children: rutaProvider.rutas
                              .where(
                                (ruta) => !ruta
                                    .isActive, //Lo dejamos que salgan los no activos para testeos
                              )
                              .map((ruta) => CardRuta(ruta: ruta))
                              .toList(),
                        )
                      else
                        Column(
                          children: rutaProvider.rutas
                              .where(
                                (ruta) =>
                                    !ruta
                                        .isActive /*Lo dejamos que salgan los no activos para testeos*/ &&
                                    ruta.tag.name == rutaProvider.selectedTag,
                              )
                              .map((ruta) => CardRuta(ruta: ruta))
                              .toList(),
                        ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  SingleChildScrollView showTags(RutaProvider rutaProvider, int index) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: rutaProvider.tagsRutas.map((tag) {
          final isSelected = rutaProvider.selectedTag == tag;
          index++;
          return GestureDetector(
            onTap: () => rutaProvider.changeSelectedTag(tag),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.green : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.green),
                  ),
                  child: Text(
                    tag,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(width: 10),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _cardGuiaInteligente extends StatelessWidget {
  const _cardGuiaInteligente({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.green[900],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "✨ GUÍA INTELIGENTE",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          SizedBox(height: 10),
          Text(
            "¿Que quieres ver hoy?",
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Genera ruta personalizada basada en tu ubicación actual y el tiempo que tienes disponible",
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
          SizedBox(height: 10),
          TextButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(10),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.radar, size: 20, color: Colors.green[900]),
                SizedBox(width: 10),
                Text(
                  "Generar ruta desde aquí",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.green[900],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
