// To parse this JSON data, do
//
//     final reservationExperience = reservationExperienceFromJson(jsonString);

import 'dart:convert';

List<ReservationExperience> reservationExperienceFromJson(String str) =>
    List<ReservationExperience>.from(
        json.decode(str).map((x) => ReservationExperience.fromJson(x)));

String reservationExperienceToJson(List<ReservationExperience> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReservationExperience {
  ReservationExperience({
    this.idP,
    this.idGuide,
    this.programe,
    this.depart,
    this.fin,
    this.dateCreation,
    this.image,
    this.idG,
    this.nomG,
    this.prenomG,
    this.cinG,
    this.ville,
    this.imageG,
  });

  String idP;
  String idGuide;
  String programe;
  DateTime depart;
  DateTime fin;
  DateTime dateCreation;
  String image;
  String idG;
  String nomG;
  String prenomG;
  String cinG;
  String ville;
  String imageG;

  factory ReservationExperience.fromJson(Map<String, dynamic> json) =>
      ReservationExperience(
        idP: json["id_p"],
        idGuide: json["id_guide"],
        programe: json["programe"],
        depart: DateTime.parse(json["depart"]),
        fin: DateTime.parse(json["fin"]),
        dateCreation: DateTime.parse(json["date_creation"]),
        image: json["image"],
        idG: json["id_g"],
        nomG: json["nom_g"],
        prenomG: json["prenom_g"],
        cinG: json["cin_g"],
        ville: json["ville"],
        imageG: json["image_g"],
      );

  Map<String, dynamic> toJson() => {
        "id_p": idP,
        "id_guide": idGuide,
        "programe": programe,
        "depart":
            "${depart.year.toString().padLeft(4, '0')}-${depart.month.toString().padLeft(2, '0')}-${depart.day.toString().padLeft(2, '0')}",
        "fin":
            "${fin.year.toString().padLeft(4, '0')}-${fin.month.toString().padLeft(2, '0')}-${fin.day.toString().padLeft(2, '0')}",
        "date_creation":
            "${dateCreation.year.toString().padLeft(4, '0')}-${dateCreation.month.toString().padLeft(2, '0')}-${dateCreation.day.toString().padLeft(2, '0')}",
        "image": image,
        "id_g": idG,
        "nom_g": nomG,
        "prenom_g": prenomG,
        "cin_g": cinG,
        "ville": ville,
        "image_g": imageG,
      };
}
