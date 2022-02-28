import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_app1/model_class/profil-api.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'acceuil.dart';
import 'auth/login_screen.dart';
import 'mes_hebergements.dart';
import 'mes_reservations.dart';
import 'mes_reservations_clien.dart';

class MonProfil extends StatefulWidget {
  @override
  _MonProfilState createState() => _MonProfilState();
}

class _MonProfilState extends State<MonProfil> {
//*********************get info user from session**************** */
  String emailSes = "";
  String nomSes = "";
  String prenomSes = "";
  String cinSes = "";
  String telSes = "";
  String loginSes = "";
  String imageses = "";
  String statuses = "";
  Future getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      emailSes = preferences.getString('email');
      nomSes = preferences.getString('nom');
      prenomSes = preferences.getString('prenom');
      cinSes = preferences.getString('cin');
      telSes = preferences.getString('tel');
      loginSes = preferences.getString('login');
      imageses = preferences.getString('imageses');
      statuses = preferences.getString('statu');
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

//***************************************************************** */
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()

    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

//***************************************************************** */
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.blueGrey[900],
          toolbarHeight: 65,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Mon Profile",
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white60,
                    fontStyle: FontStyle.normal),
              )
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
                              "https://etnafes.000webhostapp.com/uploads/$imageses", 
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.blueGrey[900],
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
        floatingActionButton: Container(
          height: 70,
          width: 70,
          child: FloatingActionButton(
            heroTag: "btn2",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecondRoute()),
              );
            },
            child: Icon(
              Icons.edit,
              color: Colors.white,
              size: 24.0,
              semanticLabel: 'Text to announce in accessibility modes',
            ),
            backgroundColor: Colors.blueGrey[700],
          ),
        ),
        body: SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            header: WaterDropHeader(),
            footer:
                CustomFooter(builder: (BuildContext context, LoadStatus mode) {
              Widget body;
              if (mode == LoadStatus.idle) {
                body = Text("pull up load");
              }
              return Container(
                height: 55.0,
                child: Center(child: body),
              );
            }),
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: new Container(
                      child: Image(
                          image: AssetImage('assets/gender-neutral-user.png')),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FutureBuilder(
                      future: fetchreProfil(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Card(
                            child: ListView.builder(
                              itemCount: snapshot.data.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: Table(
                                    columnWidths: {
                                      0: FixedColumnWidth(
                                          50.0), // fixed to 100 width
                                    },
                                    defaultColumnWidth: FixedColumnWidth(150.0),
                                    border: TableBorder.all(
                                        color: Colors.white,
                                        style: BorderStyle.solid,
                                        width: 1),
                                    children: [
                                      TableRow(children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Column(children: [
                                              SizedBox(height: 15),
                                              Text('  Nom',
                                                  style:
                                                      TextStyle(fontSize: 18.0))
                                            ]),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Column(children: [
                                              SizedBox(height: 15),
                                              Text(nomSes,
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
                                              SizedBox(height: 15),
                                              Text('  Prenom',
                                                  style:
                                                      TextStyle(fontSize: 18.0))
                                            ]),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Column(children: [
                                              SizedBox(height: 15),
                                              Text(prenomSes,
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
                                              SizedBox(height: 15),
                                              Text('  CIN',
                                                  style:
                                                      TextStyle(fontSize: 18.0))
                                            ]),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Column(children: [
                                              SizedBox(height: 15),
                                              Text(cinSes,
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
                                              SizedBox(height: 15),
                                              Text('  Email',
                                                  style:
                                                      TextStyle(fontSize: 18.0))
                                            ]),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Column(children: [
                                              SizedBox(height: 15),
                                              Text(emailSes,
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
                                              SizedBox(height: 15),
                                              Text('  Telephone',
                                                  style:
                                                      TextStyle(fontSize: 18.0))
                                            ]),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Column(children: [
                                              SizedBox(height: 15),
                                              Text(telSes,
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
                                              SizedBox(height: 15),
                                              Text('  login',
                                                  style:
                                                      TextStyle(fontSize: 18.0))
                                            ]),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Column(children: [
                                              SizedBox(height: 15),
                                              Text(loginSes,
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
                                              SizedBox(height: 15),
                                              Text('  ',
                                                  style:
                                                      TextStyle(fontSize: 18.0))
                                            ]),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Column(children: [
                                              SizedBox(height: 15),
                                              Text('',
                                                  style:
                                                      TextStyle(fontSize: 16.0))
                                            ]),
                                          ],
                                        ),
                                      ]),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        }
                        return CircularProgressIndicator();
                      },
                    ),
                  ),
                ],
              ),
            )));
  }
}

//*********************************************** */

class SecondRoute extends StatefulWidget {
  @override
  _SecondRouteState createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
  //*********************get info user from session**************** */

  String nomSes = "";
  String prenomSes = "";
  String cinSes = "";
  String telSes = "";

  //********************************************************************************************* */

  Future update() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        print('Update');
        //**********nom************************************* */
        print(" nom");
        preferences.setString('nom', _nomController.text);
        //**********prenom************************************* */
        print(" prenom");
        preferences.setString('prenom', _prenomController.text);

