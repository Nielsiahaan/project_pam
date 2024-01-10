import 'package:frontendapp/models/tshirt_model.dart';

class CartItemModel {
  int id;
  int mahasiswaId;
  int tshirtId;
  String size;
  int quantity;
  DateTime createdAt;
  DateTime updatedAt;
  TshirtModel tshirt;

  CartItemModel({
    required this.id,
    required this.mahasiswaId,
    required this.tshirtId,
    required this.size,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
    required this.tshirt,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
      id: json["id"],
      mahasiswaId: json["mahasiswa_id"],
      tshirtId: json["tshirt_id"],
      size: json["size"],
      quantity: json["quantity"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      tshirt: TshirtModel.fromJson(json["tshirt"]),
  );


  Map<String, dynamic> toJson() => {
        "id": id,
        "mahasiswa_id": mahasiswaId,
        "tshirt_id": tshirtId,
        "size": size,
        "quantity": quantity,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "tshirt": tshirt.toJson(),
      };
}
