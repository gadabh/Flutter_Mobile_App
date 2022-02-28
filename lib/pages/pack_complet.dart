import 'dart:convert';
import 'package:flutter_app1/model_class/hebergement.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;

import 'acceuil.dart';
import 'all_hebergement_section.dart';
import 'auth/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animated_button/animated_button.dart';
import 'mes_hebergements.dart';
import 'mes_reservations.dart';
import 'mes_reservations_clien.dart';
import 'mon_profil.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Pack_voyage extends StatefulWidget {
  @override
  _Pack_voyageState createState() => _Pack_voyageState();
}

class _Pack_voyageState extends State<Pack_voyage> {
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

//************************************************************************************** */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Accpack(),
    );
  }
}

class Accpack extends StatefulWidget {
  @override
  _AccpackState createState() => _AccpackState();
}

class _AccpackState extends State<Accpack> {
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: CarouselAllGuide(),
          ),
        ]);
  }
}

class CarouselAllGuide extends StatefulWidget {
  @override
  _CarouselAllGuideState createState() => _CarouselAllGuideState();
}

class _CarouselAllGuideState extends State<CarouselAllGuide> {
  //***session get email******************************************************* */
  String emailses = "";
  String idses = "";
  Future getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      emailses = preferences.getString('email');
      idses = preferences.getString('idses');
    });
  }

  @override
  void initState() {
    super.initState();
    getEmail();
  }

  Future allGuide() async {
    var url = "https://etnafes.000webhostapp.com/affiche_guide.php";
    var response = await http.get(url);

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0.0),
      height: MediaQuery.of(context).size.height * 0.35,
      child: Scaffold(
        body: FutureBuilder(
          future: allGuide(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, index) {
                      List list = snapshot.data;

                      return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 700),
                          child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: ScaleAnimation(
                                  child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      child: Card(
                                          child: new InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                  type: PageTransitionType
                                                      .bottomToTop,
                                                  child: GuideDetailes(
                                                    id_g: list[index]['id_g'],
                                                    id_p: list[index]['id_p'],
                                                    nom: list[index]['nom_g'],
                                                    prenom_g: list[index]
                                                        ['prenom_g'],
                                                    cin_g: list[index]['cin_g'],
                                                    ville: list[index]['ville'],
                                                    programe_g: list[index]
                                                        ['programe'],
                                                    image_g: list[index]
                                                        ['image_g'],
                                                    depart: list[index]
                                                        ['depart'],
                                                    fin: list[index]['fin'],
                                                    date_creation: list[index]
                                                        ['date_creation'],
                                                    image: list[index]['image'],
                                                  )));
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            //***** */

                                            //******* */

                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              1.0),
                                                      child: SizedBox(
                                                          height: 50,
                                                          width: 50,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0),
                                                            child:
                                                                Image.network(
                                                              "https://etnafes.000webhostapp.com/uploads/${list[index]['image_g']}", // this image doesn't exist
                                                              fit: BoxFit.cover,
                                                              errorBuilder:
                                                                  (context,
                                                                      error,
                                                                      stackTrace) {
                                                                return Container(
                                                                  color: Colors
                                                                      .amber,
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(
                                                                    'Whoops!',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            18),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          )),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 8,
                                                                right: 3,
                                                                top: 8),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Text(
                                                              ' ${list[index]['nom_g']}' +
                                                                  ' ' +
                                                                  '${list[index]['prenom_g']}',
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                            Row(children: <
                                                                Widget>[
                                                              SizedBox(
                                                                height: 15,
                                                                width: 15,
                                                                child: Image(
                                                                    image: AssetImage(
                                                                        'assets/loc.png')),
                                                              ),
                                                              Text(
                                                                '${list[index]['ville']}',
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ]),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 10),
                                                              child: Text(
                                                                list[index][
                                                                    'date_creation'],
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black38,
                                                                ),
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                            Divider(),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              1.0),
                                                      child: SizedBox(
                                                        height: 220,
                                                        width: 350,
                                                        child: Card(
                                                            child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                          child: Image.network(
                                                            "https://etnafes.000webhostapp.com/uploads/${list[index]['image']}", // this image doesn't exist
                                                            fit: BoxFit.fill,
                                                            errorBuilder:
                                                                (context, error,
                                                                    stackTrace) {
                                                              return Container(
                                                                color: Colors
                                                                    .amber,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(
                                                                  'Whoops!',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          18),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        )),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10,
                                                          left: 10,
                                                          top: 5),
                                                  child: Text(
                                                    list[index]['programe'],
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        decoration:
                                                            TextDecoration.none,
                                                        fontSize: 11),
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Container(
                                                  alignment: Alignment.topRight,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      '⇲',
                                                      maxLines: 3,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ))))));
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

