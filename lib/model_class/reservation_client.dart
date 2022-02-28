// To parse this JSON data, do
//
//     final reservationClient = reservationClientFromJson(jsonString);

import 'dart:convert';

List<ReservationClient> reservationClientFromJson(String str) =>
    List<ReservationClient>.from(
        json.decode(str).map((x) => ReservationClient.fromJson(x)));

String reservationClientToJson(List<ReservationClient> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReservationClient {
  ReservationClient({
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
    this.espaceTravailOrdinateur,
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
    this.prixAdulte,
    this.prixEnfant,
    this.disponibilite,
    this.prixEnfant15,
    this.du,
    this.au,
    this.code,
    this.nbrPlace,
    this.prixTotal,
    this.prixRemise,
    this.paye,
    this.hebergementId,
    this.clientId,
    this.expire,
    this.nbAdulte,
    this.nbEnfant15,
    this.nbEnfant4,
    this.read,
  });

  String id;
  String nom;
  String nbrVoyageurs;
  String nbrChambreDispo;
  String nbrPlaceDispo;
  String description;
  String wifi;
  String laveLinge;
  String chauffage;
  String television;
  String climatisation;
  String eauChaude;
  String espaceTravailOrdinateur;
  String espaceEnfant;
  String salleDeBain;
  String cuisine;
  String proprietaireId;
  String villeId;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  String latitude;
  String longitude;
  String adresse;
  String chambreIndividuel;
  String chambreADeux;
  String chambreATrois;
  String prixAdulte;
  String prixEnfant;
  String disponibilite;
  String prixEnfant15;
  DateTime du;
  DateTime au;
  String code;
  String nbrPlace;
  String prixTotal;
  String prixRemise;
  String paye;
  String hebergementId;
  String clientId;
  String expire;
  String nbAdulte;
  String nbEnfant15;
  String nbEnfant4;
  String read;

  factory ReservationClient.fromJson(Map<String, dynamic> json) =>
      ReservationClient(
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
        espaceTravailOrdinateur: json["espace_travail_ordinateur"],
        espaceEnfant: json["espace_enfant"],
        salleDeBain: json["salle_de_bain"],
        cuisine: json["cuisine"],
        proprietaireId: json["proprietaire_id"],
        villeId: json["ville_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        adresse: json["adresse"],
        chambreIndividuel: json["chambre_individuel"],
        chambreADeux: json["chambre_a_deux"],
        chambreATrois: json["chambre_a_trois"],
        prixAdulte: json["prix_adulte"],
        prixEnfant: json["prix_enfant"],
        disponibilite: json["disponibilite"],
        prixEnfant15: json["prix_enfant15"],
        du: DateTime.parse(json["du"]),
        au: DateTime.parse(json["au"]),
        code: json["code"],
        nbrPlace: json["nbr_place"],
        prixTotal: json["prix_total"],
        prixRemise: json["prix_remise"],
        paye: json["paye"],
        hebergementId: json["hebergement_id"],
        clientId: json["client_id"],
        expire: json["expire"],
        nbAdulte: json["nb_adulte"],
        nbEnfant15: json["nb_enfant15"],
        nbEnfant4: json["nb_enfant4"],
        read: json["read"],
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
        "espace_travail_ordinateur": espaceTravailOrdinateur,
        "espace_enfant": espaceEnfant,
        "salle_de_bain": salleDeBain,
        "cuisine": cuisine,
        "proprietaire_id": proprietaireId,
        "ville_id": villeId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "latitude": latitude,
        "longitude": longitude,
        "adresse": adresse,
        "chambre_individuel": chambreIndividuel,
        "chambre_a_deux": chambreADeux,
        "chambre_a_trois": chambreATrois,
        "prix_adulte": prixAdulte,
        "prix_enfant": prixEnfant,
        "disponibilite": disponibilite,
        "prix_enfant15": prixEnfant15,
        "du":
            "${du.year.toString().padLeft(4, '0')}-${du.month.toString().padLeft(2, '0')}-${du.day.toString().padLeft(2, '0')}",
        "au":
            "${au.year.toString().padLeft(4, '0')}-${au.month.toString().padLeft(2, '0')}-${au.day.toString().padLeft(2, '0')}",
        "code": code,
        "nbr_place": nbrPlace,
        "prix_total": prixTotal,
        "prix_remise": prixRemise,
        "paye": paye,
        "hebergement_id": hebergementId,
        "client_id": clientId,
        "expire": expire,
        "nb_adulte": nbAdulte,
        "nb_enfant15": nbEnfant15,
        "nb_enfant4": nbEnfant4,
        "read": read,
      };
}
