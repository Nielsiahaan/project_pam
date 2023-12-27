import 'package:frontendapp/models/mahasiswa_model.dart';

class RequestIkModel {
  int id;
  int mahasiswaId;
  DateTime tanggalBerangkat;
  DateTime tanggalKembali;
  String deskripsi;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  Mahasiswa mahasiswa;

  RequestIkModel({
    required this.id,
    required this.mahasiswaId,
    required this.tanggalBerangkat,
    required this.tanggalKembali,
    required this.deskripsi,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.mahasiswa,
  });

  factory RequestIkModel.fromJson(Map<String, dynamic> json) => RequestIkModel(
        id: json["id"],
        mahasiswaId: json["mahasiswa_id"],
        tanggalBerangkat: DateTime.parse(json["tanggal_berangkat"]),
        tanggalKembali: DateTime.parse(json["tanggal_kembali"]),
        deskripsi: json["deskripsi"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        mahasiswa: Mahasiswa.fromJson(json["mahasiswa"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "mahasiswa_id": mahasiswaId,
        "tanggal_berangkat": tanggalBerangkat.toIso8601String(),
        "tanggal_kembali": tanggalKembali.toIso8601String(),
        "deskripsi": deskripsi,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "mahasiswa": mahasiswa.toJson(),
      };
}
