// To parse this JSON data, do
//
//     final referral = referralFromJson(jsonString);

import 'dart:convert';

Referral referralFromJson(String str) => Referral.fromJson(json.decode(str));

String referralToJson(Referral data) => json.encode(data.toJson());

class Referral {
  bool success;
  String message;
  Data data;

  Referral({required this.success, required this.message, required this.data});

  factory Referral.fromJson(Map<String, dynamic> json) => Referral(
    success: json["success"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  List<ReferralElement> referrals;
  int total;
  String referralCode;

  Data({
    required this.referrals,
    required this.total,
    required this.referralCode,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    referrals: List<ReferralElement>.from(
      json["referrals"].map((x) => ReferralElement.fromJson(x)),
    ),
    total: json["total"],
    referralCode: json["referral_code"],
  );

  Map<String, dynamic> toJson() => {
    "referrals": List<dynamic>.from(referrals.map((x) => x.toJson())),
    "total": total,
    "referral_code": referralCode,
  };
}

class ReferralElement {
  int id;
  int memberId;
  int referredId;
  String referralType;
  int rewardPoints;
  DateTime createdAt;
  DateTime updatedAt;
  Referred referred;

  ReferralElement({
    required this.id,
    required this.memberId,
    required this.referredId,
    required this.referralType,
    required this.rewardPoints,
    required this.createdAt,
    required this.updatedAt,
    required this.referred,
  });

  factory ReferralElement.fromJson(Map<String, dynamic> json) =>
      ReferralElement(
        id: json["id"],
        memberId: json["member_id"],
        referredId: json["referred_id"],
        referralType: json["referral_type"],
        rewardPoints: json["reward_points"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        referred: Referred.fromJson(json["referred"]),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "member_id": memberId,
    "referred_id": referredId,
    "referral_type": referralType,
    "reward_points": rewardPoints,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "referred": referred.toJson(),
  };
}

class Referred {
  int id;
  String userId;
  String firstName;
  String lastName;
  String email;
  String referralCode;
  String referredBy;
  int rewardPoints;
  String emailVerificationCode;
  DateTime emailVerificationCodeGenDate;
  DateTime? emailVerifiedAt;
  int age;
  String profession;
  String residentialCity;
  String residentialCountry;
  String phoneNumber;
  String role;
  int isActive;
  DateTime createdAt;
  DateTime updatedAt;
  String status;

  Referred({
    required this.id,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.referralCode,
    required this.referredBy,
    required this.rewardPoints,
    required this.emailVerificationCode,
    required this.emailVerificationCodeGenDate,
    required this.emailVerifiedAt,
    required this.age,
    required this.profession,
    required this.residentialCity,
    required this.residentialCountry,
    required this.phoneNumber,
    required this.role,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
  });

  factory Referred.fromJson(Map<String, dynamic> json) => Referred(
    id: json["id"],
    userId: json["user_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    referralCode: json["referral_code"],
    referredBy: json["referred_by"],
    rewardPoints: json["reward_points"],
    emailVerificationCode: json["email_verification_code"],
    emailVerificationCodeGenDate: DateTime.parse(
      json["email_verification_code_gen_date"],
    ),
    emailVerifiedAt:
        json["email_verified_at"] == null
            ? null
            : DateTime.parse(json["email_verified_at"]),
    age: json["age"],
    profession: json["profession"],
    residentialCity: json["residential_city"],
    residentialCountry: json["residential_country"],
    phoneNumber: json["phone_number"],
    role: json["role"],
    isActive: json["is_active"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "referral_code": referralCode,
    "referred_by": referredBy,
    "reward_points": rewardPoints,
    "email_verification_code": emailVerificationCode,
    "email_verification_code_gen_date":
        emailVerificationCodeGenDate.toIso8601String(),
    "email_verified_at": emailVerifiedAt?.toIso8601String(),
    "age": age,
    "profession": profession,
    "residential_city": residentialCity,
    "residential_country": residentialCountry,
    "phone_number": phoneNumber,
    "role": role,
    "is_active": isActive,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "status": status,
  };
}

// models/referral_model.dart

// class ReferralItem {
//   final int id;
//   final String name;
//   final String type;
//   final String amount;
//   final String status;

//   ReferralItem({
//     required this.id,
//     required this.name,
//     required this.type,
//     required this.amount,
//     required this.status,
//   });

//   factory ReferralItem.fromJson(Map<String, dynamic> json) {
//     return ReferralItem(
//       id: json['id'],
//       name: json['name'],
//       type: json['type'],
//       amount: json['amount'],
//       status: json['status'],
//     );
//   }
// }

// class ReferralData {
//   final String referralCode;
//   final double amount;
//   final List<ReferralItem> referrals;

//   ReferralData({
//     required this.referralCode,
//     required this.amount,
//     required this.referrals,
//   });

//   factory ReferralData.fromJson(Map<String, dynamic> json) {
//     return ReferralData(
//       referralCode: json['referral_code'],
//       amount: (json['amount'] as num).toDouble(),
//       referrals:
//           (json['referrals'] as List)
//               .map((item) => ReferralItem.fromJson(item))
//               .toList(),
//     );
//   }
// }
