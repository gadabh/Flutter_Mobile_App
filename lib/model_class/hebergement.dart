// To parse this JSON data, do
//
//     final hebergement = hebergementFromJson(jsonString);

import 'dart:convert';

List<Hebergement> hebergementFromJson(String str) => List<Hebergement>.from(
    json.decode(str).map((x) => Hebergement.fromJson(x)));

String hebergementToJson(List<Hebergement> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Hebergement {
  Hebergement({
    this.id,
    this.nom,
    this.nbrVoyageurs,
    this.nbrChambreDispo,
    this.nbrPlaceDispo,
    this.description,
    this.wifi,
    this.laveLinge,
    this.chauffage,
    this.television,
    this.climatisation,
    this.eauChaude,
    this.espace_travail_ordinateur,
    this.espaceEnfant,
    this.salleDeBain,
    this.cuisine,
    this.proprietaireId,
    this.villeId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.latitude,
    this.longitude,
    this.adresse,
    this.chambreIndividuel,
    this.chambreADeux,
    this.chambreATrois,
    this.prix_adulte,
    this.prix_enfant,
    this.disponibilite,
    this.prix_enfant15,
    this.nB_jaime,
    this.nB_jaime_pas,
  });

  String id;
  String nom;
  String nbrVoyageurs;
  String nbrChambreDispo;
  String nbrPlaceDispo;
  String description;
  dynamic wifi;
  dynamic laveLinge;
  dynamic chauffage;
  dynamic television;
  dynamic climatisation;
  dynamic eauChaude;
  dynamic espace_travail_ordinateur;
  dynamic espaceEnfant;
  dynamic salleDeBain;
  dynamic cuisine;
  String proprietaireId;
  String villeId;
  DateTime createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  String latitude;
  String longitude;
  String adresse;
  String chambreIndividuel;
  String chambreADeux;
  String chambreATrois;
  String prix_adulte;
  String prix_enfant;
  String disponibilite;
  String prix_enfant15;
  int nB_jaime;
  int nB_jaime_pas;

  factory Hebergement.fromJson(Map<String, dynamic> json) => Hebergement(
        id: json["id"],
        nom: json["nom"],
        nbrVoyageurs: json["nbr_voyageurs"],
        nbrChambreDispo: json["nbr_chambre_dispo"],
        nbrPlaceDispo: json["nbr_place_dispo"],
        description: json["description"],
        wifi: json["wifi"],
        laveLinge: json["lave_linge"],
        chauffage: json["chauffage"],
        television: json["television"],
        climatisation: json["climatisation"],
        eauChaude: json["eau_chaude"],
        espace_travail_ordinateur: json["espace_travail_ordinateur"],
        espaceEnfant: json["espace_enfant"],
        salleDeBain: json["salle_de_bain"],
        cuisine: json["cuisine"],
        proprietaireId: json["proprietaire_id"],
        villeId: json["ville_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        adresse: json["adresse"],
        chambreIndividuel: json["chambre_individuel"],
        chambreADeux: json["chambre_a_deux"],
        chambreATrois: json["chambre_a_trois"],
        prix_adulte: json["prix_adulte"],
        prix_enfant: json["prix_enfant"],
        disponibilite: json["disponibilite"],
        prix_enfant15: json["prix_enfant15"],
        nB_jaime: json["nB_jaime"],
        nB_jaime_pas: json["nB_jaime_pas"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nom": nom,
        "nbr_voyageurs": nbrVoyageurs,
        "nbr_chambre_dispo": nbrChambreDispo,
        "nbr_place_dispo": nbrPlaceDispo,
        "description": description,
        "wifi": wifi,
        "lave_linge": laveLinge,
        "chauffage": chauffage,
        "television": television,
        "climatisation": climatisation,
        "eau_chaude": eauChaude,
        "espace_travail_ordinateur": espace_travail_ordinateur,
        "espace_enfant": espaceEnfant,
        "salle_de_bain": salleDeBain,
        "cuisine": cuisine,
        "proprietaire_id": proprietaireId,
        "ville_id": villeId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "latitude": latitude,
        "longitude": longitude,
        "adresse": adresse,
        "chambre_individuel": chambreIndividuel,
        "chambre_a_deux": chambreADeux,
        "chambre_a_trois": chambreATrois,
        "prix_adulte": prix_adulte,
        "prix_enfant": prix_enfant,
        "disponibilite": disponibilite,
        "prix_enfant15": prix_enfant15,
        "nB_jaime": nB_jaime,
        "nB_jaime_pas": nB_jaime_pas,
      };
}
