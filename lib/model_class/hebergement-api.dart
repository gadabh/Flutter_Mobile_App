import 'hebergement.dart';
import 'package:http/http.dart' as http;

Future<List<Hebergement>> fetchreHebergements() async {
  String url = "https://etnafes.000webhostapp.com/hebergement.php";
  final response = await http.get(url);

  return hebergementFromJson(response.body);
}
