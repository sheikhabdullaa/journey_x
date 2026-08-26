import 'package:flutter/material.dart';
import 'package:journey_x/components/custom_text.dart';
import 'package:journey_x/utils/app_colors.dart';

class RateYourTrip extends StatefulWidget {
  const RateYourTrip({super.key});

  @override
  State<RateYourTrip> createState() => _RateYourTripState();
}

class _RateYourTripState extends State<RateYourTrip> {
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
        title: customtext(
          text: 'Rate Your Trip',
          fontSize: 16,
          color: AppColors.black,
          fw: FontWeight.w600,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      'assets/swizerland.png',
                      width: screenWidth * 1,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                'assets/maria.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.02),
                            customtext(
                              text: 'Planned by ',
                              fontSize: 12,
                              color: AppColors.white,
                              fw: FontWeight.w400,
                            ),

                            SizedBox(width: screenWidth * 0.3),
                            InkWell(
                              onTap: () {},
                              child: Image.asset('assets/dropdown.png'),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: customtext(
                            text: 'Maria Joe',
                            fontSize: 12,
                            color: AppColors.white,
                            fw: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.location_on_outlined),

              title: customtext(
                text: 'Tokyo, Japan',
                fontSize: 16,
                color: AppColors.black,
                fw: FontWeight.w600,
              ),
            ),
            ListTile(
              leading: Icon(Icons.calendar_month_outlined),
              title: customtext(
                text: '12–15 March, 2025',
                fontSize: 14,
                color: AppColors.grey,
                fw: FontWeight.w400,
              ),
            ),
            ListTile(
              leading: Icon(Icons.person_3_outlined),
              title: customtext(
                text: '4 Members',
                fontSize: 14,
                color: AppColors.grey,
                fw: FontWeight.w400,
              ),
            ),
            SizedBox(height: screenHeight * 0.2),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Write your review here...',
                  hintStyle: TextStyle(
                    color: AppColors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.07),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 48,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blueascent, // blue color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 0,
                  ),
                  child: const Center(
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
