import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;

import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'acceuil.dart';

class MyHebergementsDetailes extends StatefulWidget {
  final id;
  final nom;
  final imagelink;
  final nbrVoyageurs;
  //final nbrChambreDispo;
  //final nbrPlaceDispo;
  final description;
  final wifi;
  // final laveLinge;
  final chauffage;
  final television;
  final climatisation;
  final eau_chaude;
  final espace_travail_ordinateur;
  final espace_enfant;
  final salle_de_bain;
  final cuisine;
  //final proprietaireId;
  //final villeId;
  //final latitude;
  //final longitude;
  final adresse;

  final disponibilite;
  final prix_enfant15;
  final prix_adulte;

  const MyHebergementsDetailes(
      {Key key,
      this.id,
      this.nom,
      this.imagelink,
      this.nbrVoyageurs,
      this.description,
      this.wifi,
      this.chauffage,
      this.television,
      this.climatisation,
      this.eau_chaude,
      this.espace_travail_ordinateur,
      this.espace_enfant,
      this.salle_de_bain,
      this.cuisine,
      this.adresse,
      this.disponibilite,
      idd,
      this.prix_enfant15,
      this.prix_adulte})
      : super(key: key);

  @override
  _HebergementsDetailesState createState() => _HebergementsDetailesState();
}

class _HebergementsDetailesState extends State<MyHebergementsDetailes> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //*************************************************************************************date depart*************** */
    String xdep = widget.disponibilite
        .toString()
        .substring(0, widget.disponibilite.toString().indexOf(','));

    var dep = DateTime.parse(xdep);
    print("depart");
    print(dep);

