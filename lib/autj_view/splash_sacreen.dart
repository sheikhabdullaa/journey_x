import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:journey_x/components/custom_text.dart';
import 'package:journey_x/utils/app_colors.dart';
import 'package:journey_x/widjets/login_sacreen/login_sacreen.dart';

class SplashSacreen extends StatefulWidget {
  const SplashSacreen({super.key});

  @override
  State<SplashSacreen> createState() => _SplashSacreenState();
}

class _SplashSacreenState extends State<SplashSacreen> {
  // ignore: annotate_overrides
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => LoginSacreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          // ignore: sized_box_for_whitespace
          Container(
            height: screenHeight * 1,
            width: screenWidth * 1,
            child: Stack(
              children: [
                // Image.asset(
                //   'assets/splash.png',
                //   height: screenHeight * 1,
                //   width: screenWidth * 1,
                //   fit: BoxFit.cover,
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Column(
                    children: [
                      // Image.asset('assets/polygon.png'),
                      customtext(
                        text: 'JourneyX',
                        fontSize: 36.39,
                        color: AppColors.black,
                        fw: FontWeight.w400,
                      ),
                      SizedBox(height: screenHeight * 0.4),
                      Column(
                        children: [
                          Text(
                            'Reach',
                            style: GoogleFonts.inter(
                              color: AppColors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 70,
                            ),
                          ),

                          Text(
                            'Your Peak',
                            style: GoogleFonts.inter(
                              color: AppColors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 50,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
