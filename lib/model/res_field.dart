// To parse this JSON data, do
//
//     final resField = resFieldFromJson(jsonString);

import 'dart:convert';

ResField resFieldFromJson(String str) => ResField.fromJson(json.decode(str));

String resFieldToJson(ResField data) => json.encode(data.toJson());

class ResField {
    bool success;
    String message;
    Data data;
    List<String> fotoUrls;

    ResField({
        required this.success,
        required this.message,
        required this.data,
        required this.fotoUrls,
    });

    factory ResField.fromJson(Map<String, dynamic> json) => ResField(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
        fotoUrls: List<String>.from(json["foto_urls"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
        "foto_urls": List<dynamic>.from(fotoUrls.map((x) => x)),
    };
}

class Data {
    String namaLapangan;
    String lokasi;
    String deskripsi;
    String aturanLapangan;
    String fasilitasLapangan;
    String fotoLapangan;
    DateTime updatedAt;
    DateTime createdAt;
    int id;

    Data({
        required this.namaLapangan,
        required this.lokasi,
        required this.deskripsi,
        required this.aturanLapangan,
        required this.fasilitasLapangan,
        required this.fotoLapangan,
        required this.updatedAt,
        required this.createdAt,
        required this.id,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        namaLapangan: json["nama_lapangan"],
        lokasi: json["lokasi"],
        deskripsi: json["deskripsi"],
        aturanLapangan: json["aturan_lapangan"],
        fasilitasLapangan: json["fasilitas_lapangan"],
        fotoLapangan: json["foto_lapangan"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "nama_lapangan": namaLapangan,
        "lokasi": lokasi,
        "deskripsi": deskripsi,
        "aturan_lapangan": aturanLapangan,
        "fasilitas_lapangan": fasilitasLapangan,
        "foto_lapangan": fotoLapangan,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
    };
}
