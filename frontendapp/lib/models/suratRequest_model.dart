class RequestSuratModel {
    int id;
    int mahasiswaId;
    String kategoriSurat;
    String content;
    DateTime tanggalPengambilan;
    String status;
    DateTime createdAt;
    DateTime updatedAt;
    DateTime createdAtFormatted;

    RequestSuratModel({
        required this.id,
        required this.mahasiswaId,
        required this.kategoriSurat,
        required this.content,
        required this.tanggalPengambilan,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
        required this.createdAtFormatted,
    });

    factory RequestSuratModel.fromJson(Map<String, dynamic> json) => RequestSuratModel(
        id: json["id"],
        mahasiswaId: json["mahasiswa_id"],
        kategoriSurat: json["kategori_surat"],
        content: json["content"],
        tanggalPengambilan: DateTime.parse(json["tanggal_pengambilan"]),
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAtFormatted: DateTime.parse(json["created_at_formatted"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "mahasiswa_id": mahasiswaId,
        "kategori_surat": kategoriSurat,
        "content": content,
        "tanggal_pengambilan": "${tanggalPengambilan.year.toString().padLeft(4, '0')}-${tanggalPengambilan.month.toString().padLeft(2, '0')}-${tanggalPengambilan.day.toString().padLeft(2, '0')}",
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "created_at_formatted": createdAtFormatted.toIso8601String(),
    };
}