import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'acceuil.dart';
import 'auth/login_screen.dart';
//import 'package:flutter_onboarding_ui/utilities/styles.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
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

  //***************** */
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 35.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.blueGrey[100] : Colors.blueGrey[300],
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.4, 0.7, 0.9],
              colors: [
                Colors.blueGrey[100],
                Colors.blueGrey[400],
                Colors.blueGrey[700],
                Colors.blueGrey[900],
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () {
                      if (emailses == null) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      } else {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Acceuil()));
                      }
                    },
                    child: Text(
                      'passer',
                      style: TextStyle(
                        color: Colors.blueGrey[700],
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 600.0,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/TPEcloud_facture_rapide_.png',
                                ),
                                height: 300.0,
                                width: 300.0,
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Text(
                              'Découvrez',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'CM Sans Serif',
                                fontSize: 26.0,
                                height: 1.5,
                              ),
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              'Commencez par découvrir des séjours ou des expériences. Vous pouvez aussi enregistrer vos logements préférés dans vos favoris.',
                              style: TextStyle(
                                fontFamily: 'CM Sans Serif',
                                color: Colors.white,
                                fontSize: 16.0,
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/TPEcloud_sauvegarde_backup_cloud.png',
                                ),
                                height: 300.0,
                                width: 300.0,
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Text(
                              'Réservez',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'CM Sans Serif',
                                fontSize: 26.0,
                                height: 1.5,
                              ),
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              'Dès que vous trouvez le logement qui vous convient, apprenez-en davantage sur votre hôte et vérifiez les options d annulation applicables, puis réservez en quelques clics.',
                              style: TextStyle(
                                fontFamily: 'CM Sans Serif',
                                color: Colors.white,
                                fontSize: 16.0,
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/TPEcloud_sms.png',
                                ),
                                height: 300.0,
                                width: 300.0,
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Text(
                              'Devenez hôte',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'CM Sans Serif',
                                fontSize: 26.0,
                                height: 1.5,
                              ),
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              'Gagnez un revenu complémentaire et saisissez de nouvelles opportunités en louant votre logement.',
                              style: TextStyle(
                                fontFamily: 'CM Sans Serif',
                                color: Colors.white,
                                fontSize: 16.0,
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                _currentPage != _numPages - 1
                    ? Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomRight,
                          child: FlatButton(
                            onPressed: () {
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Suivant',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22.0,
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Text(''),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? Container(
              height: 100.0,
              width: double.infinity,
              color: Colors.white,
              child: GestureDetector(
                onTap: () {
                  if (emailses == null) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  } else {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Acceuil()));
                  }
                },
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 30.0),
                    child: Text(
                      'Commencer',
                      style: TextStyle(
                        color: Colors.blueGrey[700],
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : Text(''),
    );
  }
}
