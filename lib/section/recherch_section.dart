import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class Recherchesection extends StatefulWidget {
  @override
  _RecherchesectionState createState() => _RecherchesectionState();
}

class _RecherchesectionState extends State<Recherchesection> {
  String nbhebergement;

  List<String> hebergement = [
    "1",
    "2",
    "3",
    "4",
  ];

  String countryid;

  List<String> country = [
    "Tunis",
    "Carthage",
    "Tozeur",
    "Kébili",
    "Douz ",
    "Dougga ",
    "El Jem",
    "Tataouine",
    "Sidi Bou Saïd",
    "Oudna ",
    "Jendouba",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(10.0),
                topRight: const Radius.circular(10.0),
              )),
          child: Text(
            'Recheche ',
            style: TextStyle(height: 2, fontSize: 20),
          ),
        ),
        Container(
            decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                  bottomLeft: const Radius.circular(10.0),
                  bottomRight: const Radius.circular(10.0),
                )),
            padding: EdgeInsets.all(10.0),
            height: 350.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                DropdownButton<String>(
                  underline: Container(
                    height: 0,
                  ),
                  hint: Text("où allez-vous "),
                  items: country.map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                  onChanged: (_) {},
                ),
                Padding(
                  padding: EdgeInsets.only(top: 3),
                ),
                Row(children: [
                  Icon(
                    Icons.date_range,
                    color: Colors.orange,
                    size: 24.0,
                    semanticLabel: 'Text to announce in accessibility modes',
                  ),
                  FlatButton(
                      onPressed: () {
                        DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateTime.now(),
                            maxTime: DateTime(2021, 12, 31), onChanged: (date) {
                          print('change $date');
                        }, onConfirm: (date) {
                          print('confirm $date');
                        }, currentTime: DateTime.now(), locale: LocaleType.fr);
                      },
                      child: Text(
                        'Date d arrivée ',
                        style: TextStyle(color: Colors.black),
                      )),
                  Icon(
                    Icons.date_range,
                    color: Colors.orange,
                    size: 24.0,
                    semanticLabel: 'Text to announce in accessibility modes',
                  ),
                  FlatButton(
                      onPressed: () {
                        DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateTime.now(),
                            maxTime: DateTime(2021, 12, 31), onChanged: (date) {
                          print('change $date');
                        }, onConfirm: (date) {
                          print('confirm $date');
                        }, currentTime: DateTime.now(), locale: LocaleType.fr);
                      },
                      child: Text(
                        'Date de départ ',
                        style: TextStyle(color: Colors.black),
                      )),
                ]),
                DropdownButton<String>(
                  underline: Container(
                    height: 0,
                  ),
                  hint: Text("Nombre de chambre "),
                  items: <String>['1', '2', '3', '4'].map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                  onChanged: (_) {},
                ),
                Padding(
                  padding: EdgeInsets.only(top: 3),
                ),
                DropdownButton<String>(
                  underline: Container(
                    height: 0,
                  ),
                  hint: Text("Nombre d'adults"),
                  items: <String>['1', '2', '3', '4'].map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                  onChanged: (_) {},
                ),
                Padding(
                  padding: EdgeInsets.only(top: 3),
                ),
                DropdownButton<String>(
                  underline: Container(
                    height: 0,
                  ),
                  hint: Text("Nombre d'enfants"),
                  items: <String>['1', '2', '3', '4'].map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                  onChanged: (_) {},
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8),
                ),
                SizedBox(
                  width: 50,
                  height: 50,
                  child: RaisedButton(
                    color: Colors.orange,
                    child: Text('Rechercher',
                        style: TextStyle(color: Colors.white)),
                    onPressed: () {},
                  ),
                ),
              ],
            )),
      ],
    );
  }
}
