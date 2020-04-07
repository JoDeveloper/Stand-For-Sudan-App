import 'dart:convert';

import '../donations/donations.dart';
import 'package:http/http.dart' as http;

class DonationsService {
  Future<Donations> getDonations() async {
    //Send Get Request
    var response = await http.get('https://sfs-api.obay-dev.com/api/donations');
    var json = jsonDecode(response.body);

    // print(json['donations']);
    return Donations.fromJson(json);
  }
}
