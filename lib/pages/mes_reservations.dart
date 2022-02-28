import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app1/model_class/reservation-api.dart';
import 'package:flutter_app1/model_class/reservation.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'acceuil.dart';

import 'auth/login_screen.dart';
import 'mes_hebergements.dart';
import 'mes_reservations_clien.dart';
import 'mon_profil.dart';

class Reservations extends StatefulWidget {
  //***session get email************ */
  @override
  _ReservationsState createState() => _ReservationsState();
}

class _ReservationsState extends State<Reservations> {
  String emailses = "";
  String idses = "";
  String statuses = "";
  String nomSes = "";
  String prenomSes = "";
  String imageses = "";
  Future getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      emailses = preferences.getString('email');
      idses = preferences.getString('idses');
      statuses = preferences.getString('statu');
      nomSes = preferences.getString('nom');
      prenomSes = preferences.getString('prenom');
      imageses = preferences.getString('imageses');
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getEmail());
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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.blueGrey[900]),
        backgroundColor: Colors.white,
        toolbarHeight: 65,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.only(bottom: 0, right: 0),
                child: Text('Mes Reservations'.toUpperCase(),
                    style: TextStyle(
                        fontSize: 18.0, color: Colors.blueGrey[900]))),
          ],
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
              leading:
                  Icon(Icons.account_box_rounded, color: Colors.blueGrey[700]),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => MonProfil()));
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
        child: FutureBuilder(
          future: fetchreservation(idses),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index) {
                  Reservation reservation = snapshot.data[index];

                  return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 700),
                      child: ScaleAnimation(
                          // verticalOffset: 50.0,
                          child: ScaleAnimation(
                              child: Column(
                        children: <Widget>[
                          Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  decoration: new BoxDecoration(
                                      color: Colors.blueGrey[900],
                                      borderRadius: new BorderRadius.only(
                                          topLeft: const Radius.circular(5.0),
                                          topRight:
                                              const Radius.circular(5.0))),
                                  child: Row(
                                    children: [
                                      Image.asset('assets/calendrier.png',
                                          alignment: Alignment.center,
                                          height: 50,
                                          width: 50,
                                          fit: BoxFit.cover),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            'Hebergement ${reservation.hebergementNom}'
                                                .toUpperCase(),
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.white)),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  color: Colors.orange[30],
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30, bottom: 25),
                                    child: Table(
                                      // defaultColumnWidth: FixedColumnWidth(100.0),
                                      border: TableBorder.all(
                                          color: Colors.white,
                                          style: BorderStyle.solid,
                                          width: 0),
                                      children: [
                                        TableRow(children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Column(children: [
                                                SizedBox(height: 20),
                                                Text(
                                                  'Voyageur'.toUpperCase(),
                                                  style: TextStyle(
                                                    fontSize: 14.0,
                                                  ),
                                                )
                                              ]),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Column(children: [
                                                SizedBox(height: 20),
                                                Text('${reservation.clientNom}',
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.black45))
                                              ]),
                                            ],
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Column(children: [
                                                SizedBox(height: 20),
                                                Text(
                                                    'Nombre Place'
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                        fontSize: 14.0))
                                              ]),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Column(children: [
                                                SizedBox(height: 20),
                                                Text(
                                                    '${reservation.nombrePlace}',
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.black45))
                                              ]),
                                            ],
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Column(children: [
                                                SizedBox(height: 20),
                                                Text(
                                                    'Nombre Adulte'
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                        fontSize: 14.0))
                                              ]),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Column(children: [
                                                SizedBox(height: 20),
                                                Text('${reservation.nbAdulte}',
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.black45))
                                              ]),
                                            ],
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Column(children: [
                                                SizedBox(height: 20),
                                                Text(
                                                    'Nombre Enfants'
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                        fontSize: 14.0))
                                              ]),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Column(children: [
                                                SizedBox(height: 20),
                                                Text(
                                                    '${reservation.nbEnfant15}',
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.black45))
                                              ]),
                                            ],
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Column(children: [
                                                SizedBox(height: 20),
                                                Text(
                                                    'Prix Totale'.toUpperCase(),
                                                    style: TextStyle(
                                                        fontSize: 14.0))
                                              ]),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Column(children: [
                                                SizedBox(height: 20),
                                                Text(
                                                    '${reservation.prixTotale}',
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.black45))
                                              ]),
                                            ],
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Column(children: [
                                                SizedBox(height: 20),
                                                Text('Statue'.toUpperCase(),
                                                    style: TextStyle(
                                                        fontSize: 14.0))
                                              ]),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Column(children: [
                                                SizedBox(height: 20),
                                                ('${reservation.statue}' == "0")
                                                    ? Text(
                                                        'Non payé'
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                            fontSize: 16.0,
                                                            color: Colors
                                                                .redAccent))
                                                    : Text('Payé'.toUpperCase(),
                                                        style: TextStyle(
                                                            fontSize: 16.0,
                                                            color:
                                                                Colors.green)),
                                              ]),
                                            ],
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Column(children: [
                                                SizedBox(height: 20),
                                                Text('Arriver'.toUpperCase(),
                                                    style: TextStyle(
                                                        fontSize: 14.0))
                                              ]),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Column(children: [
                                                SizedBox(height: 20),
                                                Text(
                                                    '${reservation.du.day} - ${reservation.du.month} - ${reservation.du.year}',
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.black45))
                                              ]),
                                            ],
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Column(children: [
                                                SizedBox(height: 20),
                                                Text('Depart'.toUpperCase(),
                                                    style: TextStyle(
                                                        fontSize: 14.0))
                                              ]),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Column(children: [
                                                SizedBox(height: 15),
                                                Text(
                                                    '${reservation.au.day} - ${reservation.au.month} - ${reservation.au.year}',
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.black45))
                                              ]),
                                            ],
                                          ),
                                        ]),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ))));
                },
              );
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
