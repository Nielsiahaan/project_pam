// class TshirtModel {
//   int id;
//   String size;
//   String price;
//   int quantity;
//   DateTime createdAt;
//   DateTime updatedAt;

//   TshirtModel({
//     required this.id,
//     required this.size,
//     required this.price,
//     required this.quantity,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory TshirtModel.fromJson(Map<String, dynamic> json) => TshirtModel(
//         id: json["id"],
//         size: json["size"],
//         price: json["price"],
//         quantity: json["quantity"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "size": size,
//         "price": price,
//         "quantity": quantity,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//       };
// }
class TshirtModel {
    int id;
    String size;
    String price;
    int quantity;
    DateTime createdAt;
    DateTime updatedAt;

    TshirtModel({
        required this.id,
        required this.size,
        required this.price,
        required this.quantity,
        required this.createdAt,
        required this.updatedAt,
    });

    factory TshirtModel.fromJson(Map<String, dynamic> json) => TshirtModel(
        id: json["id"],
        size: json["size"],
        price: json["price"],
        quantity: json["quantity"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "size": size,
        "price": price,
        "quantity": quantity,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}