import 'dart:convert';

class DonationList {
  final double totalAmount;
  final String donatedAt;
  DonationList({
    this.totalAmount,
    this.donatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'total_amount': totalAmount,
      'created_at': donatedAt,
    };
  }

  static DonationList fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return DonationList(
      totalAmount: map['total_amount'],
      donatedAt: map['created_at'],
    );
  }

  String toJson() => json.encode(toMap());

  static DonationList fromJson(String source) => fromMap(json.decode(source));
}
