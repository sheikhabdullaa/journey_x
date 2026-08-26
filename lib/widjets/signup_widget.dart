import 'dart:async';

import 'package:flutter/material.dart';
import 'package:journey_x/autj_view/choose_role.dart';
import 'package:journey_x/components/custom_text_field.dart';
import 'package:journey_x/components/inter_text.dart';
import 'package:journey_x/repository/auth_repo.dart';
import 'package:journey_x/utils/app_colors.dart';

class SignupWidget extends StatefulWidget {
  const SignupWidget({super.key});

  @override
  State<SignupWidget> createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupWidget>
    with WidgetsBindingObserver {
  final AuthRepo _authRepo = AuthRepo();

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController numbercontroller = TextEditingController();

  bool loading = false;
  bool _obscureText = true;
  bool _waitingForVerification = false;
  bool _checkingVerification = false;
  Timer? _verificationTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _waitingForVerification) {
      _checkEmailVerification();
    }
  }

  void _startVerificationChecking() {
    _verificationTimer?.cancel();

    _verificationTimer = Timer.periodic(
      const Duration(seconds: 3),
      (_) => _checkEmailVerification(),
    );
  }

  Future<void> _checkEmailVerification() async {
    if (_checkingVerification || !_waitingForVerification || !mounted) {
      return;
    }

    _checkingVerification = true;

    try {
      final bool isVerified = await _authRepo.checkEmailVerification();

      if (!mounted || !isVerified) return;

      _waitingForVerification = false;
      _verificationTimer?.cancel();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email verified successfully')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ChooseRole()),
      );
    } finally {
      _checkingVerification = false;
    }
  }

  Future<void> _signup() async {
    final String name = namecontroller.text.trim();
    final String email = emailcontroller.text.trim();
    final String password = passwordcontroller.text.trim();
    final String phone = numbercontroller.text.trim();

    final RegExp phoneRegEx = RegExp(r'^\+?\d{10,15}$');

    if (name.isEmpty || email.isEmpty || password.isEmpty || phone.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('All fields are required')));
      return;
    }

    if (!phoneRegEx.hasMatch(phone)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a valid phone number')),
      );
      return;
    }

    if (_waitingForVerification) {
      setState(() => loading = true);

      final String? resendError = await _authRepo.resendVerificationEmail();

      if (!mounted) return;
      setState(() => loading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            resendError ??
                'Verification email sent again. Please check your Gmail.',
          ),
        ),
      );
      return;
    }

    setState(() => loading = true);

    final int phoneNumber = int.parse(phone.replaceAll(RegExp(r'\D'), ''));

    final String? error = await _authRepo.signup(
      email,
      password,
      name,
      phoneNumber,
    );

    if (!mounted) return;
    setState(() => loading = false);

    if (error != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error)));
      return;
    }

    _waitingForVerification = true;
    _startVerificationChecking();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(seconds: 5),
        content: Text('Verification link sent. Open Gmail and click the link.'),
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _verificationTimer?.cancel();
    emailcontroller.dispose();
    passwordcontroller.dispose();
    namecontroller.dispose();
    numbercontroller.dispose();
    super.dispose();
  }

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
                    readOnly: false,
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
                    readOnly: false,
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
                    readOnly: false,
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
                  onPressed: loading ? null : _signup,
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
