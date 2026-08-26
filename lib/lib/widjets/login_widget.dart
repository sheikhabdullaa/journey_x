import 'package:flutter/material.dart';
import 'package:journey_x/lib/autj_view/choose_role.dart';
import 'package:journey_x/lib/autj_view/forgott_password.dart';
import 'package:journey_x/lib/components/custom_text_field.dart';
import 'package:journey_x/lib/components/inter_text.dart';
import 'package:journey_x/lib/repository/auth_repo.dart';
import 'package:journey_x/lib/utils/app_colors.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  bool loading = false;
  bool _obscureText = true;

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
                    readOnly: true,
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
                        borderRadius: BorderRadius.circular(
                          12,
                        ), // Rounded corners
                        borderSide: BorderSide(
                          color: Color.fromARGB(67, 158, 158, 158),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.red, width: 1),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.red, width: 1),
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
                  onPressed: loading
                      ? null
                      : () async {
                          try {
                            await AuthRepo().login(
                              emailcontroller.text.trim(),
                              passwordcontroller.text.trim(),
                            );

                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("login Successful")),
                            );

                            Navigator.push(
                              // ignore: use_build_context_synchronously
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChooseRole(),
                              ),
                            );
                          } catch (e) {
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("login failed")),
                            );
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blueascent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: inter(
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
