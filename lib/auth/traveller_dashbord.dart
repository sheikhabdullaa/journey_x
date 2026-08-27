import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:journeyX/active_trip.dart';
import 'package:journeyX/autj_view/active_bottom_sheet.dart';
import 'package:journeyX/autj_view/bottom_sheet.dart';
import 'package:journeyX/autj_view/guider_dashboard.dart';
import 'package:journeyX/autj_view/notification_page.dart';
import 'package:journeyX/autj_view/request_to_join.dart';
import 'package:journeyX/autj_view/trip_details.dart';
import 'package:journeyX/autj_view/turist_profile.dart';
import 'package:journeyX/classes/action_button.dart';
import 'package:journeyX/components/custom_text.dart';
import 'package:journeyX/components/custom_text_button.dart';
import 'package:journeyX/components/inter_text.dart';
import 'package:journeyX/components/popin_text.dart';
import 'package:journeyX/quick_action.dart/expences.dart';
import 'package:journeyX/quick_action.dart/weather.dart';
import 'package:journeyX/repository/creat_trip_repo.dart';
import 'package:journeyX/utils/app_colors.dart';

import 'package:url_launcher/url_launcher.dart';

Future<void> openGoogleMaps(String location) async {
  final Uri url = Uri.parse(
    'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(location)}',
  );

  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }
}

class TravellerDashbord extends StatefulWidget {
  const TravellerDashbord({super.key});

  @override
  State<TravellerDashbord> createState() => TravellerDashbordState();
}

