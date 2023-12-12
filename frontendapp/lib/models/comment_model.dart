import 'package:frontendapp/models/feed_model.dart';
import 'package:frontendapp/models/mahasiswa_model.dart';

class CommentModel {
    int id;
    int mahasiswaId;
    int feedId;
    String body;
    DateTime createdAt;
    DateTime updatedAt;
    Feed feed;
    Mahasiswa mahasiswa;

    CommentModel({
        required this.id,
        required this.mahasiswaId,
        required this.feedId,
        required this.body,
        required this.createdAt,
        required this.updatedAt,
        required this.feed,
        required this.mahasiswa,
    });

    factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        id: json["id"],
        mahasiswaId: json["mahasiswa_id"],
        feedId: json["feed_id"],
        body: json["body"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        feed: Feed.fromJson(json["feed"]),
        mahasiswa: Mahasiswa.fromJson(json["mahasiswa"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "mahasiswa_id": mahasiswaId,
        "feed_id": feedId,
        "body": body,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "feed": feed.toJson(),
        "mahasiswa": mahasiswa.toJson(),
    };
}
