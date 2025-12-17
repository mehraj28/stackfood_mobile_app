// import 'package:flutter/material.dart';
// import '../services/api_service.dart';
// import '../services/token_service.dart';
// import 'foods_screen.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   bool isLoading = false;

//   Future<void> handleLogin() async {
//     if (emailController.text.trim().isEmpty ||
//         passwordController.text.trim().isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Email & password required")),
//       );
//       return;
//     }

//     setState(() => isLoading = true);

//     // ✅ FIXED: use NAMED PARAMETERS
//     final token = await ApiService.userLogin(
//       email: emailController.text.trim(),
//       password: passwordController.text.trim(),
//     );

//     setState(() => isLoading = false);

//     if (token != null) {
//       await TokenService.saveToken(token);

//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => const FoodsScreen()),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Invalid credentials")),
//       );
//     }
//   }

//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(24),
//           child: Center(
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text(
//                     "StackFood",
//                     style: TextStyle(
//                       fontSize: 32,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.orange,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   const Text(
//                     "Login",
//                     style: TextStyle(fontSize: 18),
//                   ),
//                   const SizedBox(height: 32),

//                   // EMAIL
//                   TextField(
//                     controller: emailController,
//                     keyboardType: TextInputType.emailAddress,
//                     decoration: InputDecoration(
//                       labelText: "Email",
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 16),

//                   // PASSWORD
//                   TextField(
//                     controller: passwordController,
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       labelText: "Password",
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 24),

//                   // LOGIN BUTTON
//                   SizedBox(
//                     width: double.infinity,
//                     height: 50,
//                     child: ElevatedButton(
//                       onPressed: isLoading ? null : handleLogin,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.orange,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       child: isLoading
//                           ? const SizedBox(
//                               width: 22,
//                               height: 22,
//                               child: CircularProgressIndicator(
//                                 strokeWidth: 2.5,
//                                 color: Colors.white,
//                               ),
//                             )
//                           : const Text(
//                               "Login",
//                               style: TextStyle(fontSize: 16),
//                             ),
//                     ),
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
import '../services/api_service.dart';
import '../services/token_service.dart';
import 'foods_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool rememberMe = false;
  bool isLoading = false;
  bool obscurePassword = true;

  Future<void> _login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email & password required")),
      );
      return;
    }

    setState(() => isLoading = true);

    final token = await ApiService.userLogin(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    setState(() => isLoading = false);

    if (token != null) {
      await TokenService.saveToken(token);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const FoodsScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid login credentials")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ================= BACK =================
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
              ),

              const SizedBox(height: 10),

              // ================= LOGO =================
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      "assets/logo.png", // ✅ your logo
                      height: 70,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // ================= EMAIL =================
              const Text("Email or Phone"),
              const SizedBox(height: 6),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email_outlined),
                  hintText: "Enter email or phone",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Colors.orange),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // ================= PASSWORD =================
              const Text("Password *"),
              const SizedBox(height: 6),
              TextField(
                controller: passwordController,
                obscureText: obscurePassword,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock_outline),
                  hintText: "Password",
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscurePassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // ================= REMEMBER + FORGOT =================
              Row(
                children: [
                  Checkbox(
                    value: rememberMe,
                    activeColor: Colors.orange,
                    onChanged: (v) {
                      setState(() => rememberMe = v ?? false);
                    },
                  ),
                  const Text("Remember me"),
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(color: Colors.orange),
                    ),
                  )
                ],
              ),

              const SizedBox(height: 10),

              // ================= TERMS =================
              const Text(
                "* I agree with all the Terms & Conditions",
                style: TextStyle(fontSize: 12),
              ),

              const SizedBox(height: 24),

              // ================= LOGIN BUTTON =================
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 30),

              // ================= SIGNUP / OTP =================
              Center(
                child: Column(
                  children: const [
                    Text("Don't have account? Sign Up"),
                    SizedBox(height: 8),
                    Text("or"),
                    SizedBox(height: 8),
                    Text(
                      "Sign in with OTP",
                      style: TextStyle(color: Colors.orange),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // ================= GOOGLE =================
              Center(
                child: CircleAvatar(
                  radius: 26,
                  backgroundColor: Colors.white,
                  child: Image.asset(
                    "assets/google.png",
                    height: 26,
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
