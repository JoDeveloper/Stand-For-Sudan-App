import 'dart:convert';

import 'package:http/http.dart' as http;

import '../donations/donation_list.dart';
import '../donations/donations.dart';

class DonationsService {
  Future<Donations> getDonations() async {
    //Send Get Request
    var response = await http.get('https://sfs-api.obay-dev.com/api/donations');
    print("getDonations\n");
    print(jsonDecode(response.body)['donations_total']);
    return Donations.fromJson(jsonDecode(response.body));
  }

  Future<List<DonationList>> getDonationsList() async {
    //Send Get Request
    var response = await http.get('https://sfs-api.obay-dev.com/api/donations');
    var json = jsonDecode(response.body);
    var jsonResults = json['results'] as List;
    return jsonResults.map((place) => DonationList.fromJson(place)).toList();
  }
}
