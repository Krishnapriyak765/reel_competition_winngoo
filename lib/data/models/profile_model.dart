import 'package:intl/intl.dart';

import 'package:intl/intl.dart';

class User {
  final int id;
  final String userId;
  final String firstName;
  final String lastName;
  final String email;
  final String profession;
  final String residentialCity;
  final String residentialCountry;
  final String phoneNumber;
  final int age;
  // final int rewardPoints;
  final DateTime createdAt; // New field

  User({
    required this.id,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profession,
    required this.residentialCity,
    required this.residentialCountry,
    required this.phoneNumber,
    required this.age,
    // required this.rewardPoints,
    required this.createdAt,
  });

  // Getter to return only the time from createdAt
  String get createdTimeOnly {
    return DateFormat('hh:mm a').format(createdAt);
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      userId: json['user_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      profession: json['profession'],
      residentialCity: json['residential_city'],
      residentialCountry: json['residential_country'],
      phoneNumber: json['phone_number'],
      age: json['age'],
      // rewardPoints: json['reward_points'],
      createdAt: DateTime.parse(json['created_at']), // Parse from JSON
    );
  }
}
