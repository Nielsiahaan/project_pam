class Mahasiswa {
  int id;
  String nim;
  String name;
  String username;
  String email;
  dynamic emailVerifiedAt;
  String noKtp;
  String noTelp;
  String role;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic googleId;

  Mahasiswa({
    required this.id,
    required this.nim,
    required this.name,
    required this.username,
    required this.email,
    required this.emailVerifiedAt,
    required this.noKtp,
    required this.noTelp,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    required this.googleId,
  });

  factory Mahasiswa.fromJson(Map<String, dynamic> json) => Mahasiswa(
        id: json["id"],
        nim: json["nim"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        noKtp: json["no_ktp"],
        noTelp: json["no_telp"],
        role: json["role"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        googleId: json["google_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nim": nim,
        "name": name,
        "username": username,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "no_ktp": noKtp,
        "no_telp": noTelp,
        "role": role,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "google_id": googleId,
      };
}
