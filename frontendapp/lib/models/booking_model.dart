class BookingModel {
    int mahasiswaId;
    String roomId;
    DateTime startTime;
    DateTime endTime;
    String keterangan;
    DateTime updatedAt;
    DateTime createdAt;
    int id;

    BookingModel({
        required this.mahasiswaId,
        required this.roomId,
        required this.startTime,
        required this.endTime,
        required this.keterangan,
        required this.updatedAt,
        required this.createdAt,
        required this.id,
    });

    factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
        mahasiswaId: json["mahasiswa_id"],
        roomId: json["room_id"],
        startTime: DateTime.parse(json["start_time"]),
        endTime: DateTime.parse(json["end_time"]),
        keterangan: json["keterangan"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "mahasiswa_id": mahasiswaId,
        "room_id": roomId,
        "start_time": startTime.toIso8601String(),
        "end_time": endTime.toIso8601String(),
        "keterangan": keterangan,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
    };
}
