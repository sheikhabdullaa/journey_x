import 'package:flutter/material.dart';
import 'package:journey_x/lib/components/inter_text.dart';
import 'package:journey_x/lib/components/popin_text.dart';
import 'package:journey_x/lib/utils/app_colors.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        titleSpacing: screenWidth * 0.2,
        title: popintext(
          text: 'Notifications',
          fontSize: 16,
          color: AppColors.black,
          fw: FontWeight.w600,
        ),
        actions: const [Icon(Icons.more_vert_outlined)],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.022),

            Center(
              child: inter(
                text: 'Today',
                fontSize: 16,
                color: AppColors.grey,
                fw: FontWeight.w600,
              ),
            ),

            SizedBox(height: screenHeight * 0.02),

            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: ClipOval(
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: Image.asset('assets/maria.png', fit: BoxFit.cover),
                ),
              ),

              title: inter(
                text: 'Maria Joe',
                fontSize: 16,
                color: AppColors.black,
                fw: FontWeight.w400,
              ),
              subtitle: Row(
                children: [
                  Expanded(
                    child: inter(
                      text: 'Wants to join trip',
                      fontSize: 14,
                      color: AppColors.grey,
                      fw: FontWeight.w400,
                    ),
                  ),

                  SizedBox(
                    height: 32,
                    child: TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        // ignore: deprecated_member_use
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(horizontal: 10),
                        ),
                        // ignore: deprecated_member_use
                        backgroundColor: MaterialStateProperty.all(
                          AppColors.red,
                        ),
                      ),
                      child: inter(
                        text: 'Decline',
                        fontSize: 12,
                        color: AppColors.white,
                        fw: FontWeight.w400,
                      ),
                    ),
                  ),

                  const SizedBox(width: 6),

                  SizedBox(
                    height: 32,
                    child: TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        // ignore: deprecated_member_use
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(horizontal: 10),
                        ),
                        // ignore: deprecated_member_use
                        backgroundColor: MaterialStateProperty.all(
                          AppColors.green,
                        ),
                      ),
                      child: inter(
                        text: 'Accept',
                        fontSize: 12,
                        color: AppColors.white,
                        fw: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: ClipOval(
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: Image.asset('assets/maria.png', fit: BoxFit.cover),
                ),
              ),

              title: inter(
                text: 'Trip has been created',
                fontSize: 16,
                color: AppColors.black,
                fw: FontWeight.w400,
              ),
              subtitle: inter(
                text: 'Your trip to Murree has been created',
                fontSize: 14,
                color: AppColors.grey,
                fw: FontWeight.w400,
              ),
            ),

            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: ClipOval(
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: Image.asset('assets/maria.png', fit: BoxFit.cover),
                ),
              ),

              title: inter(
                text: 'Maria Joe',
                fontSize: 16,
                color: AppColors.black,
                fw: FontWeight.w400,
              ),
              subtitle: Row(
                children: [
                  Expanded(
                    child: inter(
                      text: 'Wants to join trip',
                      fontSize: 14,
                      color: AppColors.grey,
                      fw: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 32,
                    child: TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        // ignore: deprecated_member_use
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(horizontal: 10),
                        ),
                        // ignore: deprecated_member_use
                        backgroundColor: MaterialStateProperty.all(
                          AppColors.red,
                        ),
                      ),
                      child: inter(
                        text: 'Decline',
                        fontSize: 12,
                        color: AppColors.white,
                        fw: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(width: 6),
                  SizedBox(
                    height: 32,
                    child: TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        // ignore: deprecated_member_use
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(horizontal: 10),
                        ),
                        // ignore: deprecated_member_use
                        backgroundColor: MaterialStateProperty.all(
                          AppColors.green,
                        ),
                      ),
                      child: inter(
                        text: 'Accept',
                        fontSize: 12,
                        color: AppColors.white,
                        fw: FontWeight.w400,
                      ),
                    ),
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
