import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;

class InscritScreen extends StatefulWidget {
  @override
  _InscritScreenState createState() => _InscritScreenState();
}

class _InscritScreenState extends State<InscritScreen> {
  TextEditingController _nomController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _password2Controller = TextEditingController();
//********uploade image **************************************************** */

  Future inscritprop() async {
    if (_password2Controller.text == _passwordController.text) {
      final uri = Uri.parse("https://etnafes.000webhostapp.com/inscrit_prop.php");
      var request = http.MultipartRequest('POST', uri);
      request.fields['email'] = _emailController.text;
      request.fields['nom'] = _nomController.text;

      request.fields['pass'] = _passwordController.text;

      var response = await request.send();

      if (response.statusCode == 200) {
        print('compte prop cree');
        Navigator.pop(context);
      } else {
        print('faild');
      }
    } else {
      Fluttertoast.showToast(
          msg: "verifier votre password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white24,
          textColor: Colors.black,
          fontSize: 16.0);
    }
  }
//************************************************************************** */

  Future inscrit() async {
    if (_password2Controller.text == _passwordController.text) {
      final uri = Uri.parse("https://etnafes.000webhostapp.com/inscrit.php");
      var request = http.MultipartRequest('POST', uri);
      request.fields['email'] = _emailController.text;
      request.fields['nom'] = _nomController.text;

      request.fields['pass'] = _passwordController.text;

      var response = await request.send();

      if (response.statusCode == 200) {
        print('compte cree');
        Navigator.pop(context);
      } else {
        print('faild');
      }
    } else {
      Fluttertoast.showToast(
          msg: "verifier votre password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white24,
          textColor: Colors.black,
          fontSize: 16.0);
    }
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
            decoration: BoxDecoration(color: Color.fromRGBO(236, 238, 238, 1)),
            child: SingleChildScrollView(
                child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    top: 50.0,
                  ),
                  child: Image(
                    image: AssetImage('assets/mountain.gif'),
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 0.0,
                  ),
                  child: Text(
                    "SIGN UP",
                    style: TextStyle(
                        color: Colors.black87,
                        fontFamily: 'Roboto',
                        fontSize: 30),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: SizedBox(
                    child: Column(children: <Widget>[
                      Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 10.0,
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 40, right: 40),
                                    child: TextFormField(
                                      style: TextStyle(color: Colors.black45),
                                      decoration: InputDecoration(
                                        fillColor: Colors.black45,
                                        labelStyle: TextStyle(
                                          color: Colors.black45,
                                        ),
                                        labelText: 'nom',
                                      ),
                                      controller: _nomController,
                                      validator: (value) => value.isEmpty
                                          ? 'please valide your name'
                                          : null,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 40, right: 40),
                                    child: TextFormField(
                                      style: TextStyle(color: Colors.black45),
                                      decoration: InputDecoration(
                                        fillColor: Colors.black45,
                                        labelStyle: TextStyle(
                                          color: Colors.black45,
                                        ),
                                        labelText: 'Email',
                                      ),
                                      controller: _emailController,
                                      validator: _validateEmail,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 40, right: 40),
                                    child: TextFormField(
                                      style: TextStyle(color: Colors.black45),
                                      decoration: InputDecoration(
                                        fillColor: Colors.black45,
                                        labelStyle: TextStyle(
                                          color: Colors.black45,
                                        ),
                                        labelText: 'Password',
                                      ),
                                      controller: _passwordController,
                                      validator: (value) => value.isEmpty
                                          ? 'please valide your password'
                                          : null,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 40, right: 40),
                                    child: TextFormField(
                                      style: TextStyle(
                                        color: Colors.black45,
                                      ),
                                      decoration: InputDecoration(
                                        fillColor: Colors.black45,
                                        labelStyle:
                                            TextStyle(color: Colors.black45),
                                        labelText: 'Confirme password',
                                      ),
                                      controller: _password2Controller,
                                      validator: (value) => value.isEmpty
                                          ? 'please valide your email'
                                          : null,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white24,
                                      borderRadius:
                                          new BorderRadius.circular(30.0),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  RaisedButton(
                                    color: Colors.blueGrey[900],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    padding: EdgeInsets.all(10.0),
                                    textColor: Colors.white,
                                    child: Text("Créer un compte",
                                        style: TextStyle(fontSize: 12)),
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        inscrit();
                                      }
                                    },
                                  ),
                                ]),
                          )),
                    ]),
                  ),
                ),
              ],
            ))));
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
