import 'package:flutter/material.dart';
import 'package:journeyX/autj_view/michal_turist_profile.dart';
import 'package:journeyX/autj_view/notification_page.dart';
import 'package:journeyX/autj_view/request_to_join.dart';
import 'package:journeyX/components/custom_text_button.dart';
import 'package:journeyX/components/inter_text.dart';
import 'package:journeyX/components/popin_text.dart';
import 'package:journeyX/repository/creat_trip_repo.dart';
import 'package:journeyX/utils/app_colors.dart';

class ActiveTrip extends StatefulWidget {
  const ActiveTrip({super.key});

  @override
  State<ActiveTrip> createState() => _ActiveTripState();
}

class _ActiveTripState extends State<ActiveTrip> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => MichalTuristProfile()),
              );
            },
            child: ClipOval(
              child: Image.asset('assets/guider.png', fit: BoxFit.cover),
            ),
          ),
        ),
        title: Center(
          child: popintext(
            text: 'Hello! Michal',
            fontSize: 16,
            color: AppColors.black,
            fw: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => NotificationPage()),
              );
            },
          ),
        ],
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                popintext(
                  text: 'Active Trips',
                  fontSize: 24,
                  color: AppColors.black,
                  fw: FontWeight.w600,
                ),
                InkWell(
                  onTap: () => {setState(() {})},
                  child: Image.asset('assets/icon.png'),
                ),
              ],
            ),
          ),

          Expanded(
            child: FutureBuilder(
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
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemCount: trips.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.62,
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
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(12),
                                    ),
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
                                              width: 36,
                                              height: 36,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),

                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              inter(
                                                text: 'Planned by',
                                                fontSize: 12,
                                                color: AppColors.white,
                                                fw: FontWeight.w400,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              inter(
                                                text: trip.username,
                                                fontSize: 12,
                                                color: AppColors.white,
                                                fw: FontWeight.w400,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              // Positioned(
                              //   top: 3,
                              //   right: 1,
                              //   child: IconButton(
                              //     // constraints: const BoxConstraints(),
                              //     onPressed: () {
                              //       if (trip == null) return;
                              //     },
                              //     icon: Icon(
                              //       Icons.favorite_outline,
                              //       color: AppColors.white,
                              //       size: 22,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    popintext(
                                      text: trip.location.toString(),
                                      fontSize: 12,
                                      color: AppColors.black,
                                      fw: FontWeight.w500,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(width: screenWidth * 0.06),
                                    popintext(
                                      text: trip.members.toString(),
                                      fontSize: 12,
                                      color: AppColors.grey,
                                      fw: FontWeight.w400,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(width: 4),
                                    Image.asset(
                                      'assets/personicon.png',
                                      color: AppColors.grey,
                                      height: 14,
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

                                Row(
                                  children: [
                                    popintext(
                                      text: '${trip.perPersonExpense}',

                                      fontSize: 16,
                                      color: AppColors.green,
                                      fw: FontWeight.w600,
                                    ),

                                    const SizedBox(width: 6),
                                    inter(
                                      text: 'per per..',
                                      fontSize: 14,
                                      color: AppColors.grey,
                                      fw: FontWeight.w400,
                                    ),
                                  ],
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
          ),
        ],
      ),
    );
  }
}
