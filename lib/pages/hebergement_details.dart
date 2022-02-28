import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app1/pages/reclamation.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:dropdown_below/dropdown_below.dart';
import 'package:cool_alert/cool_alert.dart';

import 'acceuil.dart';
import 'mes_reservations.dart';
import 'mes_reservations_clien.dart';

class HebergementsDetailes extends StatefulWidget {
  final id;
  final nom;
  final imagelink;
  final nbrVoyageurs;
  final nB_jaime;
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
  final nB_jaime_pas;
  final adresse;
  final nb_images;
  // final chambreIndividuel;
  // final chambreADeux;
  //final chambreATrois;
  final prix_adulte;
  final prix_enfant15;
  final disponibilite;

  HebergementsDetailes(
      {this.id,
      this.description,
      this.nom,
      this.television,
      this.chauffage,
      this.imagelink,
      this.wifi,
      this.nbrVoyageurs,
      this.climatisation,
      this.eau_chaude,
      this.espace_travail_ordinateur,
      this.espace_enfant,
      this.salle_de_bain,
      this.cuisine,
      this.adresse,
      this.disponibilite,
      this.nB_jaime,
      String emailses,
      this.nB_jaime_pas,
      this.nb_images,
      this.prix_adulte,
      this.prix_enfant15});

  @override
  _HebergementsDetailesState createState() => _HebergementsDetailesState();
}

class _HebergementsDetailesState extends State<HebergementsDetailes> {
  List<DateTime> daybet;

  var list;

  Future<bool> updateLikeplus1(bool isLiked) async {
    final uri = Uri.parse("https://etnafes.000webhostapp.com/updateLikeplus.php");
    var request = http.MultipartRequest('POST', uri);

    request.fields['idheb'] = widget.id;
    request.fields['idses'] = idses;
    var response = await request.send();

    response.stream.transform(utf8.decoder).listen((value) async {
      print(value);
      if (value == "true") {
        print('***************************************');
        print('like +1');
      } else {
        print('***************************************');

        print(value);
      }
    });
    return !isLiked;
  }

  Future<bool> updateLikemoin1(bool isLiked) async {
    final uri = Uri.parse("https://etnafes.000webhostapp.com/updateLikemoin.php");
    var request = http.MultipartRequest('POST', uri);

    request.fields['idheb'] = widget.id;
    request.fields['idses'] = idses;
    var response = await request.send();

    response.stream.transform(utf8.decoder).listen((value) async {
      print(value);
      if (value == "true") {
        print('***************************************');
        print('like +1');
      } else {
        print('***************************************');

        print(value);
      }
    });
    return !isLiked;
  }

  Future ifLikeOnLoad(String idses) async {
    final uri = Uri.parse("https://etnafes.000webhostapp.com/ifLikeOnLoad.php");
    var request = http.MultipartRequest('POST', uri);

    request.fields['idheb'] = widget.id;
    request.fields['idses'] = idses;
    var response = await request.send();

    response.stream.transform(utf8.decoder).listen((value) async {
      print(value);
      if (value == "7atet j aime") {
        print('***************************************');

        print(value);

        print('***************************************');
      } else {
        print('***************************************');

        print(value);
        print('***************************************');
      }
    });
  }

  int x = 0;

  //***session get email************ */
  String emailses = "";
  String statuses = "";
  String nomSes = "";
  String prenomSes = "";
  String idses = "";
  Future getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      emailses = preferences.getString('email');
      statuses = preferences.getString('statu');
      nomSes = preferences.getString('nom');
      prenomSes = preferences.getString('prenom');
      idses = preferences.getString('idses');
      ifLikeOnLoad(idses);
    });
  }

  @override
  void initState() {
    super.initState();
    getEmail();
  }

  //***************************** */

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DateTime date = new DateFormat("dd-MM-yyyy").parse(widget.disponibilite);
    List<DateTime> days = [];

    List<DateTime> getDaysInBeteween(DateTime startDate, DateTime endDate) {
      List<DateTime> days = [];
      for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
        days.add(startDate.add(Duration(days: i)));
      }
      return days;
    }

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

    daybet = getDaysInBeteween(dep, arr);
    //***** *************************************************************************difference******************/
    int difference = arr.difference(dep).inDays;
    print("difference entre depart et arriver ");
    print(difference);
    //****************************************************************************************************** */
