// To parse this JSON data, do
//
//     final ruta = rutaFromJson(jsonString);

import 'dart:convert';

List<Ruta> rutaFromJson(String str) => List<Ruta>.from(json.decode(str).map((x) => Ruta.fromJson(x)));

String rutaToJson(List<Ruta> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ruta {
    String id;
    String name;
    String description;
    bool isActive;
    int difficult;
    List<Monument> monuments;
    Tag tag;
    int? localidadId;
    double averageScore;
    double totalDistanceMeters;
    double estimatedTimeSeconds;
    DateTime createdAt;
    DateTime lastModified;

    Ruta({
        required this.id,
        required this.name,
        required this.description,
        required this.isActive,
        required this.difficult,
        required this.monuments,
        required this.tag,
        required this.localidadId,
        required this.averageScore,
        required this.totalDistanceMeters,
        required this.estimatedTimeSeconds,
        required this.createdAt,
        required this.lastModified,
    });

    factory Ruta.fromJson(Map<String, dynamic> json) => Ruta(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        isActive: json["isActive"],
        difficult: json["difficult"],
        monuments: List<Monument>.from(json["monuments"].map((x) => Monument.fromJson(x))),
        tag: Tag.fromJson(json["tag"]),
        localidadId: json["localidad_id"],
        averageScore: json["average_score"]?.toDouble(),
        totalDistanceMeters: json["total_distance_meters"]?.toDouble(),
        estimatedTimeSeconds: json["estimated_time_seconds"]?.toDouble(),
        createdAt: DateTime.parse(json["created_at"]),
        lastModified: DateTime.parse(json["last_modified"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "isActive": isActive,
        "difficult": difficult,
        "monuments": List<dynamic>.from(monuments.map((x) => x.toJson())),
        "tag": tag.toJson(),
        "localidad_id": localidadId,
        "average_score": averageScore,
        "total_distance_meters": totalDistanceMeters,
        "estimated_time_seconds": estimatedTimeSeconds,
        "created_at": createdAt.toIso8601String(),
        "last_modified": lastModified.toIso8601String(),
    };
}

class Monument {
    String id;
    String name;
    Coordenates coordenates;
    List<Picture> pictures;

    Monument({
        required this.id,
        required this.name,
        required this.coordenates,
        required this.pictures,
    });

    factory Monument.fromJson(Map<String, dynamic> json) => Monument(
        id: json["id"],
        name: json["name"],
        coordenates: Coordenates.fromJson(json["coordenates"]),
        pictures: List<Picture>.from(json["pictures"].map((x) => Picture.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "coordenates": coordenates.toJson(),
        "pictures": List<dynamic>.from(pictures.map((x) => x.toJson())),
    };
}

class Coordenates {
    double lon;
    double lat;

    Coordenates({
        required this.lon,
        required this.lat,
    });

    factory Coordenates.fromJson(Map<String, dynamic> json) => Coordenates(
        lon: json["lon"]?.toDouble(),
        lat: json["lat"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "lon": lon,
        "lat": lat,
    };
}

class Picture {
    DateTime createdAt;
    int id;
    DateTime lastModified;
    String url;

    Picture({
        required this.createdAt,
        required this.id,
        required this.lastModified,
        required this.url,
    });

    factory Picture.fromJson(Map<String, dynamic> json) => Picture(
        createdAt: DateTime.parse(json["createdAt"]),
        id: json["id"],
        lastModified: DateTime.parse(json["lastModified"]),
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "id": id,
        "lastModified": lastModified.toIso8601String(),
        "url": url,
    };
}

class Tag {
    int id;
    String name;
    String colorHex;
    DateTime createdAt;

    Tag({
        required this.id,
        required this.name,
        required this.colorHex,
        required this.createdAt,
    });

    factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        id: json["id"],
        name: json["name"],
        colorHex: json["colorHex"],
        createdAt: DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "colorHex": colorHex,
        "createdAt": createdAt.toIso8601String(),
    };
}
