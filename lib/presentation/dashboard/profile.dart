import 'package:flutter/material.dart';
import 'package:reels_application/core/constants/app_colors.dart';

class MembershipInfoPage extends StatefulWidget {
  @override
  State<MembershipInfoPage> createState() => _MembershipInfoPageState();
}

class _MembershipInfoPageState extends State<MembershipInfoPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppbarT(title: ' ', ontap: () {}),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Membership Information',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  "https://d2v5dzhdg4zhx3.cloudfront.net/web-assets/images/storypages/short/linkedin-profile-picture-maker/dummy_image/thumb/004.webp",
                ),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(radius: 8, backgroundColor: Colors.green),
                ),
              ),
              const SizedBox(height: 30),
              Table(
                columnWidths: const {
                  0: FixedColumnWidth(30), // Icon
                  1: FixedColumnWidth(120), // Label
                  2: FixedColumnWidth(10), // Colon
                  3: FlexColumnWidth(), // Value
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  buildTableRow(Icons.badge, 'Name', 'Girija'),
                  buildTableRow(
                    Icons.credit_card,
                    'Member ID',
                    'winngoo-439894',
                  ),
                  buildTableRow(Icons.email, 'Email ID', 'girija5@gmail.com'),
                  buildTableRow(Icons.phone, 'Phone Number', '9865321456'),
                  buildTableRow(Icons.calendar_today, 'Age', '18'),
                  buildTableRow(Icons.work_outline, 'Profession', 'Test'),
                  buildTableRow(Icons.location_city, 'City', 'Chennai'),
                  buildTableRow(Icons.public, 'Country', 'India'),
                  buildTableRow(Icons.date_range, 'Created at', '01.04.2025'),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red[600],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Text(
                      'Note :',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Membership details are fixed. For updates, email us at info@winngoofame.co.uk.',
                        style: TextStyle(fontSize: 17, color: Appcolors.white),
                      ),
                    ),
                  ],
                ),
              ),
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
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Text(
            label,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            ':',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(value, style: TextStyle(fontSize: 18)),
        ),
      ],
    );
  }
}