//**************devision des images ****************************************************************************************

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
      body: ListView(children: <Widget>[
        Card(
            child: Column(children: <Widget>[
          Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5.0),
                ),
                child: Container(
                  child: Image.network(
                    widget.imagelink,
                    // this image doesn't exist
                    fit: BoxFit.fitWidth,
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
                ),
              ),
              new Container(
                color: Colors.blueGrey[900],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Icon(Icons.home_outlined, color: Colors.pink),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.only(left: 8, right: 3, top: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  widget.nom,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontFamily: 'Exo'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                ),
                              ],
                            ),
                          ),
                        ),
                        statuses != "prop"
                            ? LikeButton(
                                onTap: updateLikeplus1,
                                size: 40,
                                circleColor: CircleColor(
                                    start: Color(0xff00ddff),
                                    end: Color(0xff0099cc)),
                                bubblesColor: BubblesColor(
                                  dotPrimaryColor: Color(0xff33b5e5),
                                  dotSecondaryColor: Color(0xff0099cc),
                                ),
                                likeBuilder: (bool isLiked) {
                                  return Icon(
                                    Icons.thumb_up,
                                    color: isLiked
                                        ? Colors.pinkAccent
                                        : Colors.grey,
                                    size: 30,
                                  );
                                },
                                likeCount: int.parse(widget.nB_jaime),
                                countBuilder:
                                    (int count, bool isLiked, String text) {
                                  var color =
                                      isLiked ? Colors.white : Colors.grey;

                                  Widget result;
                                  if (count == 0) {
                                    result = Text(
                                      "0",
                                      style: TextStyle(color: color),
                                    );
                                  } else
                                    result = Text(
                                      text,
                                      style: TextStyle(color: color),
                                    );
                                  return result;
                                },
                              )
                            : Text(" "),
                        statuses != "prop"
                            ? Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: LikeButton(
                                  onTap: updateLikemoin1,
                                  size: 40,
                                  circleColor: CircleColor(
                                      start: Color(0xff00ddff),
                                      end: Color(0xff0099cc)),
                                  bubblesColor: BubblesColor(
                                    dotPrimaryColor: Color(0xff33b5e5),
                                    dotSecondaryColor: Color(0xff0099cc),
                                  ),
                                  likeBuilder: (bool isLiked) {
                                    return Icon(
                                      Icons.thumb_down,
                                      color: isLiked
                                          ? Colors.pinkAccent
                                          : Colors.grey,
                                      size: 30,
                                    );
                                  },
                                  likeCount: int.parse(widget.nB_jaime_pas),
                                  countBuilder:
                                      (int count, bool isLiked, String text) {
                                    var color =
                                        isLiked ? Colors.white : Colors.grey;

                                    Widget result;
                                    if (count == 0) {
                                      result = Text(
                                        "0",
                                        style: TextStyle(color: color),
                                      );
                                    } else
                                      result = Text(
                                        text,
                                        style: TextStyle(color: color),
                                      );
                                    return result;
                                  },
                                ),
                              )
                            : Text(" ")
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          ColoredBox(
            color: Colors.white54,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text("Adresse  ",
                    style: TextStyle(fontSize: 17.0, fontFamily: 'Exo')),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Text(widget.adresse,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Exo',
                      fontSize: 16.0,
                      color: Colors.black38,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text('Description  ',
                    style: TextStyle(fontSize: 17.0, fontFamily: 'Exo')),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15, top: 10),
                child: Text(widget.description,
                    maxLines: 500,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Exo',
                      fontSize: 16.0,
                      color: Colors.black38,
                    )),
              ),
            ]),
          ),
        ])),

        Card(
            child: Column(
          children: <Widget>[
            Row(
              children: [
                Text('  📶 WIFI  ',
                    style: TextStyle(fontSize: 17.0, fontFamily: 'Exo')),
                widget.wifi == '1'
                    ? Text(' ✔ ',
                        style: TextStyle(fontSize: 16.0, color: Colors.blue))
                    : Text(' ✘ ',
                        style: TextStyle(fontSize: 16.0, color: Colors.pink)),
              ],
            ),
            Row(
              children: [
                Text('  🌡 Chauffage',
                    style: TextStyle(fontSize: 17.0, fontFamily: 'Exo')),
                widget.chauffage == '1'
                    ? Text(' ✔ ',
                        style: TextStyle(fontSize: 16.0, color: Colors.blue))
                    : Text(' ✘ ',
                        style: TextStyle(fontSize: 16.0, color: Colors.pink)),
              ],
            ),
            Row(
              children: [
                Text('  📺 Television',
                    style: TextStyle(fontSize: 17.0, fontFamily: 'Exo')),
                widget.television == '1'
                    ? Text(' ✔ ',
                        style: TextStyle(fontSize: 16.0, color: Colors.blue))
                    : Text(' ✘ ',
                        style: TextStyle(fontSize: 16.0, color: Colors.pink)),
              ],
            ),
            Row(
              children: [
                Text('  ❄ Climatisation',
                    style: TextStyle(fontSize: 17.0, fontFamily: 'Exo')),
                widget.climatisation == '1'
                    ? Text(' ✔ ',
                        style: TextStyle(fontSize: 16.0, color: Colors.blue))
                    : Text(' ✘ ',
                        style: TextStyle(fontSize: 16.0, color: Colors.pink)),
              ],
            ),
            Row(
              children: [
                Text('  🚿  Eau Chaude',
                    style: TextStyle(fontSize: 17.0, fontFamily: 'Exo')),
                widget.eau_chaude == '1'
                    ? Text(' ✔ ',
                        style: TextStyle(fontSize: 16.0, color: Colors.blue))
                    : Text(' ✘ ',
                        style: TextStyle(fontSize: 16.0, color: Colors.pink)),
              ],
            ),
            Row(
              children: [
                Text('  👨‍💻  Espace Travail Ordinateur',
                    style: TextStyle(fontSize: 17.0, fontFamily: 'Exo')),
                widget.espace_travail_ordinateur == '1'
                    ? Text(' ✔ ',
                        style: TextStyle(fontSize: 16.0, color: Colors.blue))
                    : Text(' ✘ ',
                        style: TextStyle(fontSize: 16.0, color: Colors.pink)),
              ],
            ),
            Row(
              children: [
                Text('  🧒  Espace Enfant',
                    style: TextStyle(fontSize: 17.0, fontFamily: 'Exo')),
                widget.espace_enfant == '1'
                    ? Text(' ✔ ',
                        style: TextStyle(fontSize: 16.0, color: Colors.blue))
                    : Text(' ✘ ',
                        style: TextStyle(fontSize: 16.0, color: Colors.pink)),
              ],
            ),
            Row(
              children: [
                Text('  🛀  Salle De Bain',
                    style: TextStyle(fontSize: 17.0, fontFamily: 'Exo')),
                widget.salle_de_bain == '1'
                    ? Text(' ✔ ',
                        style: TextStyle(fontSize: 16.0, color: Colors.blue))
                    : Text(' ✘ ',
                        style: TextStyle(fontSize: 16.0, color: Colors.pink)),
              ],
            ),
            Row(
              children: [
                Text(' 🔪  Cuisine',
                    style: TextStyle(fontSize: 17.0, fontFamily: 'Exo')),
                widget.cuisine == '1'
                    ? Text(' ✔ ',
                        style: TextStyle(fontSize: 16.0, color: Colors.blue))
                    : Text(' ✘ ',
                        style: TextStyle(fontSize: 16.0, color: Colors.pink)),
              ],
            ),
            Row(
              children: [
                Text('  💰 Prix adulte ' + widget.prix_adulte,
                    style: TextStyle(fontSize: 17.0, fontFamily: 'Exo')),
              ],
            ),
            Row(
              children: [
                Text('  💰 Prix enfant ' + widget.prix_enfant15,
                    style: TextStyle(fontSize: 17.0, fontFamily: 'Exo')),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            if (statuses == "client")
              FlatButton(
                color: Colors.blueGrey[900],
                child: const Text('Réserver '),
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => reserver_maisons(
                                arr: arr,
                                img: widget.imagelink,
                                idses: idses,
                                nomheberg: widget.nom,
                                prixEnfant15: widget.prix_enfant15,
                                prix_adulte: widget.prix_adulte,
                                idheb: widget.id,
                              )));
                },
              ),
          ],
        )),

        Container(
            child: SfDateRangePicker(
          view: DateRangePickerView.month,
          monthViewSettings: DateRangePickerMonthViewSettings(
              blackoutDates: <DateTime>[
                for (var i = 0; i < difference; i++) dep.add(Duration(days: i)),
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
                border: Border.all(color: const Color(0xFFF44436), width: 1),
                shape: BoxShape.circle),
            weekendDatesDecoration: BoxDecoration(
                color: const Color(0xFFDFDFDF),
                border: Border.all(color: const Color(0xFFB6B6B6), width: 1),
                shape: BoxShape.circle),
            specialDatesDecoration: BoxDecoration(
                color: Colors.green,
                border: Border.all(color: const Color(0xFF2B732F), width: 1),
                shape: BoxShape.circle),
            blackoutDateTextStyle: TextStyle(
                color: Colors.black, decoration: TextDecoration.lineThrough),
            specialDatesTextStyle: const TextStyle(color: Colors.white),
          ),
        )),

        //**** ******************************************************************************/
        statuses != "prop"
            ? Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, //change here don't //worked
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        primary: Colors.white,
                        backgroundColor: Colors.blueGrey[900],
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),

                      // Defer to the widget's default.

                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Reclamation(
                                      nom_hebergement: widget.nom,
                                      nom_client: emailses,
                                      idheb: widget.id,
                                      idses: idses,
                                    )));
                      },
                      child: Text('Réclamer ')),
                ],
              )
            : Text("")
      ]),
    );
  }
}

