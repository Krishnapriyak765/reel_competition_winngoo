import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reels_application/auth/register/register_personal_info.dart';
import 'package:reels_application/core/services/policy_pdf_service.dart';
import 'package:reels_application/core/services/privacy_policy.dart';

class CreateAccountPage extends StatefulWidget {
  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _agree = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController referralController = TextEditingController();

  final GlobalKey<FormState> key = GlobalKey<FormState>();

  final Map<String, dynamic> signupData = {
    'email': '',
    'pass': '',
    'referral_code': '',
  };

  void onNextPressed() {
    if (key.currentState!.validate()) {
      if (!_agree) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Please agree to the terms.")));
        return;
      }

      signupData['email'] = emailController.text.trim();
      signupData['pass'] = passwordController.text.trim();
      signupData['referral_code'] = referralController.text.trim();
      print(signupData);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PersonalInfoForm(signupData: signupData),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Form(
            key: key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Join now and dive into a world of endless reels and creativity',
                  style: TextStyle(color: Colors.grey[700]),
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: nameController,
                  decoration: _inputDecoration("Name", "Winngoo"),
                  validator:
                      (value) => value!.isEmpty ? "Name cannot be empty" : null,
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: emailController,
                  decoration: _inputDecoration("Email", "winngoo@example.com"),
                  validator: (value) {
                    if (value!.isEmpty) return "Email cannot be empty";
                    if (!value.contains("@")) return "Enter a valid email";
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: passwordController,
                  obscureText: _obscurePassword,
                  decoration: _inputDecoration("Password", "********").copyWith(
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed:
                          () => setState(() {
                            _obscurePassword = !_obscurePassword;
                          }),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.length < 8) {
                      return "Use 8+ characters for password";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8),
                Text(
                  'Use 8+ characters with a mix of letters, numbers & symbols (!@#%)',
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: _obscureConfirm,
                  decoration: _inputDecoration(
                    "Confirm Password",
                    "********",
                  ).copyWith(
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirm
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed:
                          () => setState(() {
                            _obscureConfirm = !_obscureConfirm;
                          }),
                    ),
                  ),
                  validator: (value) {
                    if (value != passwordController.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: referralController,
                  decoration: _inputDecoration(
                    "Referral Code",
                    "Winngooreels-799739",
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Checkbox(
                      value: _agree,
                      onChanged: (value) => setState(() => _agree = value!),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(text: 'I agree to the '),
                            TextSpan(
                              text: 'Terms & Conditions',
                              style: TextStyle(color: Colors.blue),
                              recognizer:
                                  TapGestureRecognizer()
                                    ..onTap = () async {
                                      final pdfUrls = await fetchPdfUrl(
                                        "https://winngooreels.wimbgo.com/api/terms-conditions",
                                      );
                                      if (pdfUrls != null) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) => PDFViewerPage(
                                                  pdfUrl: pdfUrls,
                                                ),
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Failed to load PDF URL',
                                            ),
                                          ),
                                        );
                                      }
                                    },
                            ),
                            TextSpan(text: ' and '),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: TextStyle(color: Colors.blue),
                              recognizer:
                                  TapGestureRecognizer()
                                    ..onTap = () async {
                                      final pdfUrls = await fetchPdfUrl(
                                        "https://winngooreels.wimbgo.com/api/privacy",
                                      );
                                      if (pdfUrls != null) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) => PDFViewerPage(
                                                  pdfUrl: pdfUrls,
                                                ),
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Failed to load PDF URL',
                                            ),
                                          ),
                                        );
                                      }
                                    },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: Color(0xff2b21f3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: onNextPressed,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 99,
                        vertical: 15,
                      ),
                      child: const Text(
                        "Next",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an Account? '),
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => Onboarding()),

                        // );
                        context.pushNamed('login');
                      },
                      child: const Text(
                        "  Sign in",
                        style: TextStyle(
                          color: Color(0xff2b21f3),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, String hint) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
