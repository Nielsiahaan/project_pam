class PaymentModel {
  int id;
  int orderItemId;
  String paymentAmount;
  String paymentMethod;
  String paymentStatus;
  DateTime createdAt;
  DateTime updatedAt;

  PaymentModel({
    required this.id,
    required this.orderItemId,
    required this.paymentAmount,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        id: json["id"],
        orderItemId: json["order_item_id"],
        paymentAmount: json["payment_amount"],
        paymentMethod: json["payment_method"],
        paymentStatus: json["payment_status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_item_id": orderItemId,
        "payment_amount": paymentAmount,
        "payment_method": paymentMethod,
        "payment_status": paymentStatus,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
