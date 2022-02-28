// To parse this JSON data, do
//
//     final reservation = reservationFromJson(jsonString);

import 'dart:convert';

List<Reservation> reservationFromJson(String str) => List<Reservation>.from(
    json.decode(str).map((x) => Reservation.fromJson(x)));

String reservationToJson(List<Reservation> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Reservation {
  Reservation({
    this.clientNom,
    this.hebergementNom,
    this.hebergementCode,
    this.du,
    this.reservationHebergementNom,
    this.au,
    this.nombrePlace,
    this.nbAdulte,
    this.nbEnfant15,
    this.prixTotale,
    this.statue,
  });

  String clientNom;
  String hebergementNom;
  String hebergementCode;
  DateTime du;
  String reservationHebergementNom;
  DateTime au;
  String nombrePlace;
  String nbAdulte;
  String nbEnfant15;
  String prixTotale;
  String statue;

  factory Reservation.fromJson(Map<String, dynamic> json) => Reservation(
        clientNom: json["client_nom"],
        hebergementNom: json["hebergement nom"],
        hebergementCode: json["hebergement_code"],
        du: DateTime.parse(json["du"]),
        reservationHebergementNom: json["hebergement_nom"],
        au: DateTime.parse(json["au"]),
        nombrePlace: json["nombre place"],
        nbAdulte: json["nb adulte"],
        nbEnfant15: json["nb_enfant15"],
        prixTotale: json["prix totale"],
        statue: json["statue"],
      );

  Map<String, dynamic> toJson() => {
        "client_nom": clientNom,
        "hebergement nom": hebergementNom,
        "hebergement_code": hebergementCode,
        "du":
            "${du.year.toString().padLeft(4, '0')}-${du.month.toString().padLeft(2, '0')}-${du.day.toString().padLeft(2, '0')}",
        "hebergement_nom": reservationHebergementNom,
        "au":
            "${au.year.toString().padLeft(4, '0')}-${au.month.toString().padLeft(2, '0')}-${au.day.toString().padLeft(2, '0')}",
        "nombre place": nombrePlace,
        "nb adulte": nbAdulte,
        "nb_enfant15": nbEnfant15,
        "prix totale": prixTotale,
        "statue": statue,
      };
}
