// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:pm_internship/screens/home_page.dart';
// import 'package:pm_internship/screens/signup_page.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();

//   bool _rememberMe = false;
//   bool _isLoading = false;

//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   Future<void> _loginUser() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         _isLoading = true;
//       });

//       try {
//         await _auth.signInWithEmailAndPassword(
//           email: _emailController.text.trim(),
//           password: _passwordController.text.trim(),
//         );

//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Login Successful ✅")),
//         );

//         // Navigate to Home/Dashboard after login
//         Navigator.pushReplacement(
//             context, MaterialPageRoute(builder: (_) => HomePage()));
//       } on FirebaseAuthException catch (e) {
//         String errorMessage = "Login failed ❌";

//         if (e.code == 'user-not-found') {
//           errorMessage = "No user found with this email";
//         } else if (e.code == 'wrong-password') {
//           errorMessage = "Incorrect password";
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
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: SingleChildScrollView(
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 20),

//                   // Illustration Image
//                   Center(
//                     child: Image.asset(
//                       "assets/images/login_page_img.png", // Add your asset
//                       height: 200,
//                     ),
//                   ),
//                   const SizedBox(height: 20),

//                   // Welcome Text
//                   const Text(
//                     "Welcome back",
//                     style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 8),
//                   const Text(
//                     "Continue exploring tailored PM internship recommendations.",
//                     style: TextStyle(fontSize: 14, color: Colors.grey),
//                   ),
//                   const SizedBox(height: 30),

//                   // Email Field
//                   TextFormField(
//                     controller: _emailController,
//                     decoration: const InputDecoration(
//                       hintText: "Enter your email",
//                       prefixIcon: Icon(Icons.email_outlined),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(10)),
//                       ),
//                     ),
//                     keyboardType: TextInputType.emailAddress,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return "Enter your email";
//                       }
//                       if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
//                         return "Enter a valid email";
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 16),

//                   // Password Field
//                   TextFormField(
//                     controller: _passwordController,
//                     obscureText: true,
//                     decoration: const InputDecoration(
//                       hintText: "Password",
//                       prefixIcon: Icon(Icons.lock_outline),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(10)),
//                       ),
//                     ),
//                     validator: (value) => value == null || value.isEmpty
//                         ? "Enter your password"
//                         : null,
//                   ),
//                   const SizedBox(height: 10),

//                   // Remember Me + Forget Password
//                   // Row(
//                   //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   //   children: [
//                   //     // Row(
//                   //     //   children: [
//                   //     //     Checkbox(
//                   //     //       value: _rememberMe,
//                   //     //       onChanged: (value) {
//                   //     //         setState(() {
//                   //     //           _rememberMe = value ?? false;
//                   //     //         });
//                   //     //       },
//                   //     //     ),
//                   //     //     const Text("Remember me"),
//                   //     //   ],
//                   //     // ),
//                   //     // TextButton(
//                   //     //   onPressed: () {
//                   //     //     // TODO: Implement password reset
//                   //     //   },
//                   //     //   child: const Text(
//                   //     //     "Forget password ?",
//                   //     //     style: TextStyle(color: const Color(0xFFFF7600)),
//                   //     //   ),
//                   //     // ),
//                   //   ],
//                   // ),
//                   const SizedBox(height: 90),

//                   // Login Button
//                   SizedBox(
//                     width: double.infinity,
//                     height: 50,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFFFF7600),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       onPressed: _isLoading ? null : _loginUser,
//                       child: _isLoading
//                           ? const CircularProgressIndicator(color: Colors.white)
//                           : const Text(
//                               "Login",
//                               style:
//                                   TextStyle(fontSize: 16, color: Colors.white),
//                             ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),

//                   // New member
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text("New Member? "),
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (_) => const SignupScreen()),
//                           );
//                         },
//                         child: const Text(
//                           "Register now",
//                           style: TextStyle(
//                             color: const Color(0xFFFF7600),
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pm_internship/screens/home_page.dart';
import 'package:pm_internship/screens/personal_details_page.dart';
import 'package:pm_internship/screens/signup_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _rememberMe = false;
  bool _isLoading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _loginUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        await _auth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login Successful ✅")),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomePage()),
        );
      } on FirebaseAuthException catch (e) {
        String errorMessage = "Login failed ❌";

        if (e.code == 'user-not-found') {
          errorMessage = "No user found with this email";
        } else if (e.code == 'wrong-password') {
          errorMessage = "Incorrect password";
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
                        const SizedBox(height: 20),

                        // Illustration Image
                        Center(
                          child: Image.asset(
                            "assets/images/login_page_img.png",
                            height: 200,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Welcome Text
                        const Text(
                          "Welcome back",
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Continue exploring tailored PM internship recommendations.",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        const SizedBox(height: 30),

                        // Email Field
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            hintText: "Enter your email",
                            prefixIcon: Icon(Icons.email_outlined),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
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

                        // Password Field
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
                          validator: (value) => value == null || value.isEmpty
                              ? "Enter your password"
                              : null,
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),

                // Fixed bottom section
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
                        onPressed: _isLoading ? null : _loginUser,
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // New member
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("New Member? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const SignupScreen()),
                            );
                          },
                          child: const Text(
                            "Register now",
                            style: TextStyle(
                              color: const Color(0xFFFF7600),
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
