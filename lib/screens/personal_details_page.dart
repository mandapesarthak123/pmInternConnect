import 'package:flutter/material.dart';
import 'package:pm_internship/screens/education_details_page.dart';

class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({super.key});

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  // Personal Info
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _dobController = TextEditingController();
  final _phoneController = TextEditingController();
  String? _selectedGender;

  // Local Address
  final _localLine1Controller = TextEditingController();
  final _localLine2Controller = TextEditingController();
  final _localCityController = TextEditingController();
  final _localStateController = TextEditingController();
  final _localCountryController = TextEditingController();
  final _localPostalController = TextEditingController();

  // Permanent Address
  final _permLine1Controller = TextEditingController();
  final _permLine2Controller = TextEditingController();
  final _permCityController = TextEditingController();
  final _permStateController = TextEditingController();
  final _permCountryController = TextEditingController();
  final _permPostalController = TextEditingController();

  bool _sameAsPermanant = false;

  // void _onNext() {
  //   if (_formKey.currentState!.validate()) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text("Details submitted ✅")),
  //     );
  //     // Navigate to next step
  //   }
  // }

  void _onNext() {
    if (_formKey.currentState!.validate()) {
      // Show a success message
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text("Details submitted ✅")),
      // );

      // Navigate to the next page after a short delay
      Future.delayed(const Duration(milliseconds: 5), () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  EducationDetailsPage()), // replace with your next screen widget
        );
      });
    }
  }

  void _PermanentToLocal() {
    _localLine1Controller.text = _permLine1Controller.text;
    _localLine2Controller.text = _permLine2Controller.text;
    _localCityController.text = _permCityController.text;
    _localStateController.text = _permStateController.text;
    _localCountryController.text = _permCountryController.text;
    _localPostalController.text = _permPostalController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),

                        // Stepper
                        Row(
                          children: [
                            Icon(Icons.radio_button_checked,
                                color: const Color(0xFFFF7600)),
                            const Expanded(
                              child: Divider(
                                thickness: 2,
                                color: const Color(0xFFFF7600),
                              ),
                            ),
                            const Icon(Icons.radio_button_unchecked,
                                color: Colors.grey),
                            const Expanded(
                              child: Divider(thickness: 2, color: Colors.grey),
                            ),
                            const Icon(Icons.radio_button_unchecked,
                                color: Colors.grey),
                            const Expanded(
                              child: Divider(thickness: 2, color: Colors.grey),
                            ),
                            const Icon(Icons.radio_button_unchecked,
                                color: Colors.grey),
                          ],
                        ),
                        const SizedBox(height: 20),

                        const Text(
                          "Personal details",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),

                        // First Name
                        TextFormField(
                          controller: _firstNameController,
                          decoration: const InputDecoration(
                            labelText: "First Name",
                            border: OutlineInputBorder(),
                          ),
                          validator: (v) =>
                              v == null || v.isEmpty ? "Required" : null,
                        ),
                        const SizedBox(height: 16),

                        // Last Name
                        TextFormField(
                          controller: _lastNameController,
                          decoration: const InputDecoration(
                            labelText: "Last Name",
                            border: OutlineInputBorder(),
                          ),
                          validator: (v) =>
                              v == null || v.isEmpty ? "Required" : null,
                        ),
                        const SizedBox(height: 16),

                        // Date of Birth
                        TextFormField(
                          controller: _dobController,
                          readOnly: true,
                          decoration: const InputDecoration(
                            labelText: "Date of Birth",
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                          onTap: () async {
                            DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime(2000),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );
                            if (picked != null) {
                              _dobController.text =
                                  "${picked.day}/${picked.month}/${picked.year}";
                            }
                          },
                          validator: (v) =>
                              v == null || v.isEmpty ? "Required" : null,
                        ),
                        const SizedBox(height: 20),

                        // Permanent Address
                        const Text("Permanent Address",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 10),

                        TextFormField(
                          controller: _permLine1Controller,
                          decoration: const InputDecoration(
                            labelText: "Address Line 1",
                            border: OutlineInputBorder(),
                          ),
                          validator: (v) =>
                              v == null || v.isEmpty ? "Required" : null,
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _permLine2Controller,
                          decoration: const InputDecoration(
                            labelText: "Address Line 2 (Optional)",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _permCityController,
                          decoration: const InputDecoration(
                            labelText: "City",
                            border: OutlineInputBorder(),
                          ),
                          validator: (v) =>
                              v == null || v.isEmpty ? "Required" : null,
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _permStateController,
                          decoration: const InputDecoration(
                            labelText: "State",
                            border: OutlineInputBorder(),
                          ),
                          validator: (v) =>
                              v == null || v.isEmpty ? "Required" : null,
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _permCountryController,
                          decoration: const InputDecoration(
                            labelText: "Country",
                            border: OutlineInputBorder(),
                          ),
                          validator: (v) =>
                              v == null || v.isEmpty ? "Required" : null,
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _permPostalController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "Postal Code",
                            border: OutlineInputBorder(),
                          ),
                          validator: (v) =>
                              v == null || v.isEmpty ? "Required" : null,
                        ),
                        const SizedBox(height: 10),

                        // Checkbox
                        Row(
                          children: [
                            Checkbox(
                              value: _sameAsPermanant,
                              onChanged: (value) {
                                setState(() {
                                  _sameAsPermanant = value ?? false;
                                  if (_sameAsPermanant) {
                                    _PermanentToLocal();
                                  } else {
                                    _localLine1Controller.clear();
                                    _localLine2Controller.clear();
                                    _localCityController.clear();
                                    _localStateController.clear();
                                    _localCountryController.clear();
                                    _localPostalController.clear();
                                  }
                                });
                              },
                            ),
                            const Text("Permanent Address same as Local"),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // Permanent Address
                        if (!_sameAsPermanant) ...[
                          const Text("Local Address",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _permLine1Controller,
                            decoration: const InputDecoration(
                              labelText: "Address Line 1",
                              border: OutlineInputBorder(),
                            ),
                            validator: (v) =>
                                v == null || v.isEmpty ? "Required" : null,
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _permLine2Controller,
                            decoration: const InputDecoration(
                              labelText: "Address Line 2 (Optional)",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _permCityController,
                            decoration: const InputDecoration(
                              labelText: "City",
                              border: OutlineInputBorder(),
                            ),
                            validator: (v) =>
                                v == null || v.isEmpty ? "Required" : null,
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _permStateController,
                            decoration: const InputDecoration(
                              labelText: "State",
                              border: OutlineInputBorder(),
                            ),
                            validator: (v) =>
                                v == null || v.isEmpty ? "Required" : null,
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _permCountryController,
                            decoration: const InputDecoration(
                              labelText: "Country",
                              border: OutlineInputBorder(),
                            ),
                            validator: (v) =>
                                v == null || v.isEmpty ? "Required" : null,
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _permPostalController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: "Postal Code",
                              border: OutlineInputBorder(),
                            ),
                            validator: (v) =>
                                v == null || v.isEmpty ? "Required" : null,
                          ),
                          const SizedBox(height: 10),
                        ],

                        const SizedBox(height: 20),

                        // Gender
                        DropdownButtonFormField<String>(
                          value: _selectedGender,
                          items: const [
                            DropdownMenuItem(
                                value: "Male", child: Text("Male")),
                            DropdownMenuItem(
                                value: "Female", child: Text("Female")),
                            DropdownMenuItem(
                                value: "Prefer not to say",
                                child: Text("Prefer not to say")),
                          ],
                          decoration: const InputDecoration(
                            labelText: "Gender",
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (val) => setState(() {
                            _selectedGender = val;
                          }),
                          validator: (v) => v == null ? "Select gender" : null,
                        ),
                        const SizedBox(height: 16),

                        // Phone
                        TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            labelText: "Phone Number",
                            border: OutlineInputBorder(),
                          ),
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return "Required";
                            }
                            if (v.length < 10) return "Enter valid number";
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),

                // Bottom Next button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF7600),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: _onNext,
                    child: const Text(
                      "Next",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
