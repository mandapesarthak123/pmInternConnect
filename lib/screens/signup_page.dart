// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:pm_internship/screens/login_page.dart';
// import 'package:pm_internship/screens/personal_details_page.dart';

// class SignupScreen extends StatefulWidget {
//   const SignupScreen({super.key});

//   @override
//   State<SignupScreen> createState() => _SignupScreenState();
// }

// class _SignupScreenState extends State<SignupScreen> {
//   final _formKey = GlobalKey<FormState>();
//   bool _termsAccepted = false;
//   bool _isLoading = false;

//   // Controllers
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _contactController = TextEditingController();
//   final _passwordController = TextEditingController();

//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   Future<void> _signupUser() async {
//     if (_formKey.currentState!.validate() && _termsAccepted) {
//       setState(() {
//         _isLoading = true;
//       });

//       try {
//         // Firebase Authentication
//         UserCredential userCredential =
//             await _auth.createUserWithEmailAndPassword(
//           email: _emailController.text.trim(),
//           password: _passwordController.text.trim(),
//         );

//         // Update Display Name (optional)
//         await userCredential.user?.updateDisplayName(_nameController.text);

//         // Success Snackbar
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Signup Successful ✅")),
//         );
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => PersonalDetailsScreen()),
//         );

//         // Navigate to another screen (Dashboard, Home, etc.)
//         // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
//       } on FirebaseAuthException catch (e) {
//         String errorMessage = "Signup failed ❌";

//         if (e.code == 'weak-password') {
//           errorMessage = "Password is too weak";
//         } else if (e.code == 'email-already-in-use') {
//           errorMessage = "Email is already registered";
//         } else if (e.code == 'invalid-email') {
//           errorMessage = "Invalid email address";
//         }

//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(errorMessage)),
//         );
//       } finally {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     } else if (!_termsAccepted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please accept Terms & Conditions ❗")),
//       );
//     }
//   }

//   void _submitForm() {
//     if (_formKey.currentState!.validate() && _termsAccepted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Signup Successful ✅")),
//       );
//       // Navigator.pushReplacement(
//       //   context,
//       //   MaterialPageRoute(builder: (_) => const PersonalDetailsScreen()),
//       // );
//     } else if (!_termsAccepted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please accept Terms & Conditions ❗")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 // Scrollable form content
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const SizedBox(height: 30),
//                         const Text(
//                           "Welcome",
//                           style: TextStyle(
//                               fontSize: 28, fontWeight: FontWeight.bold),
//                         ),
//                         const SizedBox(height: 8),
//                         const Text(
//                           "Let’s help you find the right PM internship for your career goals.",
//                           style: TextStyle(fontSize: 14, color: Colors.grey),
//                         ),
//                         const SizedBox(height: 30),

//                         // Name
//                         TextFormField(
//                           controller: _nameController,
//                           decoration: const InputDecoration(
//                             hintText: "Name",
//                             prefixIcon: Icon(Icons.person_outline),
//                             border: OutlineInputBorder(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(10)),
//                             ),
//                           ),
//                           validator: (value) => value == null || value.isEmpty
//                               ? "Enter your name"
//                               : null,
//                         ),
//                         const SizedBox(height: 16),

//                         // Email
//                         TextFormField(
//                           controller: _emailController,
//                           keyboardType: TextInputType.emailAddress,
//                           decoration: const InputDecoration(
//                             hintText: "Email",
//                             prefixIcon: Icon(Icons.email_outlined),
//                             border: OutlineInputBorder(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(10)),
//                             ),
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return "Enter your email";
//                             }
//                             if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
//                                 .hasMatch(value)) {
//                               return "Enter a valid email";
//                             }
//                             return null;
//                           },
//                         ),
//                         const SizedBox(height: 16),

//                         // Contact No
//                         TextFormField(
//                           controller: _contactController,
//                           keyboardType: TextInputType.phone,
//                           decoration: const InputDecoration(
//                             hintText: "Contact No",
//                             prefixIcon: Icon(Icons.phone_outlined),
//                             border: OutlineInputBorder(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(10)),
//                             ),
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return "Enter your contact number";
//                             }
//                             if (value.length < 10) {
//                               return "Enter a valid number";
//                             }
//                             return null;
//                           },
//                         ),
//                         const SizedBox(height: 16),

//                         // Password
//                         TextFormField(
//                           controller: _passwordController,
//                           obscureText: true,
//                           decoration: const InputDecoration(
//                             hintText: "Password",
//                             prefixIcon: Icon(Icons.lock_outline),
//                             border: OutlineInputBorder(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(10)),
//                             ),
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return "Enter your password";
//                             }
//                             if (value.length < 6) {
//                               return "Password must be at least 6 characters";
//                             }
//                             return null;
//                           },
//                         ),
//                         const SizedBox(height: 16),

