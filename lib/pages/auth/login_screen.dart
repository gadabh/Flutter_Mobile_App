import 'dart:convert';
import 'package:flutter/services.dart';

import 'package:flutter_app1/pages/acceuil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'inscrit.dart';
import 'inscrit_prop.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

//********uploade image **************************************************** */

  Future connex() async {
    final uri = Uri.parse("https://etnafes.000webhostapp.com/connection.php");
    var request = http.MultipartRequest('POST', uri);
    request.fields['email'] = _emailController.text;

    request.fields['pass'] = _passwordController.text;
    var response = await request.send();

    response.stream.transform(utf8.decoder).listen((value) async {
      print(value);
      if (value != 'false') {
        print('connectee');
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('email', _emailController.text);
        var email = _emailController.text;
        print(email);
        //**********client ou prop************************************* */
        print(" client ou prop ? :");

        if (value.indexOf('*clien*') == 1) {
          print("client");
          preferences.setString('statu', "client");
        } else {
          print("prop");
          preferences.setString('statu', "prop");
        }
        //**********image************************************* */
        print(" image");
        var depimg = value.indexOf('image') + 8;
        var arrimg = value.indexOf('cin') - 3;
        print(value.substring(depimg, arrimg));
        var image = value.substring(depimg, arrimg);
        preferences.setString('imageses', image);
        //*********************************************** */
        //*********************************************** */
        //**********nom************************************* */
        print(" nom");
        var dep = value.indexOf('nom') + 6;
        var arr = value.indexOf('prenom') - 3;
        print(value.substring(dep, arr));
        var nom = value.substring(dep, arr);
        preferences.setString('nom', nom);
        //*********************************************** */
        //**********prenom************************************* */
        print(" prenom");
        var depPrenom = value.indexOf('prenom') + 9;
        var arrPrenom = value.indexOf('Telephone') - 3;
        print(value.substring(depPrenom, arrPrenom));
        var prenom = value.substring(depPrenom, arrPrenom);
        if (prenom == "ul") {
          prenom = "null";
        }
        preferences.setString('prenom', prenom);
        //*********************************************** */
        //**********Cin************************************* */
        print(" Cin");
        var depCin = value.indexOf('cin') + 5;
        var arrCin = value.indexOf('code_postale') - 2;
        print(value.substring(depCin, arrCin));
        var cin = value.substring(depCin, arrCin);
        preferences.setString('cin', cin);
        //*********************************************** */
        ////**********telephon************************************* */
        print(" telephon");
        var depTel = value.indexOf('Telephone') + 11;
        var arrTel = value.indexOf('email') - 2;
        print(value.substring(depTel, arrTel));
        var tel = value.substring(depTel, arrTel);
        preferences.setString('tel', tel);
        //*********************************************** */
        //////**********login************************************* */
        print(" login");
        var depLogin = value.indexOf('login') + 8;
        var arrLogin = value.indexOf('password') - 3;
        print(value.substring(depLogin, arrLogin));
        var login = value.substring(depLogin, arrLogin);
        if (login == "ul") {
          login = "null";
        }
        preferences.setString('login', login);
        //*********************************************** */
        ////////**********login************************************* */
        print(" idses");
        var depId = value.indexOf('id') + 4;
        var arrId = value.indexOf('nom') - 2;
        print(value.substring(depId, arrId));
        var id = value.substring(depId, arrId);
        preferences.setString('idses', id);
        //*********************************************** */

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Acceuil()));
      } else {
        Fluttertoast.showToast(
            msg: "Verifier Vos Infomations ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black87,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }

//************************************************************************** */

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: 1100,
            width: 600,
            child: Container(
                decoration:
                    BoxDecoration(color: Color.fromRGBO(236, 238, 238, 1)),
                child: SingleChildScrollView(
                    child: Column(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 50.0,
                    ),
                    child: Column(children: <Widget>[
                      Image(
                        image: AssetImage('assets/mountain.gif'),
                        height: 200,
                        fit: BoxFit.contain,
                      ),
                      Text(
                        "LOGIN",
                        style: TextStyle(
                            color: Colors.black87,
                            fontFamily: 'Roboto',
                            fontSize: 30),
                      ),
                      Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 50.0,
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 40.0, right: 40),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      labelStyle: TextStyle(
                                        color: Colors.black45,
                                      ),
                                      labelText: 'Email',
                                    ),
                                    controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: _validateEmail,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 40.0, right: 40),
                                  child: TextFormField(
                                    cursorColor: Colors.black26,
                                    decoration: InputDecoration(
                                      labelStyle: TextStyle(
                                        color: Colors.black45,
                                      ),
                                      labelText: 'Password',
                                    ),
                                    obscureText: true,
                                    controller: _passwordController,
                                    validator: (value) => value.isEmpty
                                        ? 'please valide your password'
                                        : null,
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                RaisedButton(
                                  color: Colors.blueGrey[900],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  padding: EdgeInsets.all(10.0),
                                  textColor: Colors.white,
                                  onPressed: () {
                                    //********************* */

                                    if (_formKey.currentState.validate()) {
                                      connex();
                                    }
                                  },
                                  child: Text(
                                    'Login',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                FlatButton(
                                  minWidth: double.infinity,
                                  onPressed: () {
                                    //********************* */
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              InscritScreen()),
                                    );
                                  },
                                  child: Text(
                                    'Créer compte',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontFamily: 'Roboto',
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                FlatButton(
                                  minWidth: double.infinity,
                                  onPressed: () {
                                    //********************* */
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              InscritPropScreen()),
                                    );
                                  },
                                  child: Text(
                                    'Devenir un Hote',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontFamily: 'Roboto',
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                      )
                    ]),
                  ),
                ])))));
  }

  //***** email validator ************************** */
  String _validateEmail(String value) {
    if (value == null || value == '') {
      return 'Email is required';
    }
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);

    if (!regex.hasMatch(value)) {
      return 'Enter valid email address';
    }
    return null;
  }
}
