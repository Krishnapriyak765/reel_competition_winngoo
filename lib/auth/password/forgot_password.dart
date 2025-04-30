import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:reels_application/auth/password/new_password.dart';

class Forgetpw extends StatefulWidget {
  const Forgetpw({Key? key}) : super(key: key);

  @override
  State<Forgetpw> createState() => _ForgetpwState();
}

class _ForgetpwState extends State<Forgetpw> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  Future<void> forgetuser(BuildContext context) async {
    final url = "https://winngooreels.wimbgo.com/api/forgot-password";
    final email = _emailController.text.trim();
    // final password = passwordController.text.trim();

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({"email": email}),
      );

      print("response = ${response.body}");

      final resBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // final token = resBody['token'];
        // print("toke: $token");

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Createnewpw()),
        );
      } else {
        String errorMessage = resBody['message'] ?? "Login failed.";
        showErrorDialog(context, errorMessage);
      }
    } catch (e) {
      showErrorDialog(
        context,
        "Network error: Please check your internet connection.",
      );
    }
  }

  static void showErrorDialog(BuildContext context, String message) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Forgot Password",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image.asset('assets/images/fpw.jpeg', height: 150)),
              const SizedBox(height: 25),
              const Text(
                "Email",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Please enter the email associated with your account.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "The field is empty";
                  }
                  if (!RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$',
                  ).hasMatch(value.trim())) {
                    return "Enter a valid email";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  hintText: "winngoo29@gmail.com",
                ),
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: const Color(0xff2b21f3),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // TODO: API call to send password reset link
                      // forgetuser(email:_emailController);
                      forgetuser(context);
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    child: Text(
                      "Send Password Reset Link",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
