import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:reels_application/auth/login/login_page.dart';

class PaymentDetailsPage extends StatefulWidget {
  final Map<String, dynamic> newsignupData;

  const PaymentDetailsPage({super.key, required this.newsignupData});

  @override
  State<PaymentDetailsPage> createState() => _PaymentDetailsPageState();
}

class _PaymentDetailsPageState extends State<PaymentDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  final _cardHolderController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvcController = TextEditingController();

  final _cardNumberFormatter = MaskTextInputFormatter(
    mask: '#### #### #### ####',
  );
  final _expiryFormatter = MaskTextInputFormatter(mask: '##/##');

  bool isLoading = false;

  @override
  void dispose() {
    _cardHolderController.dispose();
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvcController.dispose();
    super.dispose();
  }

  Future<void> handlePayment() async {
    if (!_formKey.currentState!.validate()) return;

    final cardNumber = _cardNumberController.text.trim().replaceAll(' ', '');
    final expiryParts = _expiryController.text.split('/');
    if (expiryParts.length != 2) {
      showErrorDialog("Expiry must be in MM/YY format.");
      return;
    }

    final expMonth = int.tryParse(expiryParts[0]);
    final expYear = int.tryParse("20${expiryParts[1]}");

    if (expMonth == null || expYear == null || expMonth < 1 || expMonth > 12) {
      showErrorDialog("Invalid expiry date.");
      return;
    }

    setState(() => isLoading = true);

    try {
      // // final billingDetails = BillingDetails(
      //   name: _cardHolderController.text,
      //   email: widget.newsignupData['email'],
      //   phone: widget.newsignupData['phone'],
      // );
      // print(billingDetails);
      final body = {
        "fname": widget.newsignupData['fname'],
        "lname": widget.newsignupData['lname'],
        "email": widget.newsignupData['email'],
        "phone": widget.newsignupData['phone'],
        "age": widget.newsignupData['age'],
        "profession": widget.newsignupData['profession'],
        "residential_city": widget.newsignupData['residential_city'],
        "residential_country": widget.newsignupData['residential_country'],
        "pass": widget.newsignupData['pass'] ?? '',
        "referral_code": widget.newsignupData['referral_code'] ?? '',
        "stripe_token": "tok_visa",
        "total_amount": 15.00,
      };
      print(body);

      final response = await http.post(
        Uri.parse('https://winngooreels.wimbgo.com/api/register'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "fname": widget.newsignupData['fname'],
          "lname": widget.newsignupData['lname'],
          "email": widget.newsignupData['email'],
          "phone": widget.newsignupData['phone'],
          "age": widget.newsignupData['age'],
          "profession": widget.newsignupData['profession'],
          "residential_city": widget.newsignupData['residential_city'],
          "residential_country": widget.newsignupData['residential_country'],
          "pass": widget.newsignupData['pass'] ?? '',
          "referral_code": widget.newsignupData['referral_code'] ?? '',
          "stripe_token": "tok_visa",
          "total_amount": 15.00,
        }),
      );
      print("respone = $response");
      if (response.statusCode == 201) {
        showSuccessDialog("Payment successful & registration completed!");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } else {
        String errorMessage = "Registration failed.";
        try {
          final resBody = jsonDecode(response.body);
          errorMessage = resBody['message'] ?? response.body;
        } catch (_) {
          errorMessage = response.body;
        }
        showErrorDialog(errorMessage);
      }
    } catch (e) {
      print("payment error:$e");
      showErrorDialog("Payment error: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text("Error"),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          ),
    );
  }

  void showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text("Success"),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                  Navigator.pop(context); // Go back to previous screen
                },
                child: const Text("OK"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Payment Details',
            style: TextStyle(
              color: Color(0xff2b21f3),
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: const BackButton(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    buildInfoRow('Business Type', 'Winngoo reels competition'),
                    buildDivider(),
                    buildInfoRow('Currency', 'GBP'),
                    buildDivider(),
                    buildInfoRow(
                      'Order Description',
                      'Winngoo reels Membership',
                    ),
                    buildDivider(),
                    buildInfoRow(
                      'Payment Amount',
                      '£15',
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Credit/ Debit Card',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Add and secure cards as per RBI guidelines',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 10),
                    buildTextField(
                      controller: _cardHolderController,
                      label: 'A/c Holder Name *',
                      validator:
                          (val) =>
                              val!.trim().isEmpty
                                  ? 'Card holder name is required'
                                  : null,
                    ),
                    buildTextField(
                      controller: _cardNumberController,
                      label: 'Card Number *',
                      inputFormatters: [_cardNumberFormatter],
                      keyboardType: TextInputType.number,
                      validator:
                          (val) =>
                              val!.replaceAll(' ', '').length != 16
                                  ? 'Enter valid card number'
                                  : null,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: buildTextField(
                            controller: _expiryController,
                            label: 'Expiry (MM/YY) *',
                            inputFormatters: [_expiryFormatter],
                            keyboardType: TextInputType.number,
                            validator:
                                (val) =>
                                    val!.length != 5
                                        ? 'Invalid expiry date'
                                        : null,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: buildTextField(
                            controller: _cvcController,
                            label: 'CVV *',
                            obscureText: true,
                            keyboardType: TextInputType.number,
                            validator:
                                (val) =>
                                    val!.length != 3
                                        ? 'Enter valid 3-digit CVV'
                                        : null,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: isLoading ? null : handlePayment,
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xff2b21f3),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Pay Now",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            if (isLoading)
              Container(
                color: Colors.black26,
                child: const Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoRow(
    String label,
    String value, {
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Expanded(child: Text(label, style: const TextStyle(fontSize: 16))),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 16,
                color: color,
                fontWeight: fontWeight,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider() => Divider(thickness: 1, color: Colors.grey[300]);

  Widget buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    List<TextInputFormatter>? inputFormatters,
    required FormFieldValidator<String> validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: validator,
      ),
    );
  }
}