//***********************************************************************************date arriver**************************/

    String xarr = widget.disponibilite
        .toString()
        .substring(widget.disponibilite.toString().indexOf(',') + 1);

    var arr = DateTime.parse(xarr);
    print("arriver");
    print(arr);

    //***** *************************************************************************difference******************/
    int difference = arr.difference(dep).inDays;
    print("difference entre depart et arriver ");
    print(difference);
    //****************************************************************************************************** */

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
        body: Container(
          child: ListView(children: <Widget>[
            Card(
              child: Column(children: <Widget>[
                Column(
                  children: [
                    Image.network(
                      widget.imagelink,
                      // this image doesn't exist
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.white,
                          alignment: Alignment.center,
                          child: Text(
                            'Whoops!',
                            style: TextStyle(fontSize: 30),
                          ),
                        );
                      },
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 300,
                      decoration: new BoxDecoration(
                        color: Colors.white,
                      ),
                      child: new TextFormField(
                        decoration: new InputDecoration(
                          border: InputBorder.none,
                        ),
                        textAlign: TextAlign.center,
                        initialValue: widget.nom,
                        readOnly: true,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text("Adresse  ",
                      style: TextStyle(fontSize: 17.0, fontFamily: 'Exo')),
                ),
                Text(widget.adresse,
                    style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'Exo',
                        color: Colors.black38)),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text('Description  ',
                      style: TextStyle(fontSize: 17.0, fontFamily: 'Exo')),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Text(widget.description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Exo',
                        fontSize: 16.0,
                        color: Colors.black38,
                      )),
                ),
              ]),
            ),
            Card(
                child: Column(
              children: <Widget>[
                Row(
                  children: [
                    Text('  𓆰 WIFI  ',
                        style: TextStyle(fontSize: 17.0, fontFamily: 'Exo')),
                    widget.wifi == '1'
                        ? Text(' ✔ ',
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.blue))
                        : Text(' ✘ ',
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.red)),
                  ],
                ),

                Row(
                  children: [
                    Text('  𓆰 Chauffage',
                        style: TextStyle(fontSize: 17.0, fontFamily: 'Exo')),
                    widget.chauffage == '1'
                        ? Text(' ✔ ',
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.blue))
                        : Text(' ✘ ',
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.red)),
                  ],
                ),

                Row(
                  children: [
                    Text('  𓆰 Television',
                        style: TextStyle(fontSize: 17.0, fontFamily: 'Exo')),
                    widget.television == '1'
                        ? Text(' ✔ ',
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.blue))
                        : Text(' ✘ ',
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.red)),
                  ],
                ),
                Row(
                  children: [
                    Text('  𓆰 Climatisation',
                        style: TextStyle(fontSize: 17.0, fontFamily: 'Exo')),
                    widget.climatisation == '1'
                        ? Text(' ✔ ',
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.blue))
                        : Text(' ✘ ',
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.red)),
                  ],
                ),
                Row(
                  children: [
                    Text('  𓆰 Eau Chaude',
                        style: TextStyle(fontSize: 17.0, fontFamily: 'Exo')),
                    widget.eau_chaude == '1'
                        ? Text(' ✔ ',
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.blue))
                        : Text(' ✘ ',
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.red)),
                  ],
                ),
                Row(
                  children: [
                    Text('  𓆰 Espace Travail Ordinateur',
                        style: TextStyle(fontSize: 17.0, fontFamily: 'Exo')),
                    widget.espace_travail_ordinateur == '1'
                        ? Text(' ✔ ',
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.blue))
                        : Text(' ✘ ',
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.red)),
                  ],
                ),

                Row(
                  children: [
                    Text('  𓆰 Espace Enfant',
                        style: TextStyle(fontSize: 17.0, fontFamily: 'Exo')),
                    widget.espace_enfant == '1'
                        ? Text(' ✔ ',
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.blue))
                        : Text(' ✘ ',
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.red)),
                  ],
                ),
                Row(
                  children: [
                    Text('  𓆰 Salle De Bain',
                        style: TextStyle(fontSize: 17.0, fontFamily: 'Exo')),
                    widget.salle_de_bain == '1'
                        ? Text(' ✔ ',
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.blue))
                        : Text(' ✘ ',
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.red)),
                  ],
                ),
                Row(
                  children: [
                    Text('  𓆰 Cuisine',
                        style: TextStyle(fontSize: 17.0, fontFamily: 'Exo')),
                    widget.cuisine == '1'
                        ? Text(' ✔ ',
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.blue))
                        : Text(' ✘ ',
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.red)),
                  ],
                ),
                Row(
                  children: [
                    Text('  𓆰 Prix Adult ' + widget.prix_adulte,
                        style: TextStyle(fontSize: 17.0, fontFamily: 'Exo')),
                  ],
                ),
                Row(
                  children: [
                    Text('  𓆰 Prix Enfant ' + widget.prix_enfant15,
                        style: TextStyle(fontSize: 17.0, fontFamily: 'Exo')),
                  ],
                ),

                /*  Text("  𓆰 Disponibilite " + widget.disponibilite,
                    style: TextStyle(fontSize: 17.0, fontFamily: 'Exo')),*/
                // ignore: deprecated_member_use
                /*  ButtonTheme.bar(
                 child: new ButtonBar(
                    alignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FlatButton(
                        color: Colors.orange,
                        child: const Text('Modifier'),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SecondScreen(
                                        desc: widget.description,
                                        adres: widget.adresse,
                                        p_adult: widget.prix_adulte,
                                        p_enf: widget.prix_enfant15,
                                        nom: widget.nom,
                                        id: widget.id,
                                        dispo: widget.disponibilite,
                                      )));
                        },
                      ),
                    ],
                  ),
                ),*/
                SizedBox(
                  height: 20,
                )

                //******************** */
              ],
            )),
            Container(
                child: SfDateRangePicker(
              view: DateRangePickerView.month,
              monthViewSettings: DateRangePickerMonthViewSettings(
                  blackoutDates: <DateTime>[
                    for (var i = 0; i < difference; i++)
                      dep.add(Duration(days: i)),
                  ]
                    ..add(DateTime(dep.year, dep.month, dep.day))
                    ..add(DateTime(arr.year, arr.month, arr.day)),
                  weekendDays: <int>[]..add(7)..add(6),
                  specialDates: <DateTime>[]
                    ..add(DateTime(2020, 03, 20))
                    ..add(DateTime(2020, 03, 16))
                    ..add(DateTime(2020, 03, 17)),
                  showTrailingAndLeadingDates: true),
              monthCellStyle: DateRangePickerMonthCellStyle(
                blackoutDatesDecoration: BoxDecoration(
                    color: Colors.red,
                    border:
                        Border.all(color: const Color(0xFFF44436), width: 1),
                    shape: BoxShape.circle),
                weekendDatesDecoration: BoxDecoration(
                    color: const Color(0xFFDFDFDF),
                    border:
                        Border.all(color: const Color(0xFFB6B6B6), width: 1),
                    shape: BoxShape.circle),
                specialDatesDecoration: BoxDecoration(
                    color: Colors.green,
                    border:
                        Border.all(color: const Color(0xFF2B732F), width: 1),
                    shape: BoxShape.circle),
                blackoutDateTextStyle: TextStyle(
                    color: Colors.black,
                    decoration: TextDecoration.lineThrough),
                specialDatesTextStyle: const TextStyle(color: Colors.white),
              ),
            )),

            //**** ******************************************************************************/
          ]),
        ));
  }
}

