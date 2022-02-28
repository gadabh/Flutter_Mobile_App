import 'profil.dart';
import 'package:http/http.dart' as http;

Future<List<Profil>> fetchreProfil() async {
  String url = "https://etnafes.000webhostapp.com/profil.php";
  final response = await http.get(url);

  return profilFromJson(response.body);
}