class GuideDetailes extends StatefulWidget {
  final id_g;
  final emailses;
  final nom;
  final prenom_g;
  final cin_g;

  final ville;
  final programe_g;
  final image_g;
  final depart;
  final fin;
  final date_creation;
  final image;
  final id_p;

  GuideDetailes({
    this.id_g,
    this.emailses,
    this.nom,
    this.prenom_g,
    this.cin_g,
    this.ville,
    this.programe_g,
    this.image_g,
    this.depart,
    this.fin,
    this.date_creation,
    this.image,
    this.id_p,
  });

  @override
  _GuideDetailesState createState() => _GuideDetailesState();
}

class _GuideDetailesState extends State<GuideDetailes> {
  final myController = TextEditingController();
  //***session get email************ */
  String emailses = "";
  String idses = "";

  Future getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      emailses = preferences.getString('email');
      idses = preferences.getString('idses');
      reserver_or_not();
    });
  }

  @override
  void initState() {
    super.initState();

    getEmail();
  }

//**************************************** */

  Future reserver() async {
    final uri = Uri.parse("https://etnafes.000webhostapp.com/reservation_programe.php");
    var request = http.MultipartRequest('POST', uri);

    request.fields['idclient'] = idses;
    request.fields['id_p'] = widget.id_p;

    var response = await request.send();

    response.stream.transform(utf8.decoder).listen((value) async {
      print(value);
      if (value == "true") {
        print('Reservation sescecful');
        Fluttertoast.showToast(
            msg: "Reservation efectuer...",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black87,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Acceuil()));
      } else {
        print('faild');
      }
    });
  }

//************************************************************************** */

  Future reserver_or_not() async {
    final uri =
        Uri.parse("https://etnafes.000webhostapp.com/programe_reserver_or_not.php");
    var request = http.MultipartRequest('POST', uri);

    request.fields['idclient'] = idses;
    request.fields['id_p'] = widget.id_p;

    var response = await request.send();

    response.stream.transform(utf8.decoder).listen((value) async {
      print(value);
      if (value == "true") {
        print('***************************************');
        print('reserver');
        myController.text = 'Place Réserver';
      } else {
        print('***************************************');

        print('nn reserver');
        myController.text = 'Réserver Votre Place';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
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
      body: SingleChildScrollView(
          child: Column(children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            //***** */

            //******* */

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                //***** */

                //******* */

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: SizedBox(
                              height: 50,
                              width: 50,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image.network(
                                  "https://etnafes.000webhostapp.com/uploads/${widget.image_g}", // this image doesn't exist
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
                              )),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.only(left: 8, right: 3, top: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  widget.nom + ' ' + widget.prenom_g,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(children: <Widget>[
                                  SizedBox(
                                    height: 15,
                                    width: 15,
                                    child: Image(
                                        image: AssetImage('assets/loc.png')),
                                  ),
                                  Text(
                                    widget.ville,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ]),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    widget.date_creation,
                                    style: TextStyle(
                                      color: Colors.black38,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Divider(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: SizedBox(
                            height: 270,
                            width: 409,
                            child: Card(
                                child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                "https://etnafes.000webhostapp.com/uploads/${widget.image}", // this image doesn't exist
                                fit: BoxFit.fill,
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
                            )),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 10, left: 10, top: 5),
                      child: Text(
                        widget.depart + " -> " + widget.fin,
                        style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.none,
                            fontSize: 11),
                        maxLines: 500,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 10, left: 10, top: 5),
                      child: Text(
                        widget.programe_g,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.none,
                            fontSize: 11),
                        maxLines: 500,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          AnimatedButton(
                            child: TextField(
                              controller: myController,
                              textAlign: TextAlign.center,
                              enabled: false,
                              style:
                                  TextStyle(fontSize: 10, color: Colors.white),
                            ),
                            onPressed: () {
                              reserver();
                            },
                            duration: 70,
                            height: 50,
                            width: 200,
                            shadowDegree: ShadowDegree.dark,
                            color: Colors.blueGrey[900],
                          )
                        ])
                  ],
                ),
              ],
            ),
          ],
        ),
      ])),
    ));
  }
}