//******************************************************************************************************************************** */
//******************************************************************************************************************************** */
//******************************************************************************************************************************** */
//******************************************************************************************************************************** */

class reserver_maisons extends StatefulWidget {
  final idses;
  final idheb;
  final nomheberg;
  final img;
  final arr;
  final prixEnfant15;
  final prix_adulte;
//****envoi l'update ***************** */

  reserver_maisons(
      {this.idses,
      this.idheb,
      this.nomheberg,
      this.img,
      DateTime this.arr,
      this.prixEnfant15,
      this.prix_adulte});

  @override
  _reserver_maisonsState createState() => _reserver_maisonsState();
}

class _reserver_maisonsState extends State<reserver_maisons> {
//*****gestion de prix *************************************** */

  //*******liste*********************************************** */

  List _listAdlt = ['1', '2', '3'];
  List _listEnf = ['1', '2', '3'];
  List<DropdownMenuItem> _dropdownAdltItems;
  List<DropdownMenuItem> _dropdownEnfItems;
  var _selectedAdltTest;
  var _selectedEnfTest;
  List<DropdownMenuItem> buildDropdownAdltItems(List _listAdlt) {
    List<DropdownMenuItem> items = [];
    for (var i in _listAdlt) {
      items.add(
        DropdownMenuItem(
          value: i,
          child: Text(i),
        ),
      );
    }
    return items;
  }

