import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:reels_application/core/constants/app_colors.dart';
import 'package:reels_application/data/models/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MembershipInfoPage extends StatefulWidget {
  @override
  State<MembershipInfoPage> createState() => _MembershipInfoPageState();
}

class _MembershipInfoPageState extends State<MembershipInfoPage> {
  final GetStorage storage = GetStorage();

  User? user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    // final token = storage.read('token');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final url = Uri.parse("https://winngooreels.wimbgo.com/api/user/dashboard");

    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        String formatCreatedTime(String createdAt) {
          DateTime dateTime = DateTime.parse(createdAt);
          String formattedTime = DateFormat(
            'hh:mm a',
          ).format(dateTime); // e.g., 11:14 AM
          return formattedTime;
        }

        setState(() {
          user = User.fromJson(data['user']);

          isLoading = false;
        });
      } else {
        print("Error: ${response.body}");
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("Exception: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body:
            isLoading
                ? Center(child: CircularProgressIndicator())
                : user == null
                ? Center(child: Text("Failed to load profile."))
                : SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 40,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Membership Information',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          "https://d2v5dzhdg4zhx3.cloudfront.net/web-assets/images/storypages/short/linkedin-profile-picture-maker/dummy_image/thumb/004.webp",
                        ),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: CircleAvatar(
                            radius: 8,
                            backgroundColor: Colors.green,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Table(
                        columnWidths: const {
                          0: FixedColumnWidth(30),
                          1: FixedColumnWidth(120),
                          2: FixedColumnWidth(10),
                          3: FlexColumnWidth(),
                        },
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: [
                          buildTableRow(
                            Icons.badge,
                            'Name',
                            '${user!.firstName} ${user!.lastName}',
                          ),
                          buildTableRow(
                            Icons.credit_card,
                            'Member ID',
                            '${user!.userId}',
                          ),
                          buildTableRow(
                            Icons.email,
                            'Email ID',
                            '${user!.email}',
                          ),
                          buildTableRow(
                            Icons.phone,
                            'Phone Number',
                            '${user!.phoneNumber}',
                          ),
                          buildTableRow(
                            Icons.calendar_today,
                            'Age',
                            '${user!.age}',
                          ),
                          buildTableRow(
                            Icons.work_outline,
                            'Profession',
                            '${user!.profession}',
                          ),
                          buildTableRow(
                            Icons.location_city,
                            'City',
                            '${user!.residentialCity}',
                          ),
                          buildTableRow(
                            Icons.public,
                            'Country',
                            '${user!.residentialCountry}',
                          ),
                          buildTableRow(
                            Icons.create_new_folder,
                            'Created at',
                            '${user!.createdTimeOnly}',
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.only(
                          left: 7,
                          top: 10,
                          right: 8,
                          bottom: 19,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red[600],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            const Text(
                              'Note :',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Membership details are fixed. For updates, email us at info@winngoofame.co.uk.',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Appcolors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
      ),
    );
  }

  TableRow buildTableRow(IconData icon, String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Icon(icon, size: 21),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
          child: Text(
            label,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: BorderSide.strokeAlignCenter,
          ),
          child: Text(
            ':',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(value, style: TextStyle(fontSize: 18)),
        ),
      ],
    );
  }
}
