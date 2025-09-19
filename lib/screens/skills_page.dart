import 'package:flutter/material.dart';
import 'package:pm_internship/screens/home_page.dart';

class SkillsPage extends StatefulWidget {
  const SkillsPage({super.key});

  @override
  State<SkillsPage> createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> {
  final TextEditingController _searchController = TextEditingController();

  final List<String> _allSkills = [
    // 🌐 Web
    "HTML", "CSS", "JavaScript", "React", "Angular", "Vue.js", "Node.js",
    "Django", "Flask", "Express.js",
    // 📱 Mobile
    "Flutter", "React Native", "Kotlin", "Swift", "Java (Android)",
    // 🤖 AI/ML
    "Python", "TensorFlow", "PyTorch", "Scikit-learn", "NLP", "Deep Learning",
    // ☁️ Cloud
    "AWS", "Azure", "Google Cloud", "Docker", "Kubernetes",
    "Other",
  ];

  List<String> _filteredSkills = [];
  List<String> _selectedSkills = [];
  bool _showDropdown = false;

  void _filterSkills(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredSkills = [];
        _showDropdown = false;
      } else {
        _filteredSkills = _allSkills
            .where((skill) => skill.toLowerCase().contains(query.toLowerCase()))
            .toList();
        if (_filteredSkills.isEmpty) {
          _filteredSkills = ["Other"];
        }
        _showDropdown = true;
      }
    });
  }

  void _addSkill(String skill) async {
    if (skill == "Other") {
      final customSkill = await showDialog<String>(
        context: context,
        builder: (context) {
          String input = "";
          return AlertDialog(
            title: const Text("Add Custom Skill"),
            content: TextField(
              autofocus: true,
              onChanged: (val) => input = val,
              decoration: const InputDecoration(hintText: "Enter skill name"),
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel")),
              ElevatedButton(
                  onPressed: () => Navigator.pop(context, input),
                  child: const Text("Add")),
            ],
          );
        },
      );

      if (customSkill != null && customSkill.trim().isNotEmpty) {
        setState(() => _selectedSkills.add(customSkill.trim()));
      }
    } else if (!_selectedSkills.contains(skill)) {
      setState(() => _selectedSkills.add(skill));
    }
    _searchController.clear();
    _showDropdown = false;
  }

  void _removeSkill(String skill) {
    setState(() => _selectedSkills.remove(skill));
  }

  // 🔹 Stepper widget (consistent with EducationDetails)
  Widget _buildStepper() {
    return const Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: const [
          Icon(Icons.radio_button_checked, color: Color(0xFFFF7600)), // Step 1
          Expanded(child: Divider(thickness: 2, color: Color(0xFFFF7600))),
          Icon(Icons.radio_button_checked, color: Color(0xFFFF7600)), // Step 2
          Expanded(child: Divider(thickness: 2, color: Color(0xFFFF7600))),
          Icon(Icons.radio_button_checked, color: Color(0xFFFF7600)), // Step 3
          Expanded(child: Divider(thickness: 2, color: Color(0xFFFF7600))),
          Icon(Icons.radio_button_checked, color: Color(0xFFFF7600)), // Step 4
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            _buildStepper(),
            const SizedBox(height: 20),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Add your skills",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 10),

            // 🔹 Search Field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _searchController,
                onChanged: _filterSkills,
                decoration: InputDecoration(
                  hintText: "Search skills",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),

            // 🔹 Dropdown only when searching (dynamic height)
            if (_showDropdown)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.orange),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                constraints: const BoxConstraints(
                  maxHeight: 150, // prevent infinite height
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _filteredSkills.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_filteredSkills[index]),
                      onTap: () => _addSkill(_filteredSkills[index]),
                    );
                  },
                ),
              ),

            // 🔹 Selected Skills (Orange Chips)
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _selectedSkills.map((skill) {
                    return Chip(
                      label: Text(skill,
                          style: const TextStyle(color: Colors.white)),
                      backgroundColor: const Color(0xFFFF7600),
                      deleteIcon: const Icon(Icons.close, color: Colors.white),
                      onDeleted: () => _removeSkill(skill),
                    );
                  }).toList(),
                ),
              ),
            ),

            // 🔹 Next Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF7600),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Skills saved: $_selectedSkills")),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              HomePage()), // replace with your next screen widget
                    );
                  },
                  child: const Text("Next",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
