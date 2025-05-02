import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

void _showShareBottomSheet(BuildContext context, String referralCode) {
  final shareMessage = 'Join the app using my referral code: $referralCode';

  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildShareItem(
                  icon: 'assets/icons/whatsapp.png',
                  label: 'Whatsapp',
                  onTap: () async {
                    final url = Uri.parse('https://wa.me/?text=$shareMessage');
                    if (await canLaunchUrl(url)) launchUrl(url);
                    Navigator.pop(context);
                  },
                ),
                _buildShareItem(
                  icon: 'assets/icons/telegram.png',
                  label: 'Telegram',
                  onTap: () async {
                    final url = Uri.parse('tg://msg?text=$shareMessage');
                    if (await canLaunchUrl(url)) launchUrl(url);
                    Navigator.pop(context);
                  },
                ),
                _buildShareItem(
                  icon: 'assets/icons/email.png',
                  label: 'Email',
                  onTap: () async {
                    final email = Uri(
                      scheme: 'mailto',
                      queryParameters: {
                        'subject': 'Join with my referral code!',
                        'body': shareMessage,
                      },
                    );
                    if (await canLaunchUrl(email)) launchUrl(email);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            const Divider(height: 32),
            _buildShareItem(
              icon: 'assets/icons/copy.png',
              label: 'Copy link',
              onTap: () async {
                await Clipboard.setData(ClipboardData(text: shareMessage));
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Referral code copied!')),
                );
              },
            ),
          ],
        ),
      );
    },
  );
}

Widget _buildShareItem({
  required String icon,
  required String label,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        Image.asset(icon, width: 36, height: 36),
        const SizedBox(height: 6),
        Text(
          label,
          style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
}
