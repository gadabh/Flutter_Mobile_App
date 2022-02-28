import 'dart:convert';

import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app1/model_class/ReservationExperience.dart';
import 'package:flutter_app1/model_class/reservation_client-api.dart';

import 'package:flutter_app1/model_class/reservation_client.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'acceuil.dart';

import 'auth/login_screen.dart';
import 'mes_hebergements.dart';
import 'mes_reservations.dart';
import 'mon_profil.dart';

class ReservationsClien extends StatefulWidget {
  //***session get email************ */
  @override
  _ReservationsClienState createState() => _ReservationsClienState();
}

class _ReservationsClienState extends State<ReservationsClien> {
  String emailses = "";
  String idses = "";
  String nomSes = "";
  String prenomSes = "";
  String statuses = "";
  String imageses = "";

  Future getInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      emailses = preferences.getString('email');
      idses = preferences.getString('idses');
      nomSes = preferences.getString('nom');
      prenomSes = preferences.getString('prenom');
      statuses = preferences.getString('statu');
      imageses = preferences.getString('imageses');
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getInfo());
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
      //********************************************************************* *
      body: DefaultTabController(
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
                        child: Text("Hébergements réservé",
                            style: TextStyle(
                              fontSize: 15.0,
                            )),
                      ),
                    ),
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Expérences réservé",
                            style: TextStyle(
                              fontSize: 15.0,
                            )),
                      ),
                    ),
                  ]),
            ),
            body: TabBarView(
              children: [Reservation_Hebergements(), Experences()],
            )),
      ),
    );
  }
}

class Experences extends StatefulWidget {
  @override
  _ExperencesState createState() => _ExperencesState();
}

class _ExperencesState extends State<Experences> {
  String emailses = "";
  String idses = "";
  String nomSes = "";
  String prenomSes = "";
  String statuses = "";
  String imageses = "";

  Future getInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      emailses = preferences.getString('email');
      idses = preferences.getString('idses');
      nomSes = preferences.getString('nom');
      prenomSes = preferences.getString('prenom');
      statuses = preferences.getString('statu');
      imageses = preferences.getString('imageses');
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getInfo());
  }

  Future<List<ReservationExperience>>
      fetch_reservation_expeience_client() async {
    String url =
        "https://etnafes.000webhostapp.com/reservation_experience.php?idses=$idses";
    final response = await http.get(url);
    return reservationExperienceFromJson(response.body);
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

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      body: FutureBuilder(
        future: fetch_reservation_expeience_client(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, index) {
                ReservationExperience reservationExperience =
                    snapshot.data[index];

                return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 700),
                    child: ScaleAnimation(
                        // verticalOffset: 50.0,
                        child: ScaleAnimation(
                            child: Container(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Card(
                                    child: new InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            type:
                                                PageTransitionType.bottomToTop,
                                            child: Experience_Reserver_Detailes(
                                              id_g: reservationExperience.idG,
                                              id_p: reservationExperience.idP,
                                              nom: reservationExperience.nomG,
                                              prenom_g:
                                                  reservationExperience.prenomG,
                                              cin_g: reservationExperience.cinG,
                                              ville:
                                                  reservationExperience.ville,
                                              programe_g: reservationExperience
                                                  .programe,
                                              image_g:
                                                  reservationExperience.imageG,
                                              depart:
                                                  reservationExperience.depart,
                                              fin: reservationExperience.fin,
                                              date_creation:
                                                  reservationExperience
                                                      .dateCreation,
                                              image:
                                                  reservationExperience.image,
                                            )));
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                                    const EdgeInsets.all(1.0),
                                                child: SizedBox(
                                                    height: 50,
                                                    width: 50,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                      child: Image.network(
                                                        "https://etnafes.000webhostapp.com/uploads/${reservationExperience.imageG}", // this image doesn't exist
                                                        fit: BoxFit.cover,
                                                        errorBuilder: (context,
                                                            error, stackTrace) {
                                                          return Container(
                                                            color: Colors.amber,
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                              'Whoops!',
                                                              style: TextStyle(
                                                                  fontSize: 18),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    )),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      left: 8,
                                                      right: 3,
                                                      top: 8),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text(
                                                        reservationExperience
                                                                .nomG +
                                                            ' ' +
                                                            reservationExperience
                                                                .prenomG,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      Row(children: <Widget>[
                                                        SizedBox(
                                                          height: 15,
                                                          width: 15,
                                                          child: Image(
                                                              image: AssetImage(
                                                                  'assets/loc.png')),
                                                        ),
                                                        Text(
                                                          reservationExperience
                                                              .ville,
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ]),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 10),
                                                        child: Text(
                                                          '${reservationExperience.dateCreation}',
                                                          style: TextStyle(
                                                            color:
                                                                Colors.black38,
                                                          ),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
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
                                                    const EdgeInsets.all(1.0),
                                                child: SizedBox(
                                                  height: 250,
                                                  width: 400,
                                                  child: Card(
                                                      child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    child: Image.network(
                                                      "https://etnafes.000webhostapp.com/uploads/${reservationExperience.image}", // this image doesn't exist
                                                      fit: BoxFit.fill,
                                                      errorBuilder: (context,
                                                          error, stackTrace) {
                                                        return Container(
                                                          color: Colors.amber,
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            'Whoops!',
                                                            style: TextStyle(
                                                                fontSize: 18),
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
                                            padding: const EdgeInsets.only(
                                                right: 10, left: 10, top: 5),
                                            child: Text(
                                              reservationExperience.programe,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontSize: 11),
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.topRight,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                '⇲',
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ))))));
              },
            );
          } else {
            Container(
                child: Scaffold(
                    body: Center(
                        child: Text(' pas de reservation  ',
                            style: TextStyle(
                                fontSize: 17.0, fontFamily: 'Exo')))));
            print("pas reservation");
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    ));
  }
}

