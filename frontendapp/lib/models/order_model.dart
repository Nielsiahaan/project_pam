class OrderModel {
    int id;
    int mahasiswaId;
    int tshirtId;
    String selectedSize;
    int quantity;
    String totalPrice;
    DateTime createdAt;
    DateTime updatedAt;

    OrderModel({
        required this.id,
        required this.mahasiswaId,
        required this.tshirtId,
        required this.selectedSize,
        required this.quantity,
        required this.totalPrice,
        required this.createdAt,
        required this.updatedAt,
    });

    factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        mahasiswaId: json["mahasiswa_id"],
        tshirtId: json["tshirt_id"],
        selectedSize: json["selected_size"],
        quantity: json["quantity"],
        totalPrice: json["total_price"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "mahasiswa_id": mahasiswaId,
        "tshirt_id": tshirtId,
        "selected_size": selectedSize,
        "quantity": quantity,
        "total_price": totalPrice,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}