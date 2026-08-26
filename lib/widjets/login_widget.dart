import 'package:flutter/material.dart';
import 'package:journey_x/autj_view/choose_role.dart';
import 'package:journey_x/autj_view/forgott_password.dart';
import 'package:journey_x/components/custom_text_field.dart';
import 'package:journey_x/components/inter_text.dart';
import 'package:journey_x/repository/auth_repo.dart';
import 'package:journey_x/utils/app_colors.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final AuthRepo _authRepo = AuthRepo();

  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();

  bool loading = false;
  bool _obscureText = true;

  Future<void> _login() async {
    final String email = emailcontroller.text.trim();
    final String password = passwordcontroller.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email and password are required')),
      );
      return;
    }

    setState(() => loading = true);

    String? error;

    try {
      error = await _authRepo.login(email, password);
    } catch (_) {
      error = 'Login failed. Please try again.';
    }

    if (!mounted) return;
    setState(() => loading = false);

    if (error != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error)));
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Login Successful')));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const ChooseRole()),
    );
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            children: [
              // Email field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  inter(
                    text: 'Email Address',
                    fontSize: 14,
                    color: AppColors.black,
                    fw: FontWeight.w400,
                  ),
                  customTextField(
                    hint: 'for-example@example.com',
                    icon: Icon(Icons.email_outlined, color: AppColors.grey),
                    controller: emailcontroller,
                    readOnly: false,
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Password field with show/hide toggle
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  inter(
                    text: 'Password',
                    decorationColor: AppColors.grey,
                    fontSize: 14,
                    color: AppColors.black,
                    fw: FontWeight.w400,
                  ),
                  TextFormField(
                    controller: passwordcontroller,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      hintText: 'Enter your password',
                      hintStyle: TextStyle(color: AppColors.grey),
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: AppColors.grey,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: AppColors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 16,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(67, 158, 158, 158),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Forgot password
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgotPasswordScreen(),
                        ),
                      );
                    },
                    child: inter(
                      text: 'Forgot Password?',
                      fontSize: 12,
                      color: AppColors.grey,
                      fw: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Login button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: loading ? null : _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blueascent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: loading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : inter(
                          text: 'Login',
                          fontSize: 16,
                          color: AppColors.white,
                          fw: FontWeight.w500,
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
