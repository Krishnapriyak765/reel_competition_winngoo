import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reels_application/core/constants/app_colors.dart';
import 'package:reels_application/core/services/referral_api_service.dart';
import 'package:reels_application/data/models/referral_model.dart';
import 'package:share_plus/share_plus.dart';

class ReferralHistoryPage extends StatefulWidget {
  const ReferralHistoryPage({Key? key}) : super(key: key);

  @override
  State<ReferralHistoryPage> createState() => _ReferralHistoryPageState();
}

class _ReferralHistoryPageState extends State<ReferralHistoryPage> {
  Referral? referralData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadReferralData();
  }

  Future<void> _loadReferralData() async {
    final data = await ApiService.getReferralData();
    if (mounted) {
      setState(() {
        referralData = data;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Always show the full scrollable page
    return SafeArea(
      child: Scaffold(
        backgroundColor: Appcolors.white,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 8),
              Text(
                'Referral History',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),

              // Table container
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Table(
                  columnWidths: const {
                    0: FixedColumnWidth(40),
                    1: FlexColumnWidth(),
                    2: FlexColumnWidth(),
                    3: FixedColumnWidth(60),
                    4: FixedColumnWidth(80),
                  },
                  border: TableBorder.all(color: Colors.black),
                  children: [
                    // header row
                    _buildTableRow([
                      'S.NO',
                      'NAME',
                      'TYPE',
                      'POINTS',
                      'STATUS',
                    ], isHeader: true),

                    // content
                    if (isLoading)
                      // show spinner row
                      TableRow(
                        children: List.generate(
                          5,
                          (_) => Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Center(
                              child: SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    else if ((referralData?.data.referrals ?? []).isEmpty)
                      // empty message row
                      _buildTableRow(
                        ['', '', 'No referrals yet', '', ''],
                        // highlight third cell background a little
                        highlightColumn: 2,
                        highlightColor: Colors.grey[200],
                      )
                    else
                      // actual data rows
                      for (
                        var i = 0;
                        i < referralData!.data.referrals.length;
                        i++
                      )
                        _buildTableRow(
                          [
                            '${i + 1}',
                            referralData!.data.referrals[i].referred.firstName,
                            referralData!.data.referrals[i].referralType,
                            referralData!.data.referrals[i].rewardPoints
                                .toString(),
                            referralData!.data.referrals[i].referred.status,
                          ],
                          statusColor:
                              referralData!.data.referrals[i].referred.status
                                          .toLowerCase() ==
                                      'approved'
                                  ? Colors.green
                                  : Colors.red,
                        ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Referral Card (always visible)
              _buildReferralCard(),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  TableRow _buildTableRow(
    List<String> cells, {
    bool isHeader = false,
    int? highlightColumn,
    Color? highlightColor,
    Color? statusColor,
  }) {
    return TableRow(
      decoration:
          highlightColumn != null ? BoxDecoration(color: highlightColor) : null,
      children:
          cells.asMap().entries.map((entry) {
            final idx = entry.key;
            final txt = entry.value;
            final isStatus = idx == 4 && !isHeader;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              child: Text(
                txt,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: isHeader ? 13 : 12,
                  fontWeight: isHeader ? FontWeight.w600 : FontWeight.normal,
                  color: isStatus ? statusColor : Appcolors.black,
                ),
              ),
            );
          }).toList(),
    );
  }

  Widget _buildReferralCard() {
    final code = referralData?.data.referralCode;
    return Container(
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
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                // referral code or spinner
                code == null
                    ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                    : Text(
                      'Referral ID:\n$code',
                      style: GoogleFonts.inter(
                        color: Appcolors.white,
                        fontSize: 14,
                      ),
                    ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: () {
                    onPressed:
                    () {
                      _showShareBottomSheet(
                        context,
                        referralData?.data.referralCode ?? '',
                      );
                    };
                  },
                  icon: Icon(Icons.share, color: Appcolors.white),
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
          Image.asset(
            'assets/images/refferal.png',
            width: MediaQuery.of(context).size.width * 0.35,
            height: MediaQuery.of(context).size.height * 0.15,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }

  void _showShareBottomSheet(BuildContext context, String referralCode) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder:
          (_) => Container(
            padding: EdgeInsets.all(16),
            height: 220,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Share via",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildShareIcon(
                      AssetImage('assets/icons/whatsapp.png') as Image,
                      "Whatsapp",
                      "whatsapp",
                      referralCode,
                    ),
                    _buildShareIcon(
                      AssetImage('assets/icons/telegram.png') as Image,
                      "Telegram",
                      "telegram",
                      referralCode,
                    ),
                    _buildShareIcon(
                      AssetImage('assets/icons/email.png') as Image,
                      "Email",
                      "email",
                      referralCode,
                    ),
                  ],
                ),
                Divider(height: 32),
                InkWell(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: referralCode));
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Referral code copied")),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.copy, size: 20),
                      SizedBox(width: 8),
                      Text("Copy link"),
                    ],
                  ),
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildShareIcon(
    Image asset,
    String label,
    String platform,
    String referralCode,
  ) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            String message = '''
Hey! Join the Winngoo Reels Competition 🎬
Use my referral code: *$referralCode*
Get the app: https://winngooreels.app.link
''';
            Share.share(message);
          },
          child: CircleAvatar(child: asset),
        ),
        SizedBox(height: 4),
        Text(label),
      ],
    );
  }
}
