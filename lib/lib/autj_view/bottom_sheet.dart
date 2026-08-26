import 'package:flutter/material.dart';
import 'package:journey_x/lib/autj_view/guider_dashboard.dart';
import 'package:journey_x/lib/autj_view/michal_turist_profile.dart';
import 'package:journey_x/lib/autj_view/notification_page.dart';
import 'package:journey_x/lib/components/custom_text.dart';
import 'package:journey_x/lib/utils/app_colors.dart';

// ignore: camel_case_types
class guideBottomSheet extends StatefulWidget {
  const guideBottomSheet({super.key});

  @override
  State<guideBottomSheet> createState() => _guidebottomsheetState();
}

// ignore: camel_case_types
class _guidebottomsheetState extends State<guideBottomSheet> {
  final List _pages = [
    GuiderDashboard(),
    // ChatBort(),
    MichalTuristProfile(),
    NotificationPage(),
  ];
  int currentIndex = 0;
  @override
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[currentIndex],
      bottomNavigationBar: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  currentIndex = 0;
                });
              },
              child: Column(
                children: [
                  // Image.asset('assets/homeicon.png', color: AppColors.grey),
                   Icon(Icons.home_outlined, color: AppColors.grey),
                  customtext(
                    text: 'Home',
                    fontSize: 12,
                    color: AppColors.black,
                    fw: FontWeight.w400,
                  ),
                ],
              ),
            ),
            // InkWell(
            //   onTap: () {
            //     setState(() {
            //       currentIndex = 1;
            //     });
            //   },
            //   child: Column(
            //     children: [
            //       // Image.asset('assets/chat.png', color: AppColors.grey),
            //         Icon(Icons.smart_toy, color: AppColors.grey),

            //       customtext(
            //         text: 'Chat Bot',
            //         fontSize: 12,
            //         color: AppColors.black,
            //         fw: FontWeight.w400,
            //       ),
            //     ],
            //   ),
            // ),

            InkWell(
              onTap: () {
                setState(() {
                  currentIndex = 1;
                });
              },
              child: Column(
                children: [
                  // Image.asset('assets/personicon.png', color: AppColors.grey),
                    Icon(Icons.person_outline, color: AppColors.grey),

                  customtext(
                    text: 'Profile',
                    fontSize: 12,
                    color: AppColors.black,
                    fw: FontWeight.w400,
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  currentIndex = 2;
                });
              },
              child: Column(
                children: [
                  // Image.asset('assets/messegeicon.png', color: AppColors.grey),
                    Icon(Icons.message, color: AppColors.grey),

                  customtext(
                    text: 'Chats',
                    fontSize: 12,
                    color: AppColors.black,
                    fw: FontWeight.w400,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
