class RoomModel {
  int? id;
  String roomName;
  DateTime createdAt;
  DateTime updatedAt;

  RoomModel({
    required this.id,
    required this.roomName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) => RoomModel(
        id: json["id"],
        roomName: json["roomName"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "roomName": roomName,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
