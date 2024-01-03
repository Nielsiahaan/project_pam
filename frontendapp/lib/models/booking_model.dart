class BookingRoomModel {
  int id;
  int mahasiswaId;
  int roomId;
  DateTime startTime;
  DateTime endTime;
  String status;
  String keterangan;
  DateTime createdAt;
  DateTime updatedAt;

  BookingRoomModel({
    required this.id,
    required this.mahasiswaId,
    required this.roomId,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.keterangan,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BookingRoomModel.fromJson(Map<String, dynamic> json) =>
      BookingRoomModel(
        id: json["id"],
        mahasiswaId: json["mahasiswa_id"],
        roomId: json["room_id"],
        startTime: DateTime.parse(json["start_time"]),
        endTime: DateTime.parse(json["end_time"]),
        status: json["status"],
        keterangan: json["keterangan"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "mahasiswa_id": mahasiswaId,
        "room_id": roomId,
        "start_time": startTime.toIso8601String(),
        "end_time":
            "${endTime.year.toString().padLeft(4, '0')}-${endTime.month.toString().padLeft(2, '0')}-${endTime.day.toString().padLeft(2, '0')}",
        "status": status,
        "keterangan": keterangan,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
