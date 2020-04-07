class Donations {
  final int total;
  final int lastDonation;
  final int todayTotalDonators;

  Donations({this.total, this.lastDonation, this.todayTotalDonators});
  Donations.fromJson(Map<dynamic, dynamic> parsedJson)
      : total = parsedJson['donations_total'] ?? 0.0,
        lastDonation = parsedJson['last_donation'] ?? 0.0,
        todayTotalDonators = parsedJson['today_total_donators'] ?? 0.0;
}
