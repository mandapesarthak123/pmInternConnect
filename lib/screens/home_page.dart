import 'package:flutter/material.dart';
import 'package:swipable_stack/swipable_stack.dart';

class Internship {
  final String title;
  final String company;
  final String location;
  final String salary;
  final String type;
  final String experience;
  final List<String> skills;
  final String imageUrl;

  Internship({
    required this.title,
    required this.company,
    required this.location,
    required this.salary,
    required this.type,
    required this.experience,
    required this.skills,
    required this.imageUrl,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SwipableStackController _controller = SwipableStackController();

  final List<Internship> internships = [
    Internship(
      title: "Financial Analyst Intern",
      company: "Capital Partners",
      location: "Chicago, IL",
      salary: "\$80K - \$100K",
      type: "Full-time",
      experience: "2+ years",
      skills: ["Finance", "Analytics", "Excel"],
      imageUrl:
          "https://images.unsplash.com/photo-1501594907352-04cda38ebc29?fit=crop&w=800&q=80",
    ),
    Internship(
      title: "Marketing Intern",
      company: "Brand Co.",
      location: "New York, NY",
      salary: "\$60K - \$70K",
      type: "Part-time",
      experience: "1+ year",
      skills: ["Marketing", "SEO", "Content"],
      imageUrl:
          "https://images.unsplash.com/photo-1504384308090-c894fdcc538d?fit=crop&w=800&q=80",
    ),
    Internship(
      title: "Software Engineer Intern",
      company: "Tech Innovators",
      location: "San Francisco, CA",
      salary: "\$100K - \$120K",
      type: "Full-time",
      experience: "2+ years",
      skills: ["Flutter", "Firebase", "APIs"],
      imageUrl:
          "https://images.unsplash.com/photo-1518770660439-4636190af475?fit=crop&w=800&q=80",
    ),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PM InternConnect"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Completion Section
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Profile Completion"),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: 0.75,
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(10),
                      backgroundColor: Colors.grey[300],
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Complete your profile to get better matches",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Search bar
            TextField(
              decoration: InputDecoration(
                hintText: "Search internships...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),

            const Text(
              "Top recommendations",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Swipable Stack
            Expanded(
              child: currentIndex < internships.length
                  ? SwipableStack(
                      controller: _controller,
                      itemCount: internships.length,
                      stackClipBehaviour: Clip.none,
                      detectableSwipeDirections: const {
                        SwipeDirection.right,
                        SwipeDirection.left,
                      },
                      onSwipeCompleted: (index, direction) {
                        final internship = internships[index];
                        setState(() {
                          currentIndex = index + 1;
                        });

                        if (direction == SwipeDirection.right) {
                          debugPrint("Interested in: ${internship.title}");
                        } else if (direction == SwipeDirection.left) {
                          debugPrint("Not Interested in: ${internship.title}");
                        }
                      },
                      // 👇 This makes the "stacked cards" effect
                      builder: (context, properties) {
                        if (properties.index >= internships.length) {
                          return const SizedBox(); // No more cards
                        }
                        final internship = internships[properties.index];

                        // Card behind effect
                        final position = properties.index - currentIndex;
                        final scale =
                            1 - (position * 0.05); // shrink behind cards
                        final offset = position * 10.0; // vertical shift

                        return Transform.translate(
                          offset: Offset(0, offset),
                          child: Transform.scale(
                            scale: scale,
                            child: buildInternshipCard(internship),
                          ),
                        );
                      },
                    )
                  : buildNoMoreJobsCard(),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Homepage"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Browse"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  Widget buildInternshipCard(Internship internship) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.network(
              internship.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          // Gradient overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),
          // Text Info
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  internship.title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  internship.company,
                  style: const TextStyle(color: Colors.white70),
                ),
                Text(
                  internship.location,
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 8),
                Text(
                  internship.salary,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: internship.skills
                      .map((skill) => Chip(
                            label: Text(skill),
                            backgroundColor: Colors.black54,
                            labelStyle: const TextStyle(color: Colors.white),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNoMoreJobsCard() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.work_off, size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            "Come back again for more jobs",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'dart:math';

// void main() {
//   runApp(const MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: JobSwipeScreen(),
//   ));
// }

// class JobSwipeScreen extends StatefulWidget {
//   const JobSwipeScreen({super.key});

//   @override
//   State<JobSwipeScreen> createState() => _JobSwipeScreenState();
// }

// class _JobSwipeScreenState extends State<JobSwipeScreen>
//     with SingleTickerProviderStateMixin {
//   final List<String> jobs = [
//     "Financial Analyst Intern",
//     "Software Engineer Intern",
//     "UI/UX Designer",
//     "Data Scientist",
//     "Marketing Associate"
//   ];

//   int currentIndex = 0;
//   Offset cardOffset = Offset.zero;
//   double cardAngle = 0;

//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Top recommendations"),
//         backgroundColor: Colors.blueGrey,
//       ),
//       body: Center(
//         child: currentIndex < jobs.length
//             ? Stack(
//                 clipBehavior: Clip.none,
//                 children: List.generate(
//                   3, // Show up to 3 cards (top + 2 peeking behind)
//                   (i) {
//                     int cardIndex = currentIndex + i;
//                     if (cardIndex >= jobs.length) return const SizedBox();

//                     double scale = 1 - (i * 0.05);
//                     double translateY = i * 15;

//                     if (i == 0) {
//                       // Top card (draggable)
//                       return Positioned(
//                         top: translateY,
//                         left: 0,
//                         right: 0,
//                         child: GestureDetector(
//                           onPanUpdate: (details) {
//                             setState(() {
//                               cardOffset += details.delta;
//                               cardAngle =
//                                   cardOffset.dx / screenSize.width * 0.5;
//                             });
//                           },
//                           onPanEnd: (details) {
//                             if (cardOffset.dx.abs() > 100) {
//                               setState(() {
//                                 currentIndex++;
//                                 cardOffset = Offset.zero;
//                                 cardAngle = 0;
//                               });
//                             } else {
//                               setState(() {
//                                 cardOffset = Offset.zero;
//                                 cardAngle = 0;
//                               });
//                             }
//                           },
//                           child: Transform.translate(
//                             offset: cardOffset,
//                             child: Transform.rotate(
//                               angle: cardAngle,
//                               child: jobCard(jobs[cardIndex]),
//                             ),
//                           ),
//                         ),
//                       );
//                     }

//                     // Behind cards
//                     return Positioned(
//                       top: translateY,
//                       left: 0,
//                       right: 0,
//                       child: Transform.scale(
//                         scale: scale,
//                         child: jobCard(jobs[cardIndex]),
//                       ),
//                     );
//                   },
//                 ).reversed.toList(),
//               )
//             : const Center(
//                 child: Text(
//                   "Come back again for more jobs",
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//               ),
//       ),
//     );
//   }

//   Widget jobCard(String title) {
//     return Container(
//       height: 400,
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         image: const DecorationImage(
//           image: NetworkImage(
//               "https://images.unsplash.com/photo-1503387762-592deb58ef4e"),
//           fit: BoxFit.cover,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black26,
//             blurRadius: 10,
//             spreadRadius: 1,
//             offset: const Offset(2, 4),
//           )
//         ],
//       ),
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           gradient: LinearGradient(
//             begin: Alignment.bottomCenter,
//             end: Alignment.center,
//             colors: [Colors.black.withOpacity(0.7), Colors.transparent],
//           ),
//         ),
//         child: Align(
//           alignment: Alignment.bottomLeft,
//           child: Text(
//             title,
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 22,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