  List<DropdownMenuItem> buildDropdownEnfItems(List _listEnf) {
    List<DropdownMenuItem> items = [];
    for (var i in _listEnf) {
      items.add(
        DropdownMenuItem(
          value: i,
          child: Text(i),
        ),
      );
    }
    return items;
  }

  onChangeDropdownTestsEnf(selectedEnfTest) {
    print(selectedEnfTest);
    setState(() {
      _selectedEnfTest = selectedEnfTest;
    });
  }

  onChangeDropdownTestsAdlt(selectedAdltTest) {
    print(selectedAdltTest);
    setState(() {
      _selectedAdltTest = selectedAdltTest;
    });
  }

  @override
  void initState() {
    _dropdownAdltItems = buildDropdownAdltItems(_listAdlt);
    _dropdownEnfItems = buildDropdownEnfItems(_listEnf);
    super.initState();
  }

  //************date picker*********************** */
  var pt = '';
  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _range1 = '';

  String _range2 = '';
  int _rangeDiff = 0;
  String _rangeCount = '';

  /// The method for [DateRangePickerSelectionChanged] callback, which will be
  /// called whenever a selection changed on the date picker widget.
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    /// The argument value will return the changed date as [DateTime] when the
    /// widget [SfDateRangeSelectionMode] set as single.
    ///
    /// The argument value will return the changed dates as [List<DateTime>]
    /// when the widget [SfDateRangeSelectionMode] set as multiple.
    ///
    /// The argument value will return the changed range as [PickerDateRange]
    /// when the widget [SfDateRangeSelectionMode] set as range.
    ///
    /// The argument value will return the changed ranges as
    /// [List<PickerDateRange] when the widget [SfDateRangeSelectionMode] set as
    /// multi range.
    setState(() {
      if (args.value is PickerDateRange) {
        _range1 =
            DateFormat('yyyy/MM/dd').format(args.value.startDate).toString();

        _range2 = DateFormat('yyyy/MM/dd')
            .format(args.value.endDate ?? args.value.startDate)
            .toString();
        print("dep" + _range1);
        var newDateTimeObj1 =
            new DateFormat("yyyy-MM-dd").parse(args.value.startDate.toString());

        print(newDateTimeObj1);
        var newDateTimeObj2 =
            new DateFormat("yyyy-MM-dd").parse(args.value.endDate.toString());

        print(newDateTimeObj2);

        _rangeDiff = newDateTimeObj2.difference(newDateTimeObj1).inDays + 1;

        print(_rangeDiff);
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
      }
    });
  }

  //******************************* */

  //******************************************** */
  @override
  Widget build(BuildContext context) {
    //************************************** */
    calculePrix() {
      //***adult */
      var prixA = double.parse(widget.prix_adulte);
      var nbad = double.parse(_selectedAdltTest);
      //***enf */
      var prixE = double.parse(widget.prixEnfant15);
      var nbE = double.parse(_selectedEnfTest);

      //***************************** */
      var totad = prixA * nbad;
      var totE = prixE * nbE;
      var tot = (totad + totE) * _rangeDiff;
      return tot.toString();
    }

    //******************* */
//********************************************************** */

    Future add_reservation() async {
      final uri = Uri.parse("https://etnafes.000webhostapp.com/ajouter_reservation.php");
      var request = http.MultipartRequest('POST', uri);

      request.fields['idheb'] = widget.idheb;
      request.fields['idclient'] = widget.idses;
      request.fields['nbadlt'] = _selectedAdltTest.toString();
      request.fields['nbenf'] = _selectedEnfTest.toString();
      request.fields['du'] = _range1;
      request.fields['au'] = _range2;
      request.fields['ptotal'] = pt;

      // request.fields['idclient'] = vala;
      var response = await request.send();

      response.stream.transform(utf8.decoder).listen((value) async {
        print(value);
        if (value == "true") {
          print('***************************************');
          print('Reservation ajouter ');
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ReservationsClien()));
        } else {
          print('***************************************');

          print('Reservation faild');
        }
      });
    }

