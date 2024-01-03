import 'package:frontendapp/models/payment_model.dart';

class OrderItemModel {
    int id;
    int orderId;
    int tshirtId;
    String selectedSize;
    int quantity;
    String status;
    dynamic proofOfPayment;
    DateTime createdAt;
    DateTime updatedAt;
    PaymentModel paymentModel;

    OrderItemModel({
        required this.id,
        required this.orderId,
        required this.tshirtId,
        required this.selectedSize,
        required this.quantity,
        required this.status,
        required this.proofOfPayment,
        required this.createdAt,
        required this.updatedAt,
        required this.paymentModel,
    });

    factory OrderItemModel.fromJson(Map<String, dynamic> json) => OrderItemModel(
        id: json["id"],
        orderId: json["order_id"],
        tshirtId: json["tshirt_id"],
        selectedSize: json["selected_size"],
        quantity: json["quantity"],
        status: json["status"],
        proofOfPayment: json["proof_of_payment"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        paymentModel: PaymentModel.fromJson(json["paymentModel"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "tshirt_id": tshirtId,
        "selected_size": selectedSize,
        "quantity": quantity,
        "status": status,
        "proof_of_payment": proofOfPayment,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "paymentModel": paymentModel.toJson(),
    };
}