class Experience_Reserver_Detailes extends StatefulWidget {
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

  Experience_Reserver_Detailes({
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
  _Experience_Reserver_DetailesState createState() =>
      _Experience_Reserver_DetailesState();
}

class _Experience_Reserver_DetailesState
    extends State<Experience_Reserver_Detailes> {
  final myController = TextEditingController();
  //***session get email************ */
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

//**************************************** */

  Future annuler_reservation() async {
    final uri =
        Uri.parse("https://etnafes.000webhostapp.com/annuler_reservation_experience.php");
    var request = http.MultipartRequest('POST', uri);

    request.fields['idclient'] = idses;
    request.fields['id_p'] = widget.id_p;

    var response = await request.send();

    response.stream.transform(utf8.decoder).listen((value) async {
      print(value);
      if (value == "true") {
        print('Reservation efacer');
        Fluttertoast.showToast(
            msg: "Reservation annuler...",
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

//**************************************** */

  //****************************************************************** */
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
                                    '${widget.date_creation}',
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
                            height: 250,
                            width: 400,
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
                        '${widget.depart}' + " -> " + '${widget.fin}',
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
                            onPressed: () {
                              annuler_reservation();
                            },
                            child: Text(
                              'Annuler la réservation',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
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

//*____________________________________________________________________________

class Reservation_Hebergements extends StatefulWidget {
  @override
  _Reservation_HebergementsState createState() =>
      _Reservation_HebergementsState();
}

class _Reservation_HebergementsState extends State<Reservation_Hebergements> {
  String emailses = "";
  String idses = "";
  String nomSes = "";
  String prenomSes = "";
  String statuses = "";
  String imageses = "";

  Future getInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      emailses = preferences.getString('email');
      idses = preferences.getString('idses');
      nomSes = preferences.getString('nom');
      prenomSes = preferences.getString('prenom');
      statuses = preferences.getString('statu');
      imageses = preferences.getString('imageses');
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getInfo());
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

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      body: FutureBuilder(
        future: fetchreservationClient(idses),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, index) {
                ReservationClient reservationClient = snapshot.data[index];

                return AnimationLimiter(
                    child: Column(
                        children: AnimationConfiguration.toStaggeredList(
                            duration: const Duration(milliseconds: 375),
                            childAnimationBuilder: (widget) => SlideAnimation(
                                  horizontalOffset: 50.0,
                                  child: ScaleAnimation(
                                    child: widget,
                                  ),
                                ),
                            children: <Widget>[
                      Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                decoration: new BoxDecoration(
                                    color: Colors.blueGrey[900],
                                    borderRadius: new BorderRadius.only(
                                        topLeft: const Radius.circular(5.0),
                                        topRight: const Radius.circular(5.0))),
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
                                          'Hebergement ${reservationClient.nom}',
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.white)),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(2.5),
                                    child: Row(
                                      children: [
                                        Text(
                                            ' #️⃣ Code  :' +
                                                reservationClient.code,
                                            style: TextStyle(
                                                fontSize: 13.0,
                                                fontFamily: 'Exo')),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2.5),
                                    child: Row(
                                      children: [
                                        Text(
                                            '  @ adresse  :' +
                                                reservationClient.adresse,
                                            style: TextStyle(
                                                fontSize: 13.0,
                                                fontFamily: 'Exo')),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2.5),
                                    child: Row(
                                      children: [
                                        Text(
                                            ' 📅 Du:' +
                                                reservationClient.du.year
                                                    .toString() +
                                                '-' +
                                                reservationClient.du.month
                                                    .toString() +
                                                '-' +
                                                reservationClient.du.day
                                                    .toString(),
                                            style: TextStyle(
                                                fontSize: 13.0,
                                                fontFamily: 'Exo')),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2.5),
                                    child: Row(
                                      children: [
                                        Text(
                                            ' 📅 Au:' +
                                                reservationClient.au.year
                                                    .toString() +
                                                '-' +
                                                reservationClient.au.month
                                                    .toString() +
                                                '-' +
                                                reservationClient.au.day
                                                    .toString(),
                                            style: TextStyle(
                                                fontSize: 13.0,
                                                fontFamily: 'Exo')),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2.5),
                                    child: Row(
                                      children: [
                                        Text(
                                            ' 🚻 Nombre Adulte  :' +
                                                reservationClient.nbAdulte,
                                            style: TextStyle(
                                                fontSize: 13.0,
                                                fontFamily: 'Exo')),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2.5),
                                    child: Row(
                                      children: [
                                        Text(
                                            ' 🚻 Nombre Enfant  :' +
                                                reservationClient.nbEnfant15,
                                            style: TextStyle(
                                                fontSize: 13.0,
                                                fontFamily: 'Exo')),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text('  📶 WIFI  ',
                                          style: TextStyle(
                                              fontSize: 13.0,
                                              fontFamily: 'Exo')),
                                      reservationClient.wifi == '1'
                                          ? Text(' ✔ ',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.blue))
                                          : Text(' ✘ ',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.red)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('  🌡 Chauffage',
                                          style: TextStyle(
                                              fontSize: 13.0,
                                              fontFamily: 'Exo')),
                                      reservationClient.chauffage == '1'
                                          ? Text(' ✔ ',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.blue))
                                          : Text(' ✘ ',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.red)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('  📺 Television',
                                          style: TextStyle(
                                              fontSize: 13.0,
                                              fontFamily: 'Exo')),
                                      reservationClient.television == '1'
                                          ? Text(' ✔ ',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.blue))
                                          : Text(' ✘ ',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.red)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('  ❄ Climatisation',
                                          style: TextStyle(
                                              fontSize: 13.0,
                                              fontFamily: 'Exo')),
                                      reservationClient.climatisation == '1'
                                          ? Text(' ✔ ',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.blue))
                                          : Text(' ✘ ',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.red)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('  🚿 Eau Chaude',
                                          style: TextStyle(
                                              fontSize: 13.0,
                                              fontFamily: 'Exo')),
                                      reservationClient.eauChaude == '1'
                                          ? Text(' ✔ ',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.blue))
                                          : Text(' ✘ ',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.red)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('  👨‍💻 Espace Travail Ordinateur',
                                          style: TextStyle(
                                              fontSize: 13.0,
                                              fontFamily: 'Exo')),
                                      reservationClient
                                                  .espaceTravailOrdinateur ==
                                              '1'
                                          ? Text(' ✔ ',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.blue))
                                          : Text(' ✘ ',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.red)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('  🧒 Espace Enfant',
                                          style: TextStyle(
                                              fontSize: 13.0,
                                              fontFamily: 'Exo')),
                                      reservationClient.espaceEnfant == '1'
                                          ? Text(' ✔ ',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.blue))
                                          : Text(' ✘ ',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.red)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('  🛀 Salle De Bain',
                                          style: TextStyle(
                                              fontSize: 13.0,
                                              fontFamily: 'Exo')),
                                      reservationClient.salleDeBain == '1'
                                          ? Text(' ✔ ',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.blue))
                                          : Text(' ✘ ',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.red)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('  🔪 Cuisine',
                                          style: TextStyle(
                                              fontSize: 13.0,
                                              fontFamily: 'Exo')),
                                      reservationClient.cuisine == '1'
                                          ? Text(' ✔ ',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.blue))
                                          : Text(' ✘ ',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.red)),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Row(
                                      children: [
                                        Text(
                                            '  💰 Prix Totale : ' +
                                                reservationClient.prixTotal,
                                            style: TextStyle(
                                                fontSize: 13.0,
                                                fontFamily: 'Exo')),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      RaisedButton(
                                        color: Colors.blueGrey[900],
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                        ),
                                        padding: EdgeInsets.all(10.0),
                                        textColor: Colors.white,
                                        onPressed: () {
                                          //********************* */

                                          annuler_reservation_hebergement(
                                              clientId:
                                                  reservationClient.clientId,
                                              hebergementId: reservationClient
                                                  .hebergementId);
                                        },
                                        child: Text(
                                          'Annuler Reservation',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ))
                    ])));
              },
            );
          } else {
            Text(' pas de reservation  ',
                style: TextStyle(fontSize: 17.0, fontFamily: 'Exo'));
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    ));
  }

  Future annuler_reservation_hebergement(
      {String clientId, String hebergementId}) async {
    final uri = Uri.parse(
        "https://etnafes.000webhostapp.com/annuler_reservation_hebergement.php");
    var request = http.MultipartRequest('POST', uri);

    request.fields['idclient'] = idses;
    request.fields['id_h'] = hebergementId;

    var response = await request.send();

    response.stream.transform(utf8.decoder).listen((value) async {
      print(value);
      if (value == "true") {
        print('Reservation efacer');
        Fluttertoast.showToast(
            msg: "Reservation annuler...",
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
}
