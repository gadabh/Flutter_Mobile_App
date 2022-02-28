import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_extended/carousel_extended.dart';
import 'hebergement_details.dart';

class CarouselHebergement extends StatefulWidget {
  @override
  _CarouselHebergementState createState() => _CarouselHebergementState();
}

class _CarouselHebergementState extends State<CarouselHebergement> {
  Future allhebergement() async {
    var url = "https://etnafes.000webhostapp.com/affiche_image_hebergement.php";
    var response = await http.get(url);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: FutureBuilder(
          future: allhebergement(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
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
                                        id: list[index]['id'],
                                        nom: list[index]['nom'],
                                        description: list[index]['description'],
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            //***** */

                            //******* */
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: SizedBox(
                                height: 150,
                                width: 270,
                                child: Carousel(
                                  images: [
                                    NetworkImage(
                                        'https://etnafes.000webhostapp.com/uploads/${list[index]['url_image']}'),
                                    NetworkImage(
                                        'https://etnafes.000webhostapp.com/uploads/${list[index]['url_image']}'),
                                  ],
                                ),
                              ),
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(children: [
                                  Text(
                                    "   ${list[index]['nom']}",
                                    style: TextStyle(
                                        fontFamily: 'Exo', fontSize: 16),
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "  ↩",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ]),
                                Row(
                                  children: [
                                    Text(
                                      '    ${list[index]['adresse']}',
                                      style: TextStyle(
                                          fontFamily: 'Exo',
                                          fontSize: 14,
                                          color: Colors.black38),
                                    ),
                                  ],
                                ),
                              ],
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
    );
  }
}