class TravellerDashbordState extends State<TravellerDashbord> {
  double? temperature;

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  Future<void> getWeather() async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://api.open-meteo.com/v1/forecast?latitude=31.5204&longitude=74.3587&current=temperature_2m',
        ),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          temperature = (data['current']?['temperature_2m'] as num?)
              ?.toDouble();
        });
      }
    } catch (e) {
      // ignore: avoid_print
      print('Weather Error: $e');
    }
  }

  // ignore: annotate_overrides
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),

                // main card
                child: Card(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TuristProfile(),
                                  ),
                                );
                              },
                              child: ClipOval(
                                child: Image.asset('assets/sarah.png'),
                              ),
                            ),

                            customtext(
                              text: 'Hello! Sarah Smith',
                              fontSize: 16,
                              color: AppColors.black,
                              fw: .w600,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NotificationPage(),
                                  ),
                                );
                              },
                              child: Image.asset('assets/bell.png'),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset('assets/sun.png'),
                            Column(
                              children: [
                                popintext(
                                  text: 'Current Destination',
                                  fontSize: 14,
                                  color: AppColors.grey,
                                  fw: FontWeight.w400,
                                ),
                                popintext(
                                  // text: 'Sunny • 32℃',
                                  text: temperature != null
                                      ? 'Sunyy ${temperature!.round()}℃'
                                      : '--℃',
                                  fontSize: 16,
                                  color: AppColors.black,
                                  fw: FontWeight.w600,
                                ),
                              ],
                            ),
                            SizedBox(width: screenWidth * 0.08),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TripDaetails(),
                                  ),
                                );
                              },
                              child: inter(
                                text: 'View Forecast',
                                fontSize: 12,
                                color: AppColors.blueascent,
                                fw: .w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(height: screenHeight * 0.03),
                    ],
                  ),
                ),
              ),

              //quick action start
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: popintext(
                    text: 'Quick Actions',
                    fontSize: 24,
                    color: AppColors.black,
                    fw: FontWeight.w600,
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.01),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RequesttojoinTripDetails(),
                        ),
                      );
                    },
                    child: actionButton(Icons.group_outlined, 'Join Trip'),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => expencesPage()),
                      );
                    },
                    child: actionButton(Icons.credit_card, 'Expenses'),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ActiveBottomSheet(),
                        ),
                      );
                    },
                    child: actionButton(Icons.calendar_today, 'Bookings'),
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WeatherPage(),
                          ),
                        );
                      },
                      child: actionButton(Icons.cloud_outlined, 'Weather'),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => guideBottomSheet(),
                        ),
                      );
                    },
                    child: actionButton(Icons.menu_book, 'Guides'),
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (context) => ChatBort()),
                  //     );
                  //   },
                  //   child: actionButton(Icons.smart_toy_outlined, 'Chat Bot'),
                  // ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    popintext(
                      text: 'Active Trips',
                      fontSize: 24,
                      color: AppColors.black,
                      fw: .w600,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {});
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ActiveTrip()),
                        );
                      },
                      child: Image.asset('assets/icon.png'),
                    ),
                  ],
                ),
              ),

              // grid view builder start
              FutureBuilder(
                future: CreatTripRepo().activeTripsGet(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No active trips found'));
                  }

                  final trips = snapshot.data!;

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemCount: trips.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                    itemBuilder: (context, index) {
                      final trip = trips[index];

                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius:
                                          BorderRadiusGeometry.circular(15),
                                      child: Image.asset(
                                        'assets/swizerland3.png',
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: 120,
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 10,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            child: ClipOval(
                                              child: Image.asset(
                                                'assets/maria.png',
                                              ),
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              inter(
                                                text: 'Planned by ',
                                                fontSize: 12,
                                                color: AppColors.white,
                                                fw: FontWeight.w400,
                                              ),

                                              inter(
                                                text: trip.username.toString(),

                                                fontSize: 12,
                                                color: AppColors.white,
                                                fw: FontWeight.w400,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                // Positioned(
                                //   top: 8,
                                //   right: 8,
                                //   child: Expanded(
                                //     child: IconButton(
                                //       onPressed: () {},
                                //       icon: Icon(
                                //         Icons.favorite_outline,
                                //         color: AppColors.white,
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      popintext(
                                        text: trip.location.toString(),
                                        fontSize: 16,
                                        color: AppColors.black,
                                        fw: FontWeight.w600,
                                      ),
                                    ],
                                  ),

                                  inter(
                                    text:
                                        '${trip.startDate.day} to ${trip.endDate.day}-${trip.endDate.month}-${trip.endDate.year}',

                                    fontSize: 12,
                                    color: AppColors.grey,
                                    fw: FontWeight.w400,
                                  ),

                                  SizedBox(height: screenHeight * 0.02),
                                  Center(
                                    child: CustomButton(
                                      title: 'Join',
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                RequesttojoinTripDetails(),
                                          ),
                                        );
                                      },
                                      bgColor: AppColors.blueascent,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),

              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   child: Row(
              //     children: [
              //       Card(
              //         child: Column(
              //           children: [
              //             Stack(
              //               children: [
              //                 Container(
              //                   width: 150,
              //                   height: 120,
              //                   decoration: BoxDecoration(
              //                     borderRadius: BorderRadius.circular(10),
              //                     image: DecorationImage(
              //                       image: AssetImage('assets/swizerland3.png'),
              //                       fit: BoxFit.cover,
              //                     ),
              //                   ),

              //                   child: Padding(
              //                     padding: const EdgeInsets.symmetric(
              //                       vertical: 10,
              //                     ),
              //                     child: Row(
              //                       crossAxisAlignment:
              //                           CrossAxisAlignment.start,

              //                       children: [
              //                         Padding(
              //                           padding: const EdgeInsets.symmetric(
              //                             horizontal: 10,
              //                           ),
              //                           child: Padding(
              //                             padding: const EdgeInsets.only(
              //                               top: 10,
              //                             ),
              //                             child: ClipOval(
              //                               child: Image.asset(
              //                                 'assets/maria.png',
              //                               ),
              //                             ),
              //                           ),
              //                         ),
              //                         Column(
              //                           children: [
              //                             customtext(
              //                               text: 'Planned by ',
              //                               fontSize: 12,
              //                               color: AppColors.white,
              //                               fw: FontWeight.w400,
              //                             ),
              //                             customtext(
              //                               text: 'Maria Joe ',
              //                               fontSize: 12,
              //                               color: AppColors.white,
              //                               fw: FontWeight.w400,
              //                             ),
              //                           ],
              //                         ),
              //                         Expanded(
              //                           child: IconButton(
              //                             onPressed: () {},
              //                             icon: Icon(
              //                               Icons.favorite_outline,
              //                               color: AppColors.white,
              //                             ),
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             ),

              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.start,
              //               children: [
              //                 popintext(
              //                   text: 'Swiss Alps',
              //                   fontSize: 16,
              //                   color: AppColors.black,
              //                   fw: FontWeight.w600,
              //                 ),
              //                 SizedBox(width: screenWidth * 0.03),
              //                 popintext(
              //                   text: '12',
              //                   fontSize: 14,
              //                   color: AppColors.grey,
              //                   fw: FontWeight.w400,
              //                 ),
              //               ],
              //             ),
              //             popintext(
              //               text: '12–15 Jan, 2026',
              //               fontSize: 14,
              //               color: AppColors.grey,
              //               fw: FontWeight.w400,
              //             ),

              //             SizedBox(height: screenHeight * 0.02),
              //             SizedBox(
              //               height: screenHeight * 0.055,
              //               width: screenWidth * 0.4,
              //               child: ElevatedButton(
              //                 onPressed: () {
              //                   Navigator.push(
              //                     context,
              //                     MaterialPageRoute(
              //                       builder: (context) => guideBottomSheet(),
              //                     ),
              //                   );
              //                 },
              //                 style: ElevatedButton.styleFrom(
              //                   backgroundColor: AppColors.blueascent,
              //                   foregroundColor: AppColors.white,
              //                   shape: RoundedRectangleBorder(
              //                     borderRadius: BorderRadius.circular(17),
              //                   ),
              //                   elevation: 0,
              //                 ),
              //                 child: Row(
              //                   mainAxisAlignment: MainAxisAlignment.center,
              //                   children: [
              //                     popintext(
              //                       text: 'Join',
              //                       fontSize: 12,
              //                       color: AppColors.white,
              //                       fw: .w500,
              //                     ),
              //                     SizedBox(width: 6),
              //                     Icon(Icons.arrow_forward),
              //                   ],
              //                 ),
              //               ),
              //             ),
              //             Container(height: screenHeight * 0.02),
              //           ],
              //         ),
              //       ),

              //       SizedBox(width: screenWidth * 0.01),
              //       Card(
              //         child: Column(
              //           children: [
              //             Stack(
              //               children: [
              //                 Container(
              //                   width: 150,
              //                   height: 120,
              //                   decoration: BoxDecoration(
              //                     borderRadius: BorderRadius.circular(10),
              //                     image: DecorationImage(
              //                       image: AssetImage('assets/swiiss.png'),
              //                       fit: BoxFit.cover,
              //                     ),
              //                   ),

              //                   child: Padding(
              //                     padding: const EdgeInsets.symmetric(
              //                       vertical: 10,
              //                     ),
              //                     child: Row(
              //                       crossAxisAlignment:
              //                           CrossAxisAlignment.start,

              //                       children: [
              //                         Padding(
              //                           padding: const EdgeInsets.symmetric(
              //                             horizontal: 10,
              //                           ),
              //                           child: Padding(
              //                             padding: const EdgeInsets.only(
              //                               top: 10,
              //                             ),
              //                             child: ClipOval(
              //                               child: Image.asset(
              //                                 'assets/maria.png',
              //                               ),
              //                             ),
              //                           ),
              //                         ),
              //                         Column(
              //                           children: [
              //                             customtext(
              //                               text: 'Planned by ',
              //                               fontSize: 12,
              //                               color: AppColors.white,
              //                               fw: FontWeight.w400,
              //                             ),
              //                             customtext(
              //                               text: 'Maria Joe ',
              //                               fontSize: 12,
              //                               color: AppColors.white,
              //                               fw: FontWeight.w400,
              //                             ),
              //                           ],
              //                         ),
              //                         // SizedBox(width: screenWidth * 0.012),
              //                         Expanded(
              //                           child: IconButton(
              //                             onPressed: () {},
              //                             icon: Icon(
              //                               Icons.favorite_outline,
              //                               color: AppColors.white,
              //                             ),
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             ),

              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.start,
              //               children: [
              //                 popintext(
              //                   text: 'Swiss Alps',
              //                   fontSize: 16,
              //                   color: AppColors.black,
              //                   fw: FontWeight.w600,
              //                 ),
              //                 SizedBox(width: screenWidth * 0.03),
              //                 popintext(
              //                   text: '12',
              //                   fontSize: 14,
              //                   color: AppColors.grey,
              //                   fw: FontWeight.w400,
              //                 ),
              //               ],
              //             ),
              //             popintext(
              //               text: '12–15 Jan, 2026',
              //               fontSize: 14,
              //               color: AppColors.grey,
              //               fw: FontWeight.w400,
              //             ),

              //             SizedBox(height: screenHeight * 0.02),
              //             SizedBox(
              //               height: screenHeight * 0.055,
              //               width: screenWidth * 0.4,
              //               child: ElevatedButton(
              //                 onPressed: () {
              //                   Navigator.push(
              //                     context,
              //                     MaterialPageRoute(
              //                       builder: (context) => guideBottomSheet(),
              //                     ),
              //                   );
              //                 },
              //                 style: ElevatedButton.styleFrom(
              //                   backgroundColor: AppColors.blueascent,
              //                   foregroundColor: AppColors.white,
              //                   shape: RoundedRectangleBorder(
              //                     borderRadius: BorderRadius.circular(17),
              //                   ),
              //                   elevation: 0,
              //                 ),
              //                 child: Row(
              //                   mainAxisAlignment: MainAxisAlignment.center,
              //                   children: [
              //                     popintext(
              //                       text: 'Join',
              //                       fontSize: 12,
              //                       color: AppColors.white,
              //                       fw: .w500,
              //                     ),
              //                     SizedBox(width: 6),
              //                     Icon(Icons.arrow_forward),
              //                   ],
              //                 ),
              //               ),
              //             ),
              //             Container(height: screenHeight * 0.02),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              Container(height: screenHeight * 0.04),
            ],
          ),
        ),
      ),
    );
  }
}
