class DonationList {
  double totalAmount;
  String donatedAt;
  DonationList({
    this.totalAmount,
    this.donatedAt,
  });

  DonationList.fromJson(Map<dynamic, dynamic> parsedJson)
      : totalAmount = double.parse(parsedJson['total_amount']),
        donatedAt = parsedJson['created_at'];
}
