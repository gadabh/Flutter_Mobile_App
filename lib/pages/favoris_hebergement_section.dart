import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'hebergement_details.dart';

class FavCarouselHebergement extends StatefulWidget {
  @override
  _FavCarouselHebergementState createState() => _FavCarouselHebergementState();
}

class _FavCarouselHebergementState extends State<FavCarouselHebergement> {
  //*********************get info user from session**************** */
  String emailses = "";
  String nomSes = "";
  String prenomSes = "";
  String cinSes = "";
  String telSes = "";
  String loginSes = "";
  String statuses = "";
  Future getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      emailses = preferences.getString('email');
      nomSes = preferences.getString('nom');
      prenomSes = preferences.getString('prenom');
      cinSes = preferences.getString('cin');
      telSes = preferences.getString('tel');
      loginSes = preferences.getString('login');

      statuses = preferences.getString('statu');
    });
  }

  @override
  void initState() {
    super.initState();
    getEmail();
  }

  Future favhebergement() async {
    var url = "https://etnafes.000webhostapp.com/favoris.php";
    var response = await http.get(url);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: FutureBuilder(
          future: favhebergement(),
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
                                        emailses: emailses,
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
                                        nB_jaime: list[index]['nB_jaime'],
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
                                height: 220,
                                width: 345,
                                child: Card(
                                  child: Image.network(
                                    "https://etnafes.000webhostapp.com/uploads/${list[index]['url_image']}", // this image doesn't exist
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: Colors.amber,
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Whoops!',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      child: Icon(Icons.home_outlined,
                                          color: Colors.pink),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            left: 8, right: 3, top: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              ' ${list[index]['nom']}',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              '${list[index]['adresse']}',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Icon(Icons.favorite,
                                        color: Colors.pinkAccent),
                                    Text(
                                      ' ${list[index]['nB_jaime']} ',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                )
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
