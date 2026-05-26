import 'dart:convert';

// Funciones globales de parseo creadas por Manule
List<Ruta> rutaFromJson(String str) =>
    List<Ruta>.from(json.decode(str).map((x) => Ruta.fromJson(x)));
String rutaToJson(List<Ruta> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ruta {
  final String id;
  final String name;
  final String description;
  final bool isActive;
  final int difficult;
  final List<Monument> monuments;
  final TagRuta? tag; // Lo hacemos opcional por seguridad si algún JSON no lo trae
  final int? localidadId;
  final double averageScore;
  final double totalDistanceMeters;
  final double estimatedTimeSeconds;
  final DateTime? createdAt;
  final DateTime? lastModified;

  Ruta({
    required this.id,
    required this.name,
    required this.description,
    required this.isActive,
    required this.difficult,
    required this.monuments,
    this.tag,
    this.localidadId,
    required this.averageScore,
    required this.totalDistanceMeters,
    required this.estimatedTimeSeconds,
    this.createdAt,
    this.lastModified,
  });

  // ── TUS MÉTODOS VISUALES (ALEJANDRO) ─────────────────────────────────

  // Devuelve la dificultad como texto
  String get textoDificultad {
    if (difficult == 0) return 'Fácil';
    if (difficult == 1) return 'Media';
    return 'Difícil';
  }

  // Devuelve la distancia formateada bonita, ej: "1.1 km" o "310 m"
  String get distanciaFormateada {
    if (totalDistanceMeters >= 1000) {
      return '${(totalDistanceMeters / 1000).toStringAsFixed(1)} km';
    }
    return '${totalDistanceMeters.toStringAsFixed(0)} m';
  }

  // Devuelve el tiempo formateado, ej: "45 min"
  String get tiempoFormateado {
    final minutos = (estimatedTimeSeconds / 60).round();
    if (minutos < 60) return '$minutos min';
    final horas = minutos ~/ 60;
    final resto = minutos % 60;
    if (resto == 0) return '$horas h';
    return '$horas h $resto min';
  }

  // ── MAPEO DE JSON UNIFICADO ───────────────────────────────────────────
  factory Ruta.fromJson(Map<String, dynamic> json) => Ruta(
    // Soporta tanto tus nombres antiguos de JSON como los nuevos de Manule
    id: json["id"] ?? '',
    name: json["name"] ?? json["nombre"] ?? '',
    description: json["description"] ?? json["descripcion"] ?? '',
    isActive: json["isActive"] ?? json["activate"] ?? false,
    difficult: json["difficult"] ?? json["dificultad"] ?? 0,
    monuments: json["monuments"] != null
        ? List<Monument>.from(
            json["monuments"].map((x) => Monument.fromJson(x)),
          )
        : [],
    tag: json["tag"] != null ? TagRuta.fromJson(json["tag"]) : null,
    localidadId: json["localidad_id"],
    averageScore: (json["average_score"] ?? json["rating"] ?? 0).toDouble(),
    totalDistanceMeters:
        (json["total_distance_meters"] ?? json["distanciaMetros"] ?? 0)
            .toDouble(),
    estimatedTimeSeconds:
        (json["estimated_time_seconds"] ?? json["tiempoSegundos"] ?? 0)
            .toDouble(),
    createdAt: json["created_at"] != null
        ? DateTime.parse(json["created_at"])
        : null,
    lastModified: json["last_modified"] != null
        ? DateTime.parse(json["last_modified"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "isActive": isActive,
    "difficult": difficult,
    "monuments": List<dynamic>.from(monuments.map((x) => x.toJson())),
    "tag": tag?.toJson(),
    "localidad_id": localidadId,
    "average_score": averageScore,
    "total_distance_meters": totalDistanceMeters,
    "estimated_time_seconds": estimatedTimeSeconds,
    "created_at": createdAt?.toIso8601String(),
    "last_modified": lastModified?.toIso8601String(),
  };
}

// ── SUBCLASES NUEVAS TRAÍDAS DE LA RAMA DE MANULE ─────────────────────

class Monument {
  final String id;
  final String name;
  final Coordenates coordenates;
  final List<Picture> pictures;

  Monument({
    required this.id,
    required this.name,
    required this.coordenates,
    required this.pictures,
  });

  factory Monument.fromJson(Map<String, dynamic> json) => Monument(
    id: json["id"] ?? '',
    name: json["name"] ?? '',
    coordenates: Coordenates.fromJson(
      json["coordenates"] ?? {"lon": 0.0, "lat": 0.0},
    ),
    pictures: json["pictures"] != null
        ? List<Picture>.from(json["pictures"].map((x) => Picture.fromJson(x)))
        : [],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "coordenates": coordenates.toJson(),
    "pictures": List<dynamic>.from(pictures.map((x) => x.toJson())),
  };
}

class Coordenates {
  final double lon;
  final double lat;

  Coordenates({required this.lon, required this.lat});

  factory Coordenates.fromJson(Map<String, dynamic> json) => Coordenates(
    lon: (json["lon"] ?? 0.0).toDouble(),
    lat: (json["lat"] ?? 0.0).toDouble(),
  );

  Map<String, dynamic> toJson() => {"lon": lon, "lat": lat};
}

class Picture {
  final DateTime createdAt;
  final int id;
  final DateTime lastModified;
  final String url;

  Picture({
    required this.createdAt,
    required this.id,
    required this.lastModified,
    required this.url,
  });

  factory Picture.fromJson(Map<String, dynamic> json) => Picture(
    createdAt: json["createdAt"] != null
        ? DateTime.parse(json["createdAt"])
        : DateTime.now(),
    id: json["id"] ?? 0,
    lastModified: json["lastModified"] != null
        ? DateTime.parse(json["lastModified"])
        : DateTime.now(),
    url: json["url"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "createdAt": createdAt.toIso8601String(),
    "id": id,
    "lastModified": lastModified.toIso8601String(),
    "url": url,
  };
}

class TagRuta {
  final int id;
  final String name;
  final String colorHex;
  final DateTime createdAt;

  TagRuta({
    required this.id,
    required this.name,
    required this.colorHex,
    required this.createdAt,
  });

  @override
  bool operator ==(Object other) => other is TagRuta && other.id == id;

  @override
  int get hashCode => id.hashCode;

  factory TagRuta.fromJson(Map<String, dynamic> json) => TagRuta(
    id: json["id"] ?? 0,
    name: json["name"] ?? '',
    colorHex: json["colorHex"] ?? '',
    createdAt: json["createdAt"] != null
        ? DateTime.parse(json["createdAt"])
        : DateTime.now(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "colorHex": colorHex,
    "createdAt": createdAt.toIso8601String(),
  };
}
