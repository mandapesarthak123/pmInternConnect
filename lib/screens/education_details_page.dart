// import 'package:flutter/material.dart';

// class EducationDetailsPage extends StatefulWidget {
//   const EducationDetailsPage({super.key});

//   @override
//   State<EducationDetailsPage> createState() => _EducationDetailsPageState();
// }

// class _EducationDetailsPageState extends State<EducationDetailsPage> {
//   final _formKey = GlobalKey<FormState>();

//   // List of education entries
//   List<Map<String, TextEditingController>> educationList = [
//     {
//       "institute": TextEditingController(),
//       "degree": TextEditingController(),
//       "course": TextEditingController(),
//       "startYear": TextEditingController(),
//       "endYear": TextEditingController(),
//     }
//   ];

//   // Add a new degree entry
//   void _addDegree() {
//     setState(() {
//       educationList.add({
//         "institute": TextEditingController(),
//         "degree": TextEditingController(),
//         "course": TextEditingController(),
//         "startYear": TextEditingController(),
//         "endYear": TextEditingController(),
//       });
//     });
//   }

//   // Next button handler
//   void _onNext() {
//     if (_formKey.currentState!.validate()) {
//       // Collect entered data
//       List<Map<String, String>> data = educationList.map((entry) {
//         return {
//           "institute": entry["institute"]!.text,
//           "degree": entry["degree"]!.text,
//           "course": entry["course"]!.text,
//           "startYear": entry["startYear"]!.text,
//           "endYear": entry["endYear"]!.text,
//         };
//       }).toList();

//       // For now just print
//       debugPrint("Education Details: $data");

//       // Navigate to next page (replace with your page)
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Proceeding to next step ✅")),
//       );
//     }
//   }

//   Widget _buildStepper() {
//     return Row(
//       children: [
//         Icon(Icons.radio_button_checked, color: const Color(0xFFFF7600)),
//         const Expanded(
//           child: Divider(thickness: 2, color: const Color(0xFFFF7600)),
//         ),
//         Icon(Icons.radio_button_checked, color: const Color(0xFFFF7600)),
//         const Expanded(
//           child: Divider(thickness: 2, color: Colors.grey),
//         ),
//         const Icon(Icons.radio_button_unchecked, color: Colors.grey),
//         const Expanded(
//           child: Divider(thickness: 2, color: Colors.grey),
//         ),
//         const Icon(Icons.radio_button_unchecked, color: Colors.grey),
//       ],
//     );
//   }

//   Widget _buildEducationCard(int index) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         TextFormField(
//           controller: educationList[index]["institute"],
//           decoration: const InputDecoration(
//             labelText: "Institute",
//             border: OutlineInputBorder(),
//           ),
//           validator: (v) =>
//               v == null || v.isEmpty ? "Please enter institute" : null,
//         ),
//         const SizedBox(height: 12),
//         TextFormField(
//           controller: educationList[index]["degree"],
//           decoration: const InputDecoration(
//             labelText: "Degree",
//             border: OutlineInputBorder(),
//           ),
//           validator: (v) =>
//               v == null || v.isEmpty ? "Please enter degree" : null,
//         ),
//         const SizedBox(height: 12),
//         TextFormField(
//           controller: educationList[index]["course"],
//           decoration: const InputDecoration(
//             labelText: "Course",
//             border: OutlineInputBorder(),
//           ),
//           validator: (v) =>
//               v == null || v.isEmpty ? "Please enter course" : null,
//         ),
//         const SizedBox(height: 12),
//         TextFormField(
//           controller: educationList[index]["startYear"],
//           keyboardType: TextInputType.number,
//           decoration: const InputDecoration(
//             labelText: "Start Year",
//             border: OutlineInputBorder(),
//           ),
//           validator: (v) =>
//               v == null || v.isEmpty ? "Please enter start year" : null,
//         ),
//         const SizedBox(height: 12),
//         TextFormField(
//           controller: educationList[index]["endYear"],
//           keyboardType: TextInputType.number,
//           decoration: const InputDecoration(
//             labelText: "End Year",
//             border: OutlineInputBorder(),
//           ),
//           validator: (v) =>
//               v == null || v.isEmpty ? "Please enter end year" : null,
//         ),
//         const SizedBox(height: 20),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 const SizedBox(height: 20),
//                 _buildStepper(),
//                 const SizedBox(height: 20),
//                 const Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     "Education details",
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         for (int i = 0; i < educationList.length; i++)
//                           _buildEducationCard(i),
//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: TextButton.icon(
//                             onPressed: _addDegree,
//                             icon: const Icon(Icons.add,
//                                 color: const Color(0xFFFF7600)),
//                             label: const Text(
//                               "Add Degree",
//                               style: TextStyle(color: const Color(0xFFFF7600)),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 80),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
//         child: SizedBox(
//           width: double.infinity,
//           height: 50,
//           child: ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFFFF7600),
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8)),
//             ),
//             onPressed: _onNext,
//             child: const Text("Next",
//                 style: TextStyle(color: Colors.white, fontSize: 16)),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class EducationDetailsPage extends StatefulWidget {
  const EducationDetailsPage({super.key});

  @override
  State<EducationDetailsPage> createState() => _EducationDetailsPageState();
}

