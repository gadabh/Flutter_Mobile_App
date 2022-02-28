import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/login_screen.dart';
import 'mes_hebergements.dart';

class AddHebergement extends StatefulWidget {
  @override
  _AddHebergementState createState() => _AddHebergementState();
}

class _AddHebergementState extends State<AddHebergement> {
//***session get email************ */
  String emailses = "";
  Future getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      emailses = preferences.getString('email');
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

  File _image;
  final picker = ImagePicker();
  TextEditingController nameController = TextEditingController();

  TextEditingController nbrvoyageursController = TextEditingController();
  TextEditingController nbrchambredispoController = TextEditingController();
  TextEditingController nbrplacedispoController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController adresseController = TextEditingController();

//********uploade image **************************************************** */
  Future choiceImage() async {
    var pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage.path);
    });
  }

  Future uploadImage() async {
    final uri = Uri.parse("https://etnafes.000webhostapp.com/add_image_hebergement.php");
    var request = http.MultipartRequest('POST', uri);
    request.fields['name'] = nameController.text;
    request.fields['nbrvoyageurs'] = nbrvoyageursController.text;
    request.fields['nbrplacedispo'] = nbrplacedispoController.text;
    request.fields['description'] = descriptionController.text;
    request.fields['adresse'] = adresseController.text;
    request.fields['emailses'] = emailses;
    var pic = await http.MultipartFile.fromPath("image", _image.path);
    request.files.add(pic);
    var response = await request.send();

    if (response.statusCode == 200) {
      print('Image uploaded');
    } else {
      print('Image not uploaded');
    }
  }
//************************************************************************** */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.orange),
          backgroundColor: Colors.white,
          toolbarHeight: 65,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 0, right: 50),
                child: Image.asset('assets/logoo.png',
                    alignment: Alignment.center,
                    height: 50,
                    width: 140,
                    fit: BoxFit.cover),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              child: Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 10.0),
                  child: Text(
                    " Ajouter hebergement  :  ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  )),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'name'),
                )),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: nbrvoyageursController,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'nbr_voyageurs'),
                )),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  controller: nbrchambredispoController,
                  decoration: InputDecoration(labelText: 'nbr_chambre_dispo'),
                )),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  controller: nbrplacedispoController,
                  decoration: InputDecoration(labelText: 'nbr_place_dispo'),
                )),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: 'description'),
                )),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: adresseController,
                  decoration: InputDecoration(labelText: 'adresse'),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 20),
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
            Container(
              child: _image == null
                  ? Text('pas d image selectionne')
                  : Image.file(
                      _image,
                      height: 200,
                      width: 200,
                    ),
            ),
            RaisedButton(
                child: Text('Ajouter l image'),
                onPressed: () {
                  uploadImage();
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Hebergements()));
                }),
          ]),
        ));
  }
}
