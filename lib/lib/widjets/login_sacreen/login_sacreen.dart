import 'package:flutter/material.dart';
import 'package:journey_x/lib/components/homenaje.dart';
import 'package:journey_x/lib/components/popin_text.dart';
import 'package:journey_x/lib/utils/app_colors.dart';
import 'package:journey_x/lib/widjets/login_widget.dart';
import 'package:journey_x/lib/widjets/signup_widget.dart';

class LoginSacreen extends StatefulWidget {
  const LoginSacreen({super.key});

  @override
  State<LoginSacreen> createState() => _LoginSacreenState();
}

class _LoginSacreenState extends State<LoginSacreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          /// LOGO
          Image.asset('assets/polygon.png', height: screenHeight * 0.10),

          SizedBox(height: screenHeight * 0.02),

          /// APP NAME
          homenage(
            text: 'Travel Mate',
            fontSize: 52,
            color: AppColors.black,
            fw: FontWeight.w400,
          ),

          SizedBox(height: screenHeight * 0.015),

          /// TABS
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: TabBar(
              controller: controller,
              indicatorColor: AppColors.blueascent,
              dividerColor: Colors.transparent,
              tabs: [
                Tab(
                  child: popintext(
                    text: 'Login',
                    fontSize: 16,
                    color: AppColors.black,
                    fw: FontWeight.w600,
                  ),
                ),
                Tab(
                  child: popintext(
                    text: 'Sign Up',
                    fontSize: 16,
                    color: AppColors.black,
                    fw: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          /// TAB CONTENT
          Expanded(
            child: TabBarView(
              controller: controller,
              children: [
                LoginWidget(),
                SignupWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
