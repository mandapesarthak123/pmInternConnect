import 'package:flutter/material.dart';

class EmploymentDetailsPage extends StatefulWidget {
  const EmploymentDetailsPage({super.key});

  @override
  State<EmploymentDetailsPage> createState() => _EmploymentDetailsPageState();
}

class _EmploymentDetailsPageState extends State<EmploymentDetailsPage> {
  final _formKey = GlobalKey<FormState>();

  // List of employment entries
  List<Map<String, TextEditingController>> employmentList = [
    {
      "company": TextEditingController(),
      "start": TextEditingController(),
      "end": TextEditingController(),
      "position": TextEditingController(),
      "description": TextEditingController(),
      "internship": TextEditingController(text: "No"),
    }
  ];

  // Add new employment entry
  void _addEmployment() {
    setState(() {
      employmentList.add({
        "company": TextEditingController(),
        "start": TextEditingController(),
        "end": TextEditingController(),
        "position": TextEditingController(),
        "description": TextEditingController(),
        "internship": TextEditingController(text: "No"),
      });
    });
  }

  // Next button handler
  void _onNext() {
    if (_formKey.currentState!.validate()) {
      List<Map<String, String>> data = employmentList.map((entry) {
        return {
          "company": entry["company"]!.text,
          "start": entry["start"]!.text,
          "end": entry["end"]!.text,
          "position": entry["position"]!.text,
          "description": entry["description"]!.text,
          "internship": entry["internship"]!.text,
        };
      }).toList();

      debugPrint("Employment Details: $data");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Employment details saved ✅")),
      );

      // TODO: Navigate to next page
    }
  }

  Widget _buildStepper() {
    return const Row(
      children: [
        Icon(Icons.radio_button_checked, color: Color(0xFFFF7600)), // Step 1
        Expanded(child: Divider(thickness: 2, color: Color(0xFFFF7600))),
        Icon(Icons.radio_button_checked, color: Color(0xFFFF7600)), //step 2
        Expanded(child: Divider(thickness: 2, color: Color(0xFFFF7600))),
        Icon(Icons.radio_button_checked, color: Color(0xFFFF7600)), //step 3
        Expanded(child: Divider(thickness: 2, color: Colors.grey)),
        Icon(Icons.radio_button_unchecked, color: Colors.grey), // Step 4
      ],
    );
  }

  Widget _buildEmploymentCard(int index) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Employment ${index + 1}",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),

            // Company Name
            TextFormField(
              controller: employmentList[index]["company"],
              decoration: const InputDecoration(
                labelText: "Company Name",
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
                  v == null || v.isEmpty ? "Please enter company name" : null,
            ),
            const SizedBox(height: 12),

            // Position
            TextFormField(
              controller: employmentList[index]["position"],
              decoration: const InputDecoration(
                labelText: "Position",
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
                  v == null || v.isEmpty ? "Please enter position" : null,
            ),
            const SizedBox(height: 12),

            // Start Date (MM/YYYY)
            TextFormField(
              controller: employmentList[index]["start"],
              readOnly: true,
              decoration: const InputDecoration(
                labelText: "Start (MM/YYYY)",
                border: OutlineInputBorder(),
              ),
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1950),
                  lastDate: DateTime(DateTime.now().year + 10),
                );
                if (picked != null) {
                  setState(() {
                    employmentList[index]["start"]!.text =
                        "${picked.month.toString().padLeft(2, '0')}/${picked.year}";
                  });
                }
              },
              validator: (v) =>
                  v == null || v.isEmpty ? "Please select start date" : null,
            ),
            const SizedBox(height: 12),

            // End Date (MM/YYYY)
            TextFormField(
              controller: employmentList[index]["end"],
              readOnly: true,
              decoration: const InputDecoration(
                labelText: "End (MM/YYYY)",
                border: OutlineInputBorder(),
              ),
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1950),
                  lastDate: DateTime(DateTime.now().year + 10),
                );
                if (picked != null) {
                  setState(() {
                    employmentList[index]["end"]!.text =
                        "${picked.month.toString().padLeft(2, '0')}/${picked.year}";
                  });
                }
              },
              validator: (v) =>
                  v == null || v.isEmpty ? "Please select end date" : null,
            ),
            const SizedBox(height: 12),

            // Description
            TextFormField(
              controller: employmentList[index]["description"],
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
                  v == null || v.isEmpty ? "Please enter description" : null,
            ),
            const SizedBox(height: 12),

            // Internship Dropdown
            DropdownButtonFormField<String>(
              value: employmentList[index]["internship"]!.text,
              items: const [
                DropdownMenuItem(value: "Yes", child: Text("Yes")),
                DropdownMenuItem(value: "No", child: Text("No")),
              ],
              onChanged: (val) {
                setState(() {
                  employmentList[index]["internship"]!.text = val!;
                });
              },
              decoration: const InputDecoration(
                labelText: "Is Internship?",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                _buildStepper(),
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Employment Details",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for (int i = 0; i < employmentList.length; i++)
                          _buildEmploymentCard(i),

                        // Add Employment Button
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton.icon(
                            onPressed: _addEmployment,
                            icon:
                                const Icon(Icons.add, color: Color(0xFFFF7600)),
                            label: const Text(
                              "Add Employment",
                              style: TextStyle(color: Color(0xFFFF7600)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      // Next Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF7600),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: _onNext,
            child: const Text("Next",
                style: TextStyle(color: Colors.white, fontSize: 16)),
          ),
        ),
      ),
    );
  }
}
