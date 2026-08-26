import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:journey_x/lib/classes/sarah_model_class.dart';
import 'package:journey_x/lib/components/popin_text.dart';
import 'package:journey_x/lib/utils/app_colors.dart';

class SarahEditProfile extends StatefulWidget {
  final String uid;
  final String name;
  final String email;
  final String phoneNumber;

  const SarahEditProfile({
    super.key,
    required this.uid,
    required this.name,
    required this.email,
    required this.phoneNumber, required AppUser user,
  });

  @override
  State<SarahEditProfile> createState() => _SarahEditProfileState();
}

class _SarahEditProfileState extends State<SarahEditProfile> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController currentPasswordController;
  late TextEditingController newPasswordController;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    emailController = TextEditingController(text: widget.email);
    phoneController = TextEditingController(text: widget.phoneNumber);
    currentPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    currentPasswordController.dispose();
    newPasswordController.dispose();
    super.dispose();
  }

  // Re-authenticate the user
  Future<void> _reAuthenticate() async {
    final user = FirebaseAuth.instance.currentUser!;
    final password = currentPasswordController.text.trim();
    if (password.isEmpty) {
      throw Exception("Please enter current password");
    }
    final credential = EmailAuthProvider.credential(
      email: user.email!,
      password: password,
    );
    await user.reauthenticateWithCredential(credential);
  }

  // Save Profile
  Future<void> saveProfile() async {
    try {
      setState(() => isLoading = true);

      final user = FirebaseAuth.instance.currentUser!;
      final newEmail = emailController.text.trim();
      final newPassword = newPasswordController.text.trim();

      // If email or password changed, re-authenticate
      if (newEmail != user.email || newPassword.isNotEmpty) {
        await _reAuthenticate();
      }

      // Update email if changed
      // if (newEmail != user.email) {
      //   await user.updateEmail(newEmail);
      // }

      // Update password if entered
      if (newPassword.isNotEmpty) {
        await user.updatePassword(newPassword);
      }

      // Update Firestore user document
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .update({
            'name': nameController.text.trim(),
            'email': newEmail,
            'phoneNumber': phoneController.text.trim(),
          });

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );

      // ignore: use_build_context_synchronously
      Navigator.pop(context); // go back after saving
    } on FirebaseAuthException catch (e) {
      // Firebase auth errors
      ScaffoldMessenger.of(
        // ignore: use_build_context_synchronously
        context,
      ).showSnackBar(SnackBar(content: Text(e.message ?? "Auth error")));
    } catch (e) {
      ScaffoldMessenger.of(
        // ignore: use_build_context_synchronously
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() => isLoading = false);
    }
  }

  Widget _buildField(
    String label,
    TextEditingController controller, {
    bool obscure = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          popintext(text: label, fontSize: 14, color: Colors.grey),
          const SizedBox(height: 6),
          TextField(
            controller: controller,
            obscureText: obscure,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: popintext(
          text: 'Edit Profile',
          fontSize: 16,
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            popintext(
              text: 'Personal Information',
              fontSize: 20,
              fw: FontWeight.w600,
              color: Colors.black,
            ),
            const SizedBox(height: 20),

            _buildField('Full Name', nameController),
            _buildField('Email', emailController),
            _buildField('Phone Number', phoneController),
            _buildField(
              'Current Password',
              currentPasswordController,
              obscure: true,
            ),
            _buildField('New Password', newPasswordController, obscure: true),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blueascent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: isLoading ? null : saveProfile,
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Save Changes',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
