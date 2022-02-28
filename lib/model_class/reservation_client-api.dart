import 'package:flutter_app1/model_class/reservation_client.dart';

import 'package:http/http.dart' as http;

Future<List<ReservationClient>> fetchreservationClient(idses) async {
  String url = "https://etnafes.000webhostapp.com/reservation_client.php?idses=$idses";
  final response = await http.get(url);

  return reservationClientFromJson(response.body);
}
