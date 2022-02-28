// To parse this JSON data, do
//
//     final profil = profilFromJson(jsonString);

import 'dart:convert';

List<Profil> profilFromJson(String str) =>
    List<Profil>.from(json.decode(str).map((x) => Profil.fromJson(x)));

String profilToJson(List<Profil> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Profil {
  Profil({
    this.id,
    this.nom,
    this.prenom,
    this.telephone,
    this.email,
    this.gouvernorat,
    this.civilition,
    this.image,
    this.cin,
    this.codePostale,
    this.login,
    this.password,
    this.rememberToken,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.role,
    this.villeId,
    this.active,
    this.token,
    this.tokenPwd,
  });

  String id;
  String nom;
  String prenom;
  String telephone;
  String email;
  String gouvernorat;
  String civilition;
  String image;
  String cin;
  String codePostale;
  String login;
  String password;
  dynamic rememberToken;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  String role;
  String villeId;
  String active;
  dynamic token;
  dynamic tokenPwd;

  factory Profil.fromJson(Map<String, dynamic> json) => Profil(
        id: json["id"],
        nom: json["nom"],
        prenom: json["prenom"],
        telephone: json["Telephone"],
        email: json["email"],
        gouvernorat: json["gouvernorat"],
        civilition: json["civilition"],
        image: json["image"],
        cin: json["cin"],
        codePostale: json["code_postale"],
        login: json["login"],
        password: json["password"],
        rememberToken: json["remember_token"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        role: json["role"],
        villeId: json["ville_id"],
        active: json["active"],
        token: json["token"],
        tokenPwd: json["token_pwd"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nom": nom,
        "prenom": prenom,
        "Telephone": telephone,
        "email": email,
        "gouvernorat": gouvernorat,
        "civilition": civilition,
        "image": image,
        "cin": cin,
        "code_postale": codePostale,
        "login": login,
        "password": password,
        "remember_token": rememberToken,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "role": role,
        "ville_id": villeId,
        "active": active,
        "token": token,
        "token_pwd": tokenPwd,
      };
}