        //**********Cin************************************* */
        print(" Cin");
        preferences.setString('cin', _cinController.text);
        //*********************************************** */
        //**********image************************************* */
        print(" image");
        String value = _image.path;
        var depimg = value.indexOf('cache/') + 6;

        print(value.substring(depimg));
        var image = value.substring(depimg);
        print(image);
        preferences.setString('imageses', image);

        //*********************************************** */

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MonProfil()));
      });
    }
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

//***session get email************ */
  String emailses = "";
  String statuses = "";
  Future getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Fluttertoast.showToast(
        msg: " ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black54,
        textColor: Colors.white);
    setState(() {
      emailses = preferences.getString('email');
      statuses = preferences.getString('statu');
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getEmail());
  }

//*************************************************************************
  //***********************envois des donnes au fichier php***************************************** */
  TextEditingController _nomController = TextEditingController();
  TextEditingController _prenomController = TextEditingController();
  TextEditingController _cinController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

//********************************************************************************************* */

//************************************************************************************** */

//********uploade image **************************************************** */
  File _image;
  final picker = ImagePicker();

  Future choiceImage() async {
    var pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage.path);
    });
  }

  Future updateprofil() async {
    print(_nomController.text);
    print(_prenomController.text);
    print(_cinController.text);
    print(_passwordController.text);
    print(emailses);
    print(statuses);
    print(_image.path);
    print(_image);
    //**********image************************************* */
    print(" image");

    final uri = Uri.parse("https://etnafes.000webhostapp.com/update_profil.php");
    var request = http.MultipartRequest('POST', uri);

    request.fields['nom'] = _nomController.text;
    request.fields['prenom'] = _prenomController.text;
    request.fields['cin'] = _cinController.text;
    request.fields['password'] = _passwordController.text;
    request.fields['emailses'] = emailses;
    request.fields['statuses'] = statuses;
    var pic = await http.MultipartFile.fromPath("image", _image.path);
    request.files.add(pic);
    var response = await request.send();

    Fluttertoast.showToast(
        msg: "Waite... ",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0);

    Fluttertoast.showToast(
        msg: "Informations Sauvegarder... ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0);

    if (response.statusCode == 200) {
      print('Image uploaded');
      update();
    } else {
      print('Image not uploaded');
    }
  }
//************************************************************************** */

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
        floatingActionButton: Container(
          height: 70,
          width: 70,
          child: FloatingActionButton(
            heroTag: "btn3",
            onPressed: () {
              //********************* */

              updateprofil();
            },
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 24.0,
              semanticLabel: 'ok',
            ),
            backgroundColor: Colors.blueGrey[700],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 0),
                child: FutureBuilder(
                  future: fetchreProfil(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Card(
                        child: ListView.builder(
                          itemCount: snapshot.data.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(0),
                              child: Table(
                                  columnWidths: {
                                    0: FixedColumnWidth(
                                        50.0), // fixed to 100 width
                                  },
                                  defaultColumnWidth: FixedColumnWidth(150.0),
                                  border: TableBorder.all(
                                      color: Colors.white,
                                      style: BorderStyle.solid,
                                      width: 1),
                                  children: [
                                    TableRow(children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 18),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Column(children: [
                                              Text('  Nom',
                                                  style:
                                                      TextStyle(fontSize: 18.0))
                                            ]),
                                          ],
                                        ),
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          labelText: ' nom',
                                        ),
                                        controller: _nomController,
                                        validator: (value) => value.isEmpty
                                            ? 'please valide your nom'
                                            : null,
                                      ),
                                    ]),
                                    TableRow(children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 18),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Column(children: [
                                              Text('  Prenom',
                                                  style:
                                                      TextStyle(fontSize: 18.0))
                                            ]),
                                          ],
                                        ),
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          labelText: ' Prenom',
                                        ),
                                        controller: _prenomController,
                                        validator: (value) => value.isEmpty
                                            ? 'please valide your prenom'
                                            : null,
                                      ),
                                    ]),
                                    TableRow(children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 18),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Column(children: [
                                              Text('  Cin',
                                                  style:
                                                      TextStyle(fontSize: 18.0))
                                            ]),
                                          ],
                                        ),
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          labelText: ' Cin',
                                        ),
                                        controller: _cinController,
                                        validator: (value) => value.isEmpty
                                            ? 'please valide your cin'
                                            : null,
                                      ),
                                    ]),
                                    TableRow(children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 18),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Column(children: [
                                              Text('  password',
                                                  style:
                                                      TextStyle(fontSize: 18.0))
                                            ]),
                                          ],
                                        ),
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          labelText: ' password',
                                        ),
                                        controller: _passwordController,
                                        validator: (value) => value.isEmpty
                                            ? 'please valide your password'
                                            : null,
                                      ),
                                    ]),
                                    TableRow(children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 18),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 20),
                                              child: new Container(
                                                //   color: Colors.black12,
                                                child: IconButton(
                                                  icon: Icon(Icons.camera),
                                                  onPressed: () {
                                                    choiceImage();
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: _image == null
                                            ? Text('pas d image selectionne')
                                            : Image.file(
                                                _image,
                                                height: 200,
                                                width: 200,
                                              ),
                                      ),
                                    ]),
                                  ]),
                            );
                          },
                        ),
                      );
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
