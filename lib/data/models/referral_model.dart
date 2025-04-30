// models/referral_model.dart

class ReferralItem {
  final int id;
  final String name;
  final String type;
  final String amount;
  final String status;

  ReferralItem({
    required this.id,
    required this.name,
    required this.type,
    required this.amount,
    required this.status,
  });

  factory ReferralItem.fromJson(Map<String, dynamic> json) {
    return ReferralItem(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      amount: json['amount'],
      status: json['status'],
    );
  }
}

class ReferralData {
  final String referralCode;
  final double amount;
  final List<ReferralItem> referrals;

  ReferralData({
    required this.referralCode,
    required this.amount,
    required this.referrals,
  });

  factory ReferralData.fromJson(Map<String, dynamic> json) {
    return ReferralData(
      referralCode: json['referral_code'],
      amount: (json['amount'] as num).toDouble(),
      referrals:
          (json['referrals'] as List)
              .map((item) => ReferralItem.fromJson(item))
              .toList(),
    );
  }
}
