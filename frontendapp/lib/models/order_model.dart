import 'package:frontendapp/models/order_item_model.dart';

class OrderModel {
  int id;
  String totalPrice;
  int mahasiswaId;
  DateTime createdAt;
  DateTime updatedAt;
  List<OrderItemModel> orderItemModel;

  OrderModel({
    required this.id,
    required this.totalPrice,
    required this.mahasiswaId,
    required this.createdAt,
    required this.updatedAt,
    required this.orderItemModel,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        totalPrice: json["total_price"],
        mahasiswaId: json["mahasiswa_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        orderItemModel: (json["order_itemModel"] as List<dynamic>?)
                ?.map((x) => OrderItemModel.fromJson(x))
                .toList() ??
            [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "total_price": totalPrice,
        "mahasiswa_id": mahasiswaId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "order_itemModel":
            List<dynamic>.from(orderItemModel.map((x) => x.toJson())),
      };
}
