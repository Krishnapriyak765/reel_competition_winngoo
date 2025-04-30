import 'package:flutter/material.dart';
import 'package:reels_application/auth/register/register_payment.dart';

class PersonalInfoForm extends StatefulWidget {
  final Map<String, dynamic> signupData;

  const PersonalInfoForm({super.key, required this.signupData});

  @override
  State<PersonalInfoForm> createState() => _PersonalInfoFormState();
}

class _PersonalInfoFormState extends State<PersonalInfoForm> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _ageController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cityController = TextEditingController();
  final _professionController = TextEditingController();
  final _countryController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    _professionController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  void onNextPressed() {
    if (_formKey.currentState!.validate()) {
      final updatedSignupData = {
        ...widget.signupData,
        'fname': _firstNameController.text.trim(),
        'lname': _lastNameController.text.trim(),
        'age': _ageController.text.trim(),
        'phone': _phoneController.text.trim(),
        'residential_city': _cityController.text.trim(),
        'profession': _professionController.text.trim(),
        'residential_country': _countryController.text.trim(),
      };
      print(updatedSignupData);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PaymentDetailsPage(newsignupData: updatedSignupData),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields correctly.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Personal Information',
            style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
              color: Color(0xff2b21f3),
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  _buildField("First name", "Winngoo", _firstNameController),
                  _buildField("Last name", "Consultancy", _lastNameController),
                  _buildField(
                    "Age",
                    "18",
                    _ageController,
                    keyboardType: TextInputType.number,
                  ),
                  _buildField(
                    "Phone number",
                    "9656895651",
                    _phoneController,
                    keyboardType: TextInputType.phone,
                  ),
                  _buildField("Residential city", "Chennai", _cityController),
                  _buildField("Profession", "Manager", _professionController),
                  _buildField("Country", "UK", _countryController),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: const Color(0xff2b21f3),
                      ),
                      onPressed: onNextPressed,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 99,
                          vertical: 15,
                        ),
                        child: Text(
                          "Next",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField(
    String label,
    String hint,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            validator:
                (value) =>
                    value == null || value.trim().isEmpty
                        ? 'Please enter $label'
                        : null,
            decoration: InputDecoration(
              hintText: hint,
              border: const OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
