import 'package:flutter/material.dart';
import 'package:journeyX/autj_view/sarah_edit_profile.dart';
import 'package:journeyX/autj_view/traveller_bottom_sheet.dart';
import 'package:journeyX/classes/edit_profile.dart';
import 'package:journeyX/components/inter_text.dart';
import 'package:journeyX/components/popin_text.dart';
import 'package:journeyX/repository/auth_repo.dart';
import 'package:journeyX/utils/app_colors.dart';
import 'package:journeyX/widjets/login_sacreen/login_sacreen.dart';

class TuristProfile extends StatefulWidget {
  const TuristProfile({super.key});

  @override
  State<TuristProfile> createState() => _TuristProfilePageState();
}

class _TuristProfilePageState extends State<TuristProfile> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TravellerBottomSheet(),
                                ),
                              );
                            },
                            icon: Icon(Icons.arrow_back),
                          ),
                          SizedBox(width: screenwidth * 0.3),
                          popintext(
                            text: 'Profile',
                            fontSize: 16,
                            color: AppColors.black,
                            fw: FontWeight.w600,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: ClipOval(child: Image.asset('assets/sarah.png')),
                      ),
                      popintext(
                        text: 'Sarah Smith',
                        fontSize: 16,
                        color: AppColors.black,
                        fw: FontWeight.w600,
                      ),
                      inter(
                        text: 'sarah.smith@gmail.com',
                        fontSize: 14,
                        color: AppColors.black,
                        fw: FontWeight.w400,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SarahEditProfile(
                                uid: '',
                                name: '',
                                email: '',
                                phoneNumber: '',
                                user: appUser,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(196, 58),
                          backgroundColor: AppColors.white,
                          foregroundColor: AppColors.blueascent,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                            side: const BorderSide(
                              color: Colors.blue,
                              width: 2,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.edit_outlined,
                                color: AppColors.blueascent,
                                size: 25,
                              ),
                            ),
                            inter(
                              text: 'Edit Profile',
                              fontSize: 15,
                              color: AppColors.blueascent,
                              fw: FontWeight.w400,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.08),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                popintext(
                                  text: '12',
                                  fontSize: 24,
                                  color: AppColors.blueascent,
                                  fw: FontWeight.w700,
                                ),
                                inter(
                                  text: 'Past Trips ',
                                  fontSize: 14,
                                  color: AppColors.grey,
                                  fw: FontWeight.w400,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                popintext(
                                  text: '3',
                                  fontSize: 24,
                                  color: AppColors.blueascent,
                                  fw: FontWeight.w700,
                                ),
                                inter(
                                  text: ' Active Trips',
                                  fontSize: 14,
                                  color: AppColors.grey,

                                  fw: FontWeight.w400,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                popintext(
                                  text: '18',
                                  fontSize: 24,
                                  color: AppColors.blueascent,
                                  fw: FontWeight.w700,
                                ),
                                inter(
                                  text: ' Countries',
                                  fontSize: 14,
                                  color: AppColors.grey,

                                  fw: FontWeight.w400,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),

              TextButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => TuristViewHistory()),
                  // );
                },
                child: inter(
                  text: 'View History',
                  fontSize: 18,
                  color: AppColors.blueascent,
                  fw: FontWeight.w400,
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.settings),
                      title: inter(
                        text: 'Account Setting',
                        fontSize: 14,
                        color: AppColors.black,
                        fw: FontWeight.w400,
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.help_outline),
                      title: inter(
                        text: 'Help & Supprt',
                        fontSize: 14,
                        color: AppColors.black,
                        fw: FontWeight.w400,
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.privacy_tip_outlined),
                      title: inter(
                        text: 'Privacy Policy',
                        fontSize: 14,
                        color: AppColors.black,
                        fw: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.05),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  // backgroundColor: AppColors.white,
                  fixedSize: Size(screenwidth * 0.4, 25),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () async {
                  await AuthRepo().logout();

                  Navigator.pushAndRemoveUntil(
                    // ignore: use_build_context_synchronously
                    context,
                    MaterialPageRoute(builder: (_) => const LoginSacreen()),
                    (route) => false,
                  );
                },
                child: const Text(
                  "Logout",
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.red,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.06),
              inter(
                text: 'JourneyX v1.0key.0',
                fontSize: 14,
                color: const Color.fromARGB(103, 0, 0, 0),
                fw: FontWeight.w400,
              ),
              Container(height: screenHeight * 0.08),
            ],
          ),
        ),
      ),
    );
  }
}