//*************************************** */

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
          Container(
            height: 300,
            width: 360,
            child: Image.network(
              widget.img,
              // this image doesn't exist
              fit: BoxFit.fitWidth,
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
          ),
          Text(
            "Hébergement : " + widget.nomheberg,
            style: TextStyle(fontSize: 24, color: Colors.black),
          ),
          Container(
              child: Column(
            children: <Widget>[
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 15, left: 15),
                          child: DropdownBelow(
                            itemWidth: 150,
                            itemTextstyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                            boxTextstyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0XFFbbbbbb)),
                            boxPadding: EdgeInsets.fromLTRB(1, 1, 1, 1),
                            boxWidth: 150,
                            boxHeight: 45,
                            hint: Text('Nombre Enfant'),
                            value: _selectedEnfTest,
                            items: _dropdownEnfItems,
                            onChanged: onChangeDropdownTestsEnf,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15, left: 15),
                          child: DropdownBelow(
                            itemWidth: 150,
                            itemTextstyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                            boxTextstyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0XFFbbbbbb)),
                            boxPadding: EdgeInsets.fromLTRB(13, 12, 0, 12),
                            boxWidth: 150,
                            boxHeight: 45,
                            hint: Text('Nombre Adult'),
                            value: _selectedAdltTest,
                            items: _dropdownAdltItems,
                            onChanged: onChangeDropdownTestsAdlt,
                          ),
                        ),
                      ])
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(children: <Widget>[
                  SfDateRangePicker(
                    onSelectionChanged: _onSelectionChanged,
                    selectionMode: DateRangePickerSelectionMode.range,
                    initialSelectedRange: PickerDateRange(
                        DateTime.now().subtract(const Duration(days: 4)),
                        DateTime.now().add(const Duration(days: 3))),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Debut : ' + _range1 + ' Fin : ' + _range2),
                    ],
                  ),
                ]),
              ),
              RaisedButton(
                color: Colors.orange[400],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                padding: EdgeInsets.all(10.0),
                textColor: Colors.white,
                onPressed: () {
                  pt = calculePrix();
                  //********************* */
                  CoolAlert.show(
                    context: context,
                    type: CoolAlertType.success,
                    title: 'totale',
                    text: calculePrix() + ' DT',
                    confirmBtnText: 'Valider',
                    cancelBtnText: 'Annuler',
                    confirmBtnColor: Colors.green,
                    onConfirmBtnTap: add_reservation,
                  );
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
}