class _EducationDetailsPageState extends State<EducationDetailsPage> {
  final _formKey = GlobalKey<FormState>();

  // List of education entries
  List<Map<String, TextEditingController>> educationList = [
    {
      "institute": TextEditingController(),
      "degree": TextEditingController(),
      "course": TextEditingController(),
      "startYear": TextEditingController(),
      "endYear": TextEditingController(),
    }
  ];

  // Add a new degree entry
  void _addDegree() {
    setState(() {
      educationList.add({
        "institute": TextEditingController(),
        "degree": TextEditingController(),
        "course": TextEditingController(),
        "startYear": TextEditingController(),
        "endYear": TextEditingController(),
      });
    });
  }

  // Next button handler
  void _onNext() {
    if (_formKey.currentState!.validate()) {
      // Collect entered data
      List<Map<String, String>> data = educationList.map((entry) {
        return {
          "institute": entry["institute"]!.text,
          "degree": entry["degree"]!.text,
          "course": entry["course"]!.text,
          "startYear": entry["startYear"]!.text,
          "endYear": entry["endYear"]!.text,
        };
      }).toList();

      // For now just print
      debugPrint("Education Details: $data");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Proceeding to next step ✅")),
      );
    }
  }

  Widget _buildStepper() {
    return Row(
      children: [
        Icon(Icons.radio_button_checked, color: const Color(0xFFFF7600)),
        const Expanded(
          child: Divider(thickness: 2, color: Color(0xFFFF7600)),
        ),
        Icon(Icons.radio_button_checked, color: const Color(0xFFFF7600)),
        const Expanded(
          child: Divider(thickness: 2, color: Colors.grey),
        ),
        const Icon(Icons.radio_button_unchecked, color: Colors.grey),
        const Expanded(
          child: Divider(thickness: 2, color: Colors.grey),
        ),
        const Icon(Icons.radio_button_unchecked, color: Colors.grey),
      ],
    );
  }

  Widget _buildEducationCard(int index) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Degree ${index + 1}",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),

            // Institute
            TextFormField(
              controller: educationList[index]["institute"],
              decoration: const InputDecoration(
                labelText: "Institute",
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
                  v == null || v.isEmpty ? "Please enter institute" : null,
            ),
            const SizedBox(height: 12),

            // Degree
            TextFormField(
              controller: educationList[index]["degree"],
              decoration: const InputDecoration(
                labelText: "Degree",
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
                  v == null || v.isEmpty ? "Please enter degree" : null,
            ),
            const SizedBox(height: 12),

            // Course
            TextFormField(
              controller: educationList[index]["course"],
              decoration: const InputDecoration(
                labelText: "Course",
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
                  v == null || v.isEmpty ? "Please enter course" : null,
            ),
            const SizedBox(height: 12),

            // Start Year
            TextFormField(
              controller: educationList[index]["startYear"],
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Start Year",
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
                  v == null || v.isEmpty ? "Please enter start year" : null,
            ),
            const SizedBox(height: 12),

            // End Year
            TextFormField(
              controller: educationList[index]["endYear"],
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "End Year",
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
                  v == null || v.isEmpty ? "Please enter end year" : null,
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
                    "Education details",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for (int i = 0; i < educationList.length; i++)
                          _buildEducationCard(i),

                        // Add Degree Button
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton.icon(
                            onPressed: _addDegree,
                            icon:
                                const Icon(Icons.add, color: Color(0xFFFF7600)),
                            label: const Text(
                              "Add Degree",
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
