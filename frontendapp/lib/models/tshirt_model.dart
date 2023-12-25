class TshirtModel {
  String size;
  double price;
  int quantity;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  TshirtModel({
    required this.size,
    required this.price,
    required this.quantity,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory TshirtModel.fromJson(Map<String, dynamic> json) => TshirtModel(
        size: json["size"],
        price: (json["price"] is String)
            ? double.tryParse(json["price"]) ?? 0.0
            : json["price"],
        quantity: json["quantity"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "size": size,
        "price": price,
        "quantity": quantity,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}
