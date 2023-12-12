class Feed {
    int id;
    int mahasiswaId;
    String content;
    DateTime createdAt;
    DateTime updatedAt;
    bool liked;

    Feed({
        required this.id,
        required this.mahasiswaId,
        required this.content,
        required this.createdAt,
        required this.updatedAt,
        required this.liked,
    });

    factory Feed.fromJson(Map<String, dynamic> json) => Feed(
        id: json["id"],
        mahasiswaId: json["mahasiswa_id"],
        content: json["content"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        liked: json["liked"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "mahasiswa_id": mahasiswaId,
        "content": content,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "liked": liked,
    };
}
