import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app1/model_class/hebergement.dart';
import 'package:http/http.dart' as http;
import 'package:search_page/search_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'hebergement_details.dart';

class CarouselHebergement extends StatefulWidget {
  @override
  _CarouselHebergementState createState() => _CarouselHebergementState();
}

class _CarouselHebergementState extends State<CarouselHebergement> {
  //***session get email************ */
  String emailses = "";
  String statuses = "";

  Future getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      emailses = preferences.getString('email');
      statuses = preferences.getString('statu');
    });
  }

  @override
  void initState() {
    super.initState();
    getEmail();
  }

  Future allhebergement() async {
    var url = "https://etnafes.000webhostapp.com/affiche_image_hebergement.php";
    var response = await http.get(url);

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: FutureBuilder(
          future: allhebergement(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, index) {
                      List list = snapshot.data;

                      return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 700),
                          child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: ScaleAnimation(
                                  child: Card(
                                      child: new InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              HebergementsDetailes(
                                                id: list[index]['id'],
                                                prix_adulte: list[index]
                                                    ['prix_adulte'],
                                                prix_enfant15: list[index]
                                                    ['prix_enfant15'],
                                                emailses: emailses,
                                                nom: list[index]['nom'],
                                                description: list[index]
                                                    ['description'],
                                                wifi: list[index]['wifi'],
                                                chauffage: list[index]
                                                    ['chauffage'],
                                                television: list[index]
                                                    ['television'],
                                                climatisation: list[index]
                                                    ['climatisation'],
                                                eau_chaude: list[index]
                                                    ['eau_chaude'],
                                                espace_travail_ordinateur: list[
                                                        index][
                                                    'espace_travail_ordinateur'],
                                                espace_enfant: list[index]
                                                    ['espace_enfant'],
                                                nb_images: list[index]
                                                    ['nb_images'],
                                                salle_de_bain: list[index]
                                                    ['salle_de_bain'],
                                                cuisine: list[index]['cuisine'],
                                                nB_jaime: list[index]
                                                    ['nB_jaime'],
                                                nB_jaime_pas: list[index]
                                                    ['nB_jaime_pas'],
                                                adresse: list[index]['adresse'],
                                                disponibilite: list[index]
                                                    ['disponibilite'],
                                                imagelink:
                                                    "https://etnafes.000webhostapp.com/uploads/${list[index]['url_image']}",
                                              )));
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    //***** */

                                    //******* */
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: SizedBox(
                                        height: 220,
                                        width: 390,
                                        child: Card(
                                          child: Image.network(
                                            "https://etnafes.000webhostapp.com/uploads/${list[index]['url_image']}", // this image doesn't exist
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Container(
                                                color: Colors.amber,
                                                alignment: Alignment.center,
                                                child: Text(
                                                  'Whoops!',
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
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
                                            Container(
                                              child: Icon(Icons.home_outlined,
                                                  color: Colors.pink),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    left: 8, right: 3, top: 8),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      ' ${list[index]['nom']}',
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    Text(
                                                      '${list[index]['adresse']}',
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 10),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Icon(Icons.thumb_up_sharp,
                                                color: Colors.pinkAccent),
                                            Text(
                                              ' ${list[index]['nB_jaime']} ',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Icon(Icons.thumb_down_sharp,
                                                color: Colors.pinkAccent),
                                            Text(
                                              ' ${list[index]['nB_jaime_pas']} ',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )))));
                    },
                    itemCount: snapshot.data.length,
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }

  //***************************************bare de recherche ************************* */
  _searchBar(list) {
    return FloatingActionButton(
      child: Icon(Icons.search),
      tooltip: 'Search people',
      onPressed: () => showSearch(
        context: context,
        delegate: SearchPage<Hebergement>(
          items: list,
          searchLabel: 'Search people',
          suggestion: Center(
            child: Text('Filter people by name, surname or age'),
          ),
          failure: Center(
            child: Text('No person found :('),
          ),
          filter: (list) => [list.nom, list.description],
          builder: (list) => ListTile(
            title: Text('nom ' + list.nom),
            subtitle: Text('nom ' + list.nom),
            trailing: Text('nom ' + list.nom),
          ),
        ),
      ),
    );
  }
}