class SecondScreen extends StatefulWidget {
  final id;
  final nom;
  String wifi = '0';

  var dispo;

  var adres;

  var desc;

  var p_adult;

  var p_enf;

//****envoi l'update ***************** */

  SecondScreen({
    this.id,
    this.nom,
    this.wifi,
    this.dispo,
    this.desc,
    this.adres,
    this.p_adult,
    this.p_enf,
  });

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

TextEditingController _adresseController = TextEditingController();
TextEditingController _prixadultController = TextEditingController();
TextEditingController _prixEnfantController = TextEditingController();
TextEditingController _descriptionController = TextEditingController();
TextEditingController _nomController = TextEditingController();

class _SecondScreenState extends State<SecondScreen> {
  Future updateinfo() async {
    final uri =
        Uri.parse("https://etnafes.000webhostapp.com/update_hebergement_detais.php");
    var request = http.MultipartRequest('POST', uri);
    request.fields['id'] = widget.id;
    request.fields['nom'] = widget.nom;
    request.fields['wifi'] = wifi.toString();
    request.fields['chauffage'] = chauffage.toString();
    request.fields['television'] = television.toString();
    request.fields['lave_linge'] = lave_linge.toString();
    request.fields['eau_chaude'] = eau_chaude.toString();
    request.fields['climatisation'] = climatisation.toString();
    request.fields['espace_travail_ordinateur'] =
        espace_travail_ordinateur.toString();
    request.fields['espace_enfant'] = espace_enfant.toString();
    request.fields['salle_de_bain'] = salle_de_bain.toString();
    request.fields['cuisine'] = cuisine.toString();
    request.fields['description'] = _descriptionController.text;
    request.fields['prixEnfant'] = _prixEnfantController.text;
    request.fields['prixAdult'] = _prixadultController.text;
    request.fields['adresse'] = _adresseController.text;
    request.fields['nom'] = _nomController.text;
    request.fields['date'] = getFrom() + ',' + getUntil();
    var response = await request.send();

    response.stream.transform(utf8.decoder).listen((value) async {
      print(value);
      if (value == 'true') {
        print('updated sescecful');

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Acceuil()));
      } else {
        print('faild');
      }
    });
  }

  bool wifi = false;

  bool television = false;
  bool valuesecond = false;
  bool chauffage = false;
  bool lave_linge = false;
  bool eau_chaude = false;
  bool climatisation = false;
  bool espace_travail_ordinateur = false;
  bool espace_enfant = false;
  bool salle_de_bain = false;
  bool cuisine = false;

  @override
  Widget build(BuildContext context) {
    //*************************************************************************************date depart*************** */
    String xdep = widget.dispo
        .toString()
        .substring(0, widget.dispo.toString().indexOf(','));

    var dep = DateTime.parse(xdep);
    print("depart");
    print(dep);

//***********************************************************************************date arriver**************************/

    String xarr = widget.dispo
        .toString()
        .substring(widget.dispo.toString().indexOf(',') + 1);

    var arr = DateTime.parse(xarr);
    print("arriver");
    print(arr);

    final _formKey = GlobalKey<FormState>();
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
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Text(
            widget.nom,
            style: TextStyle(fontSize: 24, color: Colors.black),
          ),
          /* Text(
            widget.id,
            style: TextStyle(fontSize: 24, color: Colors.black),
          ),*/
          Container(
              child: Column(
            children: <Widget>[
              SizedBox(
                width: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Row(children: [
                  const Icon(Icons.assignment),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, top: 30),
                    child: SizedBox(
                      width: 280,
                      child: TextFormField(
                        style: TextStyle(color: Colors.black45),
                        decoration: InputDecoration(
                          fillColor: Colors.black45,
                          labelStyle: TextStyle(
                            color: Colors.black45,
                          ),
                          labelText: 'description',
                        ),
                        controller: _descriptionController,
                        validator: (value) => value.isEmpty
                            ? 'please valide your description'
                            : null,
                      ),
                    ),
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Row(children: [
                  const Icon(Icons.home_outlined),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: SizedBox(
                      width: 280,
                      child: TextFormField(
                        style: TextStyle(color: Colors.black45),
                        decoration: InputDecoration(
                          fillColor: Colors.black45,
                          labelStyle: TextStyle(
                            color: Colors.black45,
                          ),
                          labelText: 'adresse',
                        ),
                        controller: _adresseController,
                        validator: (value) =>
                            value.isEmpty ? 'please valide your adresse' : null,
                      ),
                    ),
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Row(children: [
                  const Icon(Icons.home_outlined),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: SizedBox(
                      width: 280,
                      child: TextFormField(
                        style: TextStyle(color: Colors.black45),
                        decoration: InputDecoration(
                          fillColor: Colors.black45,
                          labelStyle: TextStyle(
                            color: Colors.black45,
                          ),
                          labelText: 'Prix Enfant',
                        ),
                        controller: _prixEnfantController,
                        validator: (value) =>
                            value.isEmpty ? 'please valide your adresse' : null,
                      ),
                    ),
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Row(children: [
                  const Icon(Icons.home_outlined),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: SizedBox(
                      width: 280,
                      child: TextFormField(
                        style: TextStyle(color: Colors.black45),
                        decoration: InputDecoration(
                          fillColor: Colors.black45,
                          labelStyle: TextStyle(
                            color: Colors.black45,
                          ),
                          labelText: 'Prix Adult ',
                        ),
                        controller: _prixadultController,
                        validator: (value) => value.isEmpty
                            ? 'please valide your description'
                            : null,
                      ),
                    ),
                  ),
                ]),
              ),
              CheckboxListTile(
                secondary: const Icon(Icons.wifi),
                title: const Text('Wifi'),
                value: this.wifi,
                onChanged: (bool value) {
                  setState(() {
                    this.wifi = value;
                    print(wifi);
                  });
                },
              ),
              CheckboxListTile(
                controlAffinity: ListTileControlAffinity.trailing,
                secondary: const Icon(Icons.hot_tub),
                title: const Text('Chauffage'),
                value: this.chauffage,
                onChanged: (bool value) {
                  setState(() {
                    this.chauffage = value;
                    print(chauffage);
                  });
                },
              ),
              CheckboxListTile(
                controlAffinity: ListTileControlAffinity.trailing,
                secondary: const Icon(Icons.live_tv),
                title: const Text('Television'),
                value: this.television,
                onChanged: (bool value) {
                  setState(() {
                    this.television = value;
                    print(television);
                  });
                },
              ),
              CheckboxListTile(
                controlAffinity: ListTileControlAffinity.trailing,
                secondary: Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Image.asset('assets/icons8-washing-machine-80.png',
                      height: 25, width: 25, fit: BoxFit.cover),
                ),
                title: const Text('lave linge'),
                value: this.lave_linge,
                onChanged: (bool value) {
                  setState(() {
                    this.lave_linge = value;
                    print(lave_linge);
                  });
                },
              ),
              CheckboxListTile(
                controlAffinity: ListTileControlAffinity.trailing,
                secondary: const Icon(Icons.ac_unit),
                title: const Text('climatisation'),
                value: this.climatisation,
                onChanged: (bool value) {
                  setState(() {
                    this.climatisation = value;
                    print(climatisation);
                  });
                },
              ),
              CheckboxListTile(
                controlAffinity: ListTileControlAffinity.trailing,
                secondary: const Icon(Icons.wash_outlined),
                title: const Text('eau_chaude'),
                value: this.eau_chaude,
                onChanged: (bool value) {
                  setState(() {
                    this.eau_chaude = value;
                    print(eau_chaude);
                  });
                },
              ),
              CheckboxListTile(
                controlAffinity: ListTileControlAffinity.trailing,
                secondary: const Icon(Icons.personal_video_sharp),
                title: const Text('espace_travail_ordinateur'),
                value: this.espace_travail_ordinateur,
                onChanged: (bool value) {
                  setState(() {
                    this.espace_travail_ordinateur = value;
                    print(espace_travail_ordinateur);
                  });
                },
              ),
              CheckboxListTile(
                controlAffinity: ListTileControlAffinity.trailing,
                secondary: const Icon(Icons.baby_changing_station_outlined),
                title: const Text('espace_enfant'),
                value: this.espace_enfant,
                onChanged: (bool value) {
                  setState(() {
                    this.espace_enfant = value;
                    print(espace_enfant);
                  });
                },
              ),
              CheckboxListTile(
                controlAffinity: ListTileControlAffinity.trailing,
                secondary: const Icon(Icons.bathtub_outlined),
                title: const Text('salle_de_bain'),
                value: this.salle_de_bain,
                onChanged: (bool value) {
                  setState(() {
                    this.salle_de_bain = value;
                    print(salle_de_bain);
                  });
                },
              ),
              CheckboxListTile(
                controlAffinity: ListTileControlAffinity.trailing,
                secondary: const Icon(Icons.whatshot_outlined),
                title: const Text('cuisine'),
                value: this.cuisine,
                onChanged: (bool value) {
                  setState(() {
                    this.cuisine = value;
                    print(cuisine);
                  });
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: RaisedButton(
                      child: Text("Du : " + getFrom()),
                      onPressed: () => pickDateRange(context),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.arrow_forward, color: Colors.white),
                  const SizedBox(width: 8),
                  Expanded(
                    child: RaisedButton(
                      child: Text("Au : " + getUntil()),
                      onPressed: () => pickDateRange(context),
                    ),
                  ),
                ],
              ),
              RaisedButton(
                color: Colors.pink,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                padding: EdgeInsets.all(10.0),
                textColor: Colors.white,
                onPressed: () {
                  //********************* */
                  if (getFrom() == "From" ||
                      _adresseController.text == "" ||
                      _descriptionController.text == "") {
                    Fluttertoast.showToast(
                        msg: "Verifier Vos Infomations ",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black87,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  } else {
                    updateinfo();
                  }
                },
                child: Text(
                  'ok',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          )),
        ]),
      ),
    );
  }

  Future pickDateRange(BuildContext context) async {
    final initialDateRange = DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now().add(Duration(hours: 24 * 3)),
    );
    final newDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDateRange: dateRange ?? initialDateRange,
    );

    if (newDateRange == null) return;

    setState(() => dateRange = newDateRange);
  }

  DateTimeRange dateRange;

  String getFrom() {
    if (dateRange == null) {
      return 'From';
    } else {
      return DateFormat('yyyy-MM-dd').format(dateRange.start);
    }
  }

  String getUntil() {
    if (dateRange == null) {
      return 'Until';
    } else {
      return DateFormat('yyyy-MM-dd').format(dateRange.end);
    }
  }
}
