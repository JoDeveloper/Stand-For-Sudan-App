class DonationList {
  dynamic totalAmount;
  dynamic donation;
  String donatedAt;

  DonationList({this.totalAmount, this.donatedAt, this.donation});

  DonationList.fromJson(Map<dynamic, dynamic> parsedJson)
      : totalAmount = parsedJson['total_amount'],
        donation = parsedJson['donation'],
        donatedAt = parsedJson['created_at'];
}
