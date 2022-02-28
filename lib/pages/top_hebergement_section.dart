import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'hebergement_details.dart';

class CarouselTopHebergement extends StatefulWidget {
  @override
  _CarouselTopHebergementState createState() => _CarouselTopHebergementState();
}

class _CarouselTopHebergementState extends State<CarouselTopHebergement> {
  Future tophebergement() async {
    var url = "https://etnafes.000webhostapp.com/affiche_image_tophebergement.php";
    var response = await http.get(url);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: SizedBox(
          height: 260,
          width: 400,
          child: FutureBuilder(
            future: tophebergement(),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, index) {
                        List list = snapshot.data;
                        return Card(
                            child: new InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HebergementsDetailes(
                                          nom: list[index]['nom'],
                                          description: list[index]
                                              ['description'],
                                          wifi: list[index]['wifi'],
                                          chauffage: list[index]['chauffage'],
                                          television: list[index]['television'],
                                          climatisation: list[index]
                                              ['climatisation'],
                                          eau_chaude: list[index]['eau_chaude'],
                                          espace_travail_ordinateur: list[index]
                                              ['espace_travail_ordinateur'],
                                          espace_enfant: list[index]
                                              ['espace_enfant'],
                                          salle_de_bain: list[index]
                                              ['salle_de_bain'],
                                          cuisine: list[index]['cuisine'],
                                          adresse: list[index]['adresse'],
                                          disponibilite: list[index]
                                              ['disponibilite'],
                                          imagelink:
                                              "https://etnafes.000webhostapp.com/uploads/${list[index]['url_image']}",
                                        )));
                          },
                          child: Column(
                            children: <Widget>[
                              //***** */

                              //******* */
                              Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: SizedBox(
                                  height: 170,
                                  width: 340,
                                  child: Card(
                                    child: Image.network(
                                      "https://etnafes.000webhostapp.com/uploads/${list[index]['url_image']}", // this image doesn't exist
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Container(
                                          color: Colors.amber,
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Whoops!',
                                            style: TextStyle(fontSize: 30),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),

                              //****** */
                              Text(
                                "  ${list[index]['nom']}",
                                style:
                                    TextStyle(fontFamily: 'Exo', fontSize: 19),
                              ),

                              Text(
                                "  ${list[index]['adresse']}",
                                style: TextStyle(
                                    fontFamily: 'Exo',
                                    fontSize: 15,
                                    color: Colors.black38),
                              ),
                            ],
                          ),
                        ));
                      },
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            },
          ),
        ),
      ),
    );
  }
}
