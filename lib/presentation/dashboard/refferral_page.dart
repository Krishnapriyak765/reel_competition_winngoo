import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reels_application/core/constants/app_colors.dart';
import 'package:reels_application/core/services/referral_api_service.dart';
import 'package:reels_application/data/models/referral_model.dart';

class ReferralHistoryPage extends StatefulWidget {
  const ReferralHistoryPage({super.key});

  @override
  State<ReferralHistoryPage> createState() => _ReferralHistoryPageState();
}

class _ReferralHistoryPageState extends State<ReferralHistoryPage> {
  ReferralData? referralData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchReferralInfo();
  }

  Future<void> fetchReferralInfo() async {
    final data = await ApiService.getReferralData();
    setState(() {
      referralData = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Appcolors.white,
        body:
            isLoading
                ? const Center(child: Text('NO Referral Found!'))
                : Column(
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      'Referral History',
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildTable(referralData!.referrals),
                    const SizedBox(height: 20),
                    _buildReferralCard(referralData!.referralCode),
                  ],
                ),
      ),
    );
  }

  Widget _buildTable(List<ReferralItem> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Table(
        border: TableBorder.all(color: Colors.black),
        columnWidths: const {
          0: FixedColumnWidth(40),
          1: FlexColumnWidth(),
          2: FlexColumnWidth(),
          3: FixedColumnWidth(60),
          4: FixedColumnWidth(80),
        },
        children: [
          _buildTableRow([
            'S.NO',
            'NAME',
            'TYPE',
            'AMOUNT',
            'STATUS',
          ], isHeader: true),
          ...items.asMap().entries.map((entry) {
            final i = entry.key;
            final item = entry.value;
            final color =
                item.status.toLowerCase() == 'approved'
                    ? Colors.green
                    : Colors.red;
            return _buildTableRow([
              (i + 1).toString(),
              item.name,
              item.type,
              item.amount,
              item.status,
            ], statusColor: color);
          }),
        ],
      ),
    );
  }

  TableRow _buildTableRow(
    List<String> cells, {
    bool isHeader = false,
    Color? statusColor,
  }) {
    return TableRow(
      children:
          cells.asMap().entries.map((entry) {
            final index = entry.key;
            final text = entry.value;
            final isStatusCell = index == 4;
            return Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                text,
                style: GoogleFonts.inter(
                  fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                  fontSize: 12,
                  color:
                      isStatusCell && !isHeader ? statusColor : Appcolors.black,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }).toList(),
    );
  }

  Widget _buildReferralCard(String referralCode) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Appcolors.primaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Refer a friend and earn £2.00',
                    style: GoogleFonts.inter(
                      color: Appcolors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Referral ID:\n$referralCode',
                    style: GoogleFonts.inter(color: Appcolors.white),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Share code
                    },
                    icon: Icon(Icons.share, color: Appcolors.white, size: 18),
                    label: Text(
                      'Invite',
                      style: GoogleFonts.inter(
                        color: Appcolors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Appcolors.secondaryYellow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: screenWidth * 0.3,
              height: screenHeight * 0.1,
              child: Image.asset('assets/images/refferal.png'),
            ),
          ],
        ),
      ),
    );
  }
}
