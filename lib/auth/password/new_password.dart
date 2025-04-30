import 'package:flutter/material.dart';
import 'package:reels_application/auth/login/login_page.dart';

class Createnewpw extends StatefulWidget {
  const Createnewpw({Key? key}) : super(key: key);

  @override
  State<Createnewpw> createState() => _CreatenewpwState();
}

class _CreatenewpwState extends State<Createnewpw> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwords = TextEditingController();
  final TextEditingController confirmpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create the Password",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image.asset('assets/images/create_password.png')),
              SizedBox(height: 25),
              Text(
                "Email",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: emailcontroller,
                validator: (email) {
                  if (email == null || email.isEmpty) {
                    return "The field is empty";
                  }
                  if (!RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}',
                  ).hasMatch(email)) {
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
              SizedBox(height: 25),
              Text(
                "Password",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: passwords,
                validator: (password) {
                  if (password == null || password.isEmpty) {
                    return "Please enter your password";
                  }
                  if (password.length < 8) {
                    return "Password must be at least 8 characters";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  hintText: "*******",
                ),
              ),
              SizedBox(height: 25),
              Text(
                "Confirm Password",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: confirmpassword,
                validator: (conpassword) {
                  if (conpassword == null || conpassword.isEmpty) {
                    return "Please enter your password";
                  }
                  if (conpassword.length < 8) {
                    return "Password must be at least 8 characters";
                  }
                  if (conpassword != passwords) {
                    return "The password be wrong";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  hintText: "*******",
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // shape: BoxBorder(),
                    // minimumSize: const Size(double.infinity, 48),
                    backgroundColor: Color(0xff2b21f3),
                  ),
                  onPressed: () {
                    // if (_formKey.currentState!.validate()) {
                    // TODO: Add login logic (API call or local check)
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                    // }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 15,
                    ),
                    child: const Text(
                      "Create",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
