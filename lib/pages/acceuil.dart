import 'dart:convert';
import 'package:flutter_app1/model_class/hebergement.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;

import 'all_hebergement_section.dart';
import 'auth/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'mes_hebergements.dart';
import 'mes_reservations.dart';
import 'mes_reservations_clien.dart';
import 'mon_profil.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'pack_complet.dart';

class Acceuil extends StatefulWidget {
  @override
  _AcceuilState createState() => _AcceuilState();
}

class _AcceuilState extends State<Acceuil> {
  //***session get email************ */
  String emailses = "";
  String statuses = "";
  String nomSes = "";
  String prenomSes = "";
  String imageses = "";
  Future getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      emailses = preferences.getString('email');
      statuses = preferences.getString('statu');
      nomSes = preferences.getString('nom');
      prenomSes = preferences.getString('prenom');
      imageses = preferences.getString('imageses');
    });
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

  Future<void> sendemailtophp() async {
    final uri =
        //Uri.parse("https://etnafes.000webhostapp.com/hebergement.php");
        Uri.parse("https://etnafes.000webhostapp.com/hebergement.php");
    var request = http.MultipartRequest('POST', uri);

    request.fields['emailses'] = emailses;

    var response = await request.send();

    if (response.statusCode == 200) {
      print('Image uploaded');
    } else {
      print('Image not uploaded');
    }
  }

//************************************************************************************** */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blueGrey[900],
        toolbarHeight: 65,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 0, right: 50),
              child: Image.asset('assets/LOGO-ETNAFES-blanc1.png',
                  alignment: Alignment.center,
                  height: 50,
                  width: 150,
                  fit: BoxFit.cover),
            ),
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
                        child: SingleChildScrollView(
                      child: AnimationLimiter(
                        child: Column(
                          children: AnimationConfiguration.toStaggeredList(
                            duration: const Duration(milliseconds: 375),
                            childAnimationBuilder: (widget) => SlideAnimation(
                              horizontalOffset: 50.0,
                              child: ScaleAnimation(
                                child: widget,
                              ),
                            ),
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
                                        fontSize: 14.0,
                                        color: Colors.blueGrey[700])),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )))),
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
                    title: Text('Mes Réservations ',
                        style: TextStyle(
                            fontSize: 14.0, color: Colors.blueGrey[700])),
                    leading:
                        Icon(Icons.attach_money, color: Colors.blueGrey[700]),
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
      body: statuses != "prop"
          ? DefaultTabController(
              length: 2,
              child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: new AppBar(
                    backgroundColor: Colors.blueGrey[900],
                    toolbarHeight: 55,
                    bottom: TabBar(
                        labelColor: Colors.blueGrey[900],
                        unselectedLabelColor: Colors.white54,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            color: Colors.white),
                        tabs: [
                          Tab(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("Hébergements",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  )),
                            ),
                          ),
                          Tab(
                            child: Align(
                                alignment: Alignment.center,
                                child: Text("Expériences",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                    ))),
                          )
                        ]),
                  ),
                  body: TabBarView(
                    children: [Acc(), Pack_voyage()],
                  )),
            )
          : DefaultTabController(
              length: 1,
              child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: new AppBar(
                    backgroundColor: Colors.blueGrey[900],
                    toolbarHeight: 55,
                    bottom: TabBar(
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.white54,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            color: Colors.blueGrey[900]),
                        tabs: [
                          Tab(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Hébergements",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  )),
                            ),
                          ),
                        ]),
                  ),
                  body: TabBarView(
                    children: [Acc()],
                  )),
            ),
    );
  }
}

class Acc extends StatefulWidget {
  @override
  _AccState createState() => _AccState();
}

class _AccState extends State<Acc> {
  Future allhebergement() async {
    var url = "https://etnafes.000webhostapp.com/affiche_image_hebergement.php";
    var response = await http.get(url);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1000,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Container(
                child: CarouselHebergement(),
                color: Colors.amber,
                height: 90,
              ),
            ),
          ]),
    );
  }
}

class ThirdScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("ffg");
  }
}
