import 'package:flutter/material.dart';
import 'package:journey_x/lib/components/inter_text.dart';
import 'package:journey_x/lib/components/popin_text.dart';
import 'package:journey_x/lib/utils/app_colors.dart';

class MichalTuristProfile extends StatefulWidget {
  const MichalTuristProfile({super.key});

  @override
  State<MichalTuristProfile> createState() => _MichalTuristProfilePageState();
}

class _MichalTuristProfilePageState extends State<MichalTuristProfile> {
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
                            onPressed: () {},
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
                      Container(
                        width: screenwidth * 0.2,
                        height: screenHeight * 0.2,
                        decoration: BoxDecoration(
                          // color: AppColors.black,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/michal.png'),
                          ),
                        ),
                      ),
                      popintext(
                        text: 'Michal',
                        fontSize: 16,
                        color: AppColors.black,
                        fw: FontWeight.w600,
                      ),
                      inter(
                        text: 'michal.1234@gmail.com',
                        fontSize: 14,
                        color: AppColors.black,
                        fw: FontWeight.w400,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      ElevatedButton(
                        onPressed: () {},
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
                onPressed: () {},
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
              TextButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.rotate(
                      angle: 3.1416,
                      child: Icon(Icons.logout, color: Colors.red, size: 26),
                    ),
                    inter(
                      text: 'Logout',
                      fontSize: 18,
                      color: AppColors.red,
                      fw: FontWeight.w500,
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.06),
              inter(
                text: 'TravelMate Hub v1.0.0',
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
