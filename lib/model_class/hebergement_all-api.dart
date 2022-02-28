import 'hebergement.dart';
import 'package:http/http.dart' as http;

Future<List<Hebergement>> fetchreAllHebergements() async {
  String url = "https://etnafes.000webhostapp.com/hebergement_all.php";
  final response = await http.get(url);

  return hebergementFromJson(response.body);
}
