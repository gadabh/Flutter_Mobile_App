import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'acceuil.dart';
import 'add_hebergement.dart';
import 'auth/login_screen.dart';

import 'mes_reservations.dart';
import 'mes_reservations_clien.dart';
import 'mon_profil.dart';
import 'my_hebergement_details.dart';

class Hebergements extends StatefulWidget {
  @override
  _HebergementsState createState() => _HebergementsState();
}

class _HebergementsState extends State<Hebergements> {
//***session get email************ */
  String emailses = "";
  String idses = "";
  String nomSes = "";
  String prenomSes = "";
  String statuses = "";
  String imageses = "";
  Future getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      emailses = preferences.getString('email');
      idses = preferences.getString('idses');
      nomSes = preferences.getString('nom');
      prenomSes = preferences.getString('prenom');
      statuses = preferences.getString('statu');
      imageses = preferences.getString('imageses');
    });
    hebergement();
  }

  Future afficheimagetop3hebergement() async {
    var url =
        "https://etnafes.000webhostapp.com/affiche_image_top3hebergement.php?idses=$idses";
    print(url);
    var response = await http.get(url);
    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();
    getEmail();
  }

  Future logOut(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('email');
    Fluttertoast.showToast(
        msg: "Logout",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black54,
        textColor: Colors.white);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

//************************************************************************************** */
//********uploade image **************************************************** */

  Future hebergement() async {
    final uri = Uri.parse("https://etnafes.000webhostapp.com/hebergement.php");
    var request = http.MultipartRequest('POST', uri);

    request.fields['idses'] = idses;

    var response = await request.send();

    if (response.statusCode == 200) {
      print('hebergement afficher');
      afficheimagetop3hebergement();
    } else {
      print('hebergement non afficher');
    }
  }

//************************************************************************** */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.blueGrey[900],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: Text('Mes Hebergements',
                      style: TextStyle(fontSize: 18.0, color: Colors.white))),
            ],
          ),
        ),
        floatingActionButton: Container(
          height: 70,
          width: 70,
          child: FloatingActionButton(
            heroTag: "btn3",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddHebergement()),
              );
            },
            child: Text('Ajouter'),
            backgroundColor: Colors.orange[800],
          ),
        ),
        //*************************menu************************************** */

        drawer: Drawer(
          child: ListView(
            children: [
              new SizedBox(
                height: 200.0,
                child: new DrawerHeader(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(243, 243, 245, 1),
                  ),
                  child: Container(
                    child: Column(
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
                            child: Image.network(
                              "https://etnafes.000webhostapp.com/uploads/$imageses", // this image doesn't exist
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
                        Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Text(nomSes.toUpperCase(),
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.blueGrey[700])),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ListTile(
                title: Text('Acceuil',
                    style:
                        TextStyle(fontSize: 14.0, color: Colors.blueGrey[700])),
                leading: Icon(Icons.home, color: Colors.blueGrey[700]),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Acceuil()));
                },
              ),
              ListTile(
                title: Text('Mon Profil',
                    style:
                        TextStyle(fontSize: 14.0, color: Colors.blueGrey[700])),
                leading: Icon(Icons.account_box_rounded,
                    color: Colors.blueGrey[700]),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MonProfil()));
                },
              ),
              statuses == "prop"
                  ? ListTile(
                      title: Text('Mes Hébergemens',
                          style: TextStyle(
                              fontSize: 14.0, color: Colors.blueGrey[700])),
                      leading:
                          Icon(Icons.add_location, color: Colors.blueGrey[700]),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Hebergements()));
                      },
                    )
                  : ListTile(
                      title: Text('Mes voyage ',
                          style: TextStyle(
                              fontSize: 14.0, color: Colors.blueGrey[700])),
                      leading: Icon(Icons.reduce_capacity_sharp,
                          color: Colors.blueGrey[700]),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ReservationsClien()));
                      },
                    ),
              statuses == "prop"
                  ? ListTile(
                      title: Text('Hébergements Réservés ',
                          style: TextStyle(
                              fontSize: 14.0, color: Colors.blueGrey[700])),
                      leading: Icon(Icons.reduce_capacity_sharp,
                          color: Colors.blueGrey[700]),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Reservations()));
                      },
                    )
                  : ListTile(),
              ListTile(
                title: Text('Déconnexion',
                    style:
                        TextStyle(fontSize: 14.0, color: Colors.blueGrey[700])),
                leading: Icon(Icons.logout, color: Colors.blueGrey[700]),
                onTap: () {
                  logOut(context);
                },
              )
            ],
          ),
        ),

        //********************************************************************* *
        body: Container(
          child: Scaffold(
            body: FutureBuilder(
              future: afficheimagetop3hebergement(),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, index) {
                          List list = snapshot.data;
                          return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 700),
                              child: ScaleAnimation(
                                  // verticalOffset: 50.0,
                                  child: ScaleAnimation(
                                      child: Card(
                                          child: new InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MyHebergementsDetailes(
                                                id: list[index]['id'],
                                                nom: list[index]['nom'],
                                                description: list[index]
                                                    ['description'],
                                                wifi: list[index]['wifi'],
                                                chauffage: list[index]
                                                    ['chauffage'],
                                                television: list[index]
                                                    ['television'],
                                                climatisation: list[index]
                                                    ['climatisation'],
                                                eau_chaude: list[index]
                                                    ['eau_chaude'],
                                                espace_travail_ordinateur: list[
                                                        index][
                                                    'espace_travail_ordinateur'],
                                                espace_enfant: list[index]
                                                    ['espace_enfant'],
                                                salle_de_bain: list[index]
                                                    ['salle_de_bain'],
                                                cuisine: list[index]['cuisine'],
                                                adresse: list[index]['adresse'],
                                                prix_adulte: list[index]
                                                    ['prix_adulte'],
                                                prix_enfant15: list[index]
                                                    ['prix_enfant15'],
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
                                                  style:
                                                      TextStyle(fontSize: 30),
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
                                      style: TextStyle(
                                          fontFamily: 'Exo', fontSize: 19),
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
                              )))));
                        },
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      );
              },
            ),
          ),
        ));
  }
}
