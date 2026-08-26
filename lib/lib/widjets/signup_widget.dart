import 'package:flutter/material.dart';
import 'package:journey_x/lib/autj_view/choose_role.dart';
import 'package:journey_x/lib/components/custom_text_field.dart';
import 'package:journey_x/lib/components/inter_text.dart';
import 'package:journey_x/lib/repository/auth_repo.dart';
import 'package:journey_x/lib/utils/app_colors.dart';

class SignupWidget extends StatefulWidget {
  const SignupWidget({super.key});

  @override
  State<SignupWidget> createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupWidget> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController numbercontroller = TextEditingController();

  bool loading = false;
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  inter(
                    text: 'Full Name',
                    decorationColor: AppColors.grey,
                    fontSize: 14,
                    color: AppColors.black,
                    fw: FontWeight.w400,
                  ),
                  customTextField(
                    hint: 'Enter your name',
                    icon: Icon(Icons.person_2_outlined, color: AppColors.grey),
                    controller: namecontroller,
                    readOnly: true,
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  inter(
                    text: 'Email Address',
                    decorationColor: AppColors.grey,
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
              const SizedBox(height: 20),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  inter(
                    text: 'Phone Number',
                    decorationColor: AppColors.grey,
                    fontSize: 14,
                    color: AppColors.black,
                    fw: FontWeight.w400,
                  ),
                  customTextField(
                    hint: '+123 456 7890',
                    icon: Icon(Icons.call_outlined, color: AppColors.grey),
                    controller: numbercontroller,
                    readOnly: true,
                  ),
                ],
              ),
              const SizedBox(height: 20),

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
              const SizedBox(height: 30),

              SizedBox(
                height: 48,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: loading
                      ? null
                      : () async {
                          String name = namecontroller.text.trim();
                          String email = emailcontroller.text.trim();
                          String password = passwordcontroller.text.trim();
                          String phone = numbercontroller.text.trim();

                          // Phone number validation
                          RegExp phoneRegEx = RegExp(r'^\+?\d{10,15}$');
                          // Explanation:
                          // ^ = start, \+? = optional plus, \d{10,15} = 10 to 15 digits, $ = end

                          if (name.isEmpty ||
                              email.isEmpty ||
                              password.isEmpty ||
                              phone.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("All fields are required"),
                              ),
                            );
                            return;
                          }

                          if (!phoneRegEx.hasMatch(phone)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Enter a valid phone number"),
                              ),
                            );
                            return;
                          }

                          try {
                            setState(() {
                              loading = true;
                            });

                            await AuthRepo().signup(
                              email,
                              password,
                              name,
                              int.parse(
                                phone.replaceAll(RegExp(r'\D'), ''),
                              ), // remove non-digit
                            );

                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Signup Successful"),
                              ),
                            );

                            // ignore: use_build_context_synchronously
                            Navigator.push(
                              // ignore: use_build_context_synchronously
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ChooseRole(),
                              ),
                            );
                          } catch (e) {
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Signup failed: $e")),
                            );
                          } finally {
                            setState(() {
                              loading = false;
                            });
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blueascent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: loading
                      ? const CircularProgressIndicator()
                      : inter(
                          text: 'Signup',
                          fontSize: 16,
                          color: AppColors.white,
                          fw: FontWeight.w500,
                        ),
                ),
              ),

              // SizedBox(
              //   width: double.infinity,
              //   height: 48,
              //   child: ElevatedButton(
              //     onPressed: loading
              //         ? null
              //         : () async {
              //             try {
              //               await AuthRepo().signup(
              //                 emailcontroller.text.trim(),
              //                 passwordcontroller.text.trim(),
              //                 namecontroller.text.trim(),
              //                 int.parse(numbercontroller.text.trim()),
              //               );

              //               // ignore: use_build_context_synchronously
              //               ScaffoldMessenger.of(context).showSnackBar(
              //                 const SnackBar(
              //                   content: Text("Signup Successful"),
              //                 ),
              //               );

              //               Navigator.push(
              //                 // ignore: use_build_context_synchronously
              //                 context,
              //                 MaterialPageRoute(
              //                   builder: (context) => ChooseRole(),
              //                 ),
              //               );
              //             } catch (e) {
              //               // ignore: use_build_context_synchronously
              //               ScaffoldMessenger.of(context).showSnackBar(
              //                 SnackBar(content: Text("signout failed")),
              //               );
              //             }
              //           },
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: AppColors.blueascent,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(14),
              //       ),
              //     ),
              //     child: loading
              //         ? const CircularProgressIndicator()
              //         : inter(
              //             text: 'Signup',
              //             fontSize: 16,
              //             color: AppColors.white,
              //             fw: FontWeight.w500,
              //           ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
