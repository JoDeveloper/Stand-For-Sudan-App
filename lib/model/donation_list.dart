class DonationList {
  dynamic totalAmount;
  String donatedAt;
  DonationList({
    this.totalAmount,
    this.donatedAt,
  });

  DonationList.fromJson(Map<dynamic, dynamic> parsedJson)
      : totalAmount = parsedJson['total_amount'],
        donatedAt = parsedJson['created_at'];
}