//                         // Terms Checkbox
//                         Row(
//                           children: [
//                             Checkbox(
//                               value: _termsAccepted,
//                               onChanged: (value) {
//                                 setState(() {
//                                   _termsAccepted = value ?? false;
//                                 });
//                               },
//                             ),
//                             Expanded(
//                               child: RichText(
//                                 text: const TextSpan(
//                                   text: "By checking the box you agree to our ",
//                                   style: TextStyle(
//                                       color: Colors.black54, fontSize: 13),
//                                   children: [
//                                     TextSpan(
//                                       text: "Terms",
//                                       style: TextStyle(
//                                           color: Colors.orange,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     TextSpan(text: " and "),
//                                     TextSpan(
//                                       text: "Conditions.",
//                                       style: TextStyle(
//                                           color: Colors.orange,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 20),
//                       ],
//                     ),
//                   ),
//                 ),

//                 // Fixed bottom button
//                 Column(
//                   children: [
//                     SizedBox(
//                       width: double.infinity,
//                       height: 50,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xFFFF7600),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                         onPressed: _isLoading ? null : _signupUser,
//                         child: _isLoading
//                             ? const CircularProgressIndicator(
//                                 color: Colors.white)
//                             : const Text(
//                                 "Signup",
//                                 style: TextStyle(
//                                     fontSize: 16, color: Colors.white),
//                               ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text("Already a member? "),
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (_) => const LoginScreen()),
//                             );
//                           },
//                           child: const Text(
//                             "Login",
//                             style: TextStyle(
//                               color: Colors.orange,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pm_internship/main.dart'; // ✅ Import baseURL from main.dart
import 'package:pm_internship/screens/login_page.dart';
import 'package:pm_internship/screens/personal_details_page.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _termsAccepted = false;
  bool _isLoading = false;

  // Controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _contactController = TextEditingController();
  final _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// 🔹 API call function
  Future<void> _sendEmailToAPI(String email) async {
    final String apiUrl =
        "https://eminent-hagfish-winning.ngrok-free.app/users/register/"; // ✅ Using baseURL

    final Map<String, dynamic> body = {
      "user_email": email,
    };

    final Map<String, String> headers = {
      "Content-Type": "application/json",
      "ngrok-skip-browser-warning": "69420",
    };

    try {
      // Debug logs before request
      debugPrint("========= API REQUEST =========");
      debugPrint("➡ URL: $apiUrl");
      debugPrint("➡ Headers: $headers");
      debugPrint("➡ Body: ${jsonEncode(body)}");
      debugPrint("===============================");

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(body),
      );

      // Debug response
      debugPrint("========= API RESPONSE =========");
      debugPrint("⬅ Status Code: ${response.statusCode}");
      debugPrint("⬅ Body: ${response.body}");
      debugPrint("===============================");

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint("✅ Email successfully sent to API");
      } else {
        debugPrint("⚠ Failed to send email to API");
      }
    } catch (e) {
      debugPrint("❌ API Error: $e");
    }
  }

  /// 🔹 Signup user function
  Future<void> _signupUser() async {
    if (_formKey.currentState!.validate() && _termsAccepted) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Firebase Authentication
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // Update Display Name
        await userCredential.user?.updateDisplayName(_nameController.text);

        // ✅ Only call API AFTER successful Firebase signup
        await _sendEmailToAPI(_emailController.text.trim());

        // Success Snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Signup Successful ✅")),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const PersonalDetailsScreen()),
        );
      } on FirebaseAuthException catch (e) {
        String errorMessage = "Signup failed ❌";

        if (e.code == 'weak-password') {
          errorMessage = "Password is too weak";
        } else if (e.code == 'email-already-in-use') {
          errorMessage = "Email is already registered";
        } else if (e.code == 'invalid-email') {
          errorMessage = "Invalid email address";
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else if (!_termsAccepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please accept Terms & Conditions ❗")),
      );
    }
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
                // Scrollable form content
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30),
                        const Text(
                          "Welcome",
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Let’s help you find the right PM internship for your career goals.",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        const SizedBox(height: 30),

                        // Name
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            hintText: "Name",
                            prefixIcon: Icon(Icons.person_outline),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          validator: (value) => value == null || value.isEmpty
                              ? "Enter your name"
                              : null,
                        ),
                        const SizedBox(height: 16),

                        // Email
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: "Email",
                            prefixIcon: Icon(Icons.email_outlined),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter your email";
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                .hasMatch(value)) {
                              return "Enter a valid email";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Contact No
                        TextFormField(
                          controller: _contactController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            hintText: "Contact No",
                            prefixIcon: Icon(Icons.phone_outlined),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter your contact number";
                            }
                            if (value.length < 10) {
                              return "Enter a valid number";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Password
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: "Password",
                            prefixIcon: Icon(Icons.lock_outline),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter your password";
                            }
                            if (value.length < 6) {
                              return "Password must be at least 6 characters";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Terms Checkbox
                        Row(
                          children: [
                            Checkbox(
                              value: _termsAccepted,
                              onChanged: (value) {
                                setState(() {
                                  _termsAccepted = value ?? false;
                                });
                              },
                            ),
                            Expanded(
                              child: RichText(
                                text: const TextSpan(
                                  text: "By checking the box you agree to our ",
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 13),
                                  children: [
                                    TextSpan(
                                      text: "Terms",
                                      style: TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(text: " and "),
                                    TextSpan(
                                      text: "Conditions.",
                                      style: TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),

                // Fixed bottom button
                Column(
                  children: [
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
                        onPressed: _isLoading ? null : _signupUser,
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : const Text(
                                "Signup",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already a member? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const LoginScreen()),
                            );
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
