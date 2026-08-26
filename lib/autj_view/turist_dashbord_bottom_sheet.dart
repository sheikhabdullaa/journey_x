import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:journey_x/autj_view/creat_trip.dart';
import 'package:journey_x/autj_view/notification_page.dart';
import 'package:journey_x/autj_view/tourist_dashbord.dart';
import 'package:journey_x/autj_view/turist_profile.dart';
import 'package:journey_x/utils/app_colors.dart';

class TuristDashbordBottomSheet extends StatefulWidget {
  const TuristDashbordBottomSheet({super.key});

  @override
  State<TuristDashbordBottomSheet> createState() =>
      _TuristDashbordBottomSheetState();
}

class _TuristDashbordBottomSheetState extends State<TuristDashbordBottomSheet> {
  final PageController _pageController = PageController(initialPage: 0);

  final NotchBottomBarController _controller = NotchBottomBarController(
    index: 0,
  );

  final List<Widget> _pages = const [
    TouristDashbord(),
    // ChatBort(),
    CreatTrip(),
    TuristProfile(),
    NotificationPage(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        // App close karega
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        extendBody: true,
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: _pages,
        ),
        bottomNavigationBar: AnimatedNotchBottomBar(
          notchBottomBarController: _controller,
          color: AppColors.deepblue,
          notchColor: AppColors.deepblue,
          showLabel: true,
          itemLabelStyle: const TextStyle(fontSize: 10),
          maxLine: 1,
          kBottomRadius: 20,
          durationInMilliSeconds: 300,
          bottomBarWidth: MediaQuery.of(context).size.width,
          showShadow: true,
          shadowElevation: 10,
          kIconSize: 28.0,
          bottomBarItems: [
            BottomBarItem(
              inActiveItem: Icon(Icons.home_outlined, color: AppColors.grey),
              activeItem: const Icon(Icons.home, color: Colors.black),
              itemLabel: 'Home',
            ),
            // BottomBarItem(
            //   inActiveItem: Icon(Icons.smart_toy, color: AppColors.grey),
            //   activeItem: const Icon(Icons.smart_toy, color: Colors.black),
            //   itemLabel: 'Chat Bot',
            // ),
            BottomBarItem(
              inActiveItem: Icon(Icons.add, color: AppColors.grey),
              activeItem: const Icon(Icons.add, color: Colors.black),
              itemLabel: '',
            ),
            BottomBarItem(
              inActiveItem: Icon(Icons.person_outline, color: AppColors.grey),
              activeItem: const Icon(Icons.person, color: Colors.black),
              itemLabel: 'Profile',
            ),
            BottomBarItem(
              inActiveItem: Icon(
                Icons.notifications_outlined,
                color: AppColors.grey,
              ),
              activeItem: const Icon(Icons.notifications, color: Colors.black),
              itemLabel: 'Notifications',
            ),
          ],
          onTap: (index) {
            _pageController.jumpToPage(index);
          },
        ),
      ),
    );
  }
}
