import 'reservation.dart';
import 'package:http/http.dart' as http;

Future<List<Reservation>> fetchreservation(idses) async {
  String url = "https://etnafes.000webhostapp.com/reservation.php?idses=$idses";
  final response = await http.get(url);

  return reservationFromJson(response.body);
}
