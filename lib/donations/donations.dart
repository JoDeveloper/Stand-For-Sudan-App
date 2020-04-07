import 'dart:convert';

import 'donation_list.dart';

class Donations {
  final double total;
  final double lastDonation;
  final double todayTotalDonators;
  final DonationList donations;

  Donations(
    this.total,
    this.lastDonation,
    this.todayTotalDonators,
    this.donations,
  );

  Map<String, dynamic> toMap() {
    return {
      'total': total,
      'lastDonation': lastDonation,
      'todayTotalDonators': todayTotalDonators,
    };
  }

  static Donations fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Donations(map['donations_total'], map['last_donation'],
        map['today_total_donators'], DonationList.fromJson(map['donations']));
  }

  String toJson() => json.encode(toMap());

  static Donations fromJson(String source) => fromMap(json.decode(source));
}
