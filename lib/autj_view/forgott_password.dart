import 'package:flutter/material.dart';
import 'package:journeyX/components/custom_text_field.dart';
import 'package:journeyX/utils/app_colors.dart';
import '../repository/auth_repo.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final AuthRepo _authRepo = AuthRepo();

  bool isLoading = false;

  void forgotPassword() async {
    if (emailController.text.isEmpty) {
      _showSnackBar('Email is required', Colors.red);
      return;
    }

    setState(() => isLoading = true);

    try {
      await _authRepo.forgotPassword(emailController.text.trim());

      _showSnackBar('Password reset link sent to your email', Colors.green);

      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } catch (e) {
      _showSnackBar(e.toString(), AppColors.green);
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message), backgroundColor: color));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forgot Password')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter your email to reset password',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            customTextField(
              hint: 'Email',
              icon: Icon(Icons.email),
              controller: emailController,
              readOnly: true,
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isLoading ? null : forgotPassword,
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Send Reset Link'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
