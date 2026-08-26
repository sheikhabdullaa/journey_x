import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:journeyX/autj_view/traveller_bottom_sheet.dart';
import 'package:journeyX/autj_view/turist_dashbord_bottom_sheet.dart';
import 'package:journeyX/components/custom_text.dart';
import 'package:journeyX/components/homenaje.dart';
import 'package:journeyX/components/inter_text.dart';
import 'package:journeyX/components/popin_text.dart';
import 'package:journeyX/utils/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChooseRole extends StatefulWidget {
  const ChooseRole({super.key});

  @override
  State<ChooseRole> createState() => _ChooseRoleState();
}

class _ChooseRoleState extends State<ChooseRole> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    redirectIfRoleExists();
  }

  /// Check SharedPreferences first, then Firestore.
  Future<void> redirectIfRoleExists() async {
    final User? user = _auth.currentUser;
    if (user == null) return;

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? savedRole = prefs.getString('userRole_${user.uid}');

      if (savedRole != 'traveller' && savedRole != 'guide') {
        final DocumentSnapshot<Map<String, dynamic>> userDocument =
            await _firestore.collection('signupuser').doc(user.uid).get();

        final dynamic firestoreRole = userDocument.data()?['role'];

        if (firestoreRole == 'traveller' || firestoreRole == 'guide') {
          savedRole = firestoreRole as String;
          await prefs.setString('userRole_${user.uid}', savedRole);
        }
      }

      if (!mounted) return;

      if (savedRole == 'traveller' || savedRole == 'guide') {
        _openDashboard(savedRole!);
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Unable to load saved role: $e')));
    }
  }

  /// Save role for the current Firebase user and navigate.
  Future<void> selectRole(String role) async {
    if (isLoading) return;

    setState(() => isLoading = true);

    try {
      User? user = _auth.currentUser;

      if (user == null) {
        if (!mounted) return;

        setState(() => isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Your session has expired. Please login again.'),
          ),
        );
        return;
      }

      await user.reload();
      user = _auth.currentUser;

      if (user == null) {
        if (!mounted) return;

        setState(() => isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Your session has expired. Please login again.'),
          ),
        );
        return;
      }

      if (!user.emailVerified) {
        if (!mounted) return;

        setState(() => isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please verify your email before selecting a role.'),
          ),
        );
        return;
      }

      // AuthRepo also stores signup data in signupuser/{uid}.
      await _firestore.collection('signupuser').doc(user.uid).set({
        'uid': user.uid,
        'email': user.email,
        'role': role,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userRole_${user.uid}', role);

      if (!mounted) return;
      _openDashboard(role);
    } on FirebaseException catch (e) {
      if (!mounted) return;

      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Unable to save your role.')),
      );
    } catch (e) {
      if (!mounted) return;

      setState(() => isLoading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Something went wrong: $e')));
    }
  }

  void _openDashboard(String role) {
    if (!mounted) return;

    if (role == 'traveller') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const TravellerBottomSheet()),
      );
    } else if (role == 'guide') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const TuristDashbordBottomSheet()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 40),

                /// LOGO
                Image.asset('assets/polygon.png', height: 90),
                const SizedBox(height: 12),

                homenage(
                  text: 'Travel Mate',
                  fontSize: 48,
                  color: AppColors.black,
                  fw: FontWeight.w400,
                ),

                const SizedBox(height: 24),

                customtext(
                  text: 'Choose Your Account Type',
                  fontSize: 16,
                  color: AppColors.black,
                  fw: FontWeight.w600,
                ),

                const SizedBox(height: 6),

                popintext(
                  text: 'Select how you want to experience Travel Mate',
                  fontSize: 12,
                  color: AppColors.grey,
                  fw: FontWeight.w300,
                ),

                const SizedBox(height: 40),

                /// ROLE CARDS
                Row(
                  children: [
                    /// TRAVELLER
                    Expanded(
                      child: InkWell(
                        onTap: isLoading ? null : () => selectRole('traveller'),
                        child: roleCard(
                          image: 'assets/man.png',
                          title: 'Traveler',
                          desc1: 'Explore amazing',
                          desc2: 'destinations and book',
                          desc3: 'unique experiences',
                          screenHeight: screenHeight,
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    /// GUIDE
                    Expanded(
                      child: InkWell(
                        onTap: isLoading ? null : () => selectRole('guide'),
                        child: roleCard(
                          image: 'assets/travelguider.png',
                          title: 'Guide',
                          desc1: 'Share your expertise,',
                          desc2: 'showcase your city,',
                          desc3: 'and lead tours',
                          screenHeight: screenHeight,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: screenHeight * 0.15),
              ],
            ),
          ),

          /// LOADING OVERLAY
          if (isLoading)
            Container(
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.2),
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}

/// Role Card Widget
Widget roleCard({
  required String image,
  required String title,
  required String desc1,
  required String desc2,
  required String desc3,
  required double screenHeight,
}) {
  return Card(
    color: AppColors.white,
    elevation: 3,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
      child: Column(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.blueascent,
              image: DecorationImage(image: AssetImage(image)),
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          homenage(
            text: title,
            fontSize: 28,
            color: AppColors.black,
            fw: FontWeight.w500,
          ),
          SizedBox(height: screenHeight * 0.03),
          inter(text: desc1, fontSize: 10, color: AppColors.grey),
          inter(text: desc2, fontSize: 10, color: AppColors.grey),
          inter(text: desc3, fontSize: 10, color: AppColors.grey),
        ],
      ),
    ),
  );
}
