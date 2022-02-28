import 'dart:convert';
import 'dart:io';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';
import 'acceuil.dart';
import 'auth/login_screen.dart';
import 'config.dart';
import 'mes_hebergements.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Reclamation extends StatefulWidget {
  final idheb;
  final idses;
  final nom_hebergement;
  final nom_client;
  Reclamation({
    this.idheb,
    this.idses,
    this.nom_hebergement,
    this.nom_client,
  });
  @override
  _ReclamationState createState() => _ReclamationState();
}

class _ReclamationState extends State<Reclamation> {
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

  TextEditingController descriptionController = TextEditingController();

  Future reclamationHebergement() async {
    final uri = Uri.parse("https://etnafes.000webhostapp.com/reclamation.php");
    var request = http.MultipartRequest('POST', uri);
    request.fields['problem'] = descriptionController.text;
    request.fields['idses'] = widget.idses;
    request.fields['idheb'] = widget.idheb;
    request.fields['nom_hebergement'] = widget.nom_hebergement;
    request.fields['nom_client'] = widget.nom_client;
    var response = await request.send();

    response.stream.transform(utf8.decoder).listen((value) async {
      print(value);
      if (value == "true") {
        print('reclamation envoyer sescecful');
        Fluttertoast.showToast(
            msg: "Réclamation envoyer...",
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
      body: Column(children: <Widget>[
        Container(
          alignment: Alignment.topLeft,
          child: Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 10.0),
              child: Text(
                ' Réclamation de ' +
                    widget.nom_hebergement.toString().toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              )),
        ),
        Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextField(
              minLines:
                  6, // any number you need (It works as the rows for the textarea)
              keyboardType: TextInputType.multiline,
              maxLines: null,
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'description'),
            )),
        TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              overlayColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.hovered))
                    return Colors.blue.withOpacity(0.04);
                  if (states.contains(MaterialState.focused) ||
                      states.contains(MaterialState.pressed))
                    return Colors.blue.withOpacity(0.12);
                  return null; // Defer to the widget's default.
                },
              ),
            ),
            onPressed: () {
              reclamationHebergement();
            },
            child: Text('reclamer un probleme'))
      ]),
    );
  }
}
