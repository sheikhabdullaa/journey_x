import 'package:flutter/material.dart';
import 'package:journey_x/autj_view/request_to_join.dart';
import 'package:journey_x/autj_view/tourist_dashbord.dart';
import 'package:journey_x/components/custom_text_button.dart';
import 'package:journey_x/components/inter_text.dart';
import 'package:journey_x/components/popin_text.dart';
import 'package:journey_x/repository/creat_trip_repo.dart';
import 'package:journey_x/utils/app_colors.dart';

class SeenGuider extends StatefulWidget {
  const SeenGuider({super.key});

  @override
  State<SeenGuider> createState() => _SeenGuiderState();
}

class _SeenGuiderState extends State<SeenGuider> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.04),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  popintext(
                    text: 'Upcoming Trips',
                    fontSize: 24,
                    color: AppColors.black,
                    fw: FontWeight.w600,
                  ),

                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TouristDashbord(),
                        ),
                      );
                    },
                    icon: Icon(Icons.arrow_forward, color: AppColors.black),
                  ),
                ],
              ),
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
                              inter(
                                text: 'Maria Joe',
                                fontSize: 16,
                                color: AppColors.white,
                                fw: FontWeight.w400,
                              ),
                              SizedBox(width: screenWidth * 0.01),
                              inter(
                                text: '2d left',
                                fontSize: 12,
                                color: AppColors.white,
                                fw: FontWeight.w400,
                              ),
                            ],
                          ),
                          inter(
                            text: 'Swiss Alps, Switzerland',
                            fontSize: 16,
                            color: AppColors.white,
                            fw: FontWeight.w600,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Card(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Image.asset('assets/swizerland1.png'),
                              Padding(
                                padding: const EdgeInsets.only(left: 80),
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.keyboard_arrow_down_sharp,
                                        size: 30,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          inter(
                            text: 'Switzerland',
                            fontSize: 14,
                            color: AppColors.black,
                            fw: FontWeight.w500,
                          ),
                          inter(
                            text: '12–15 Jan, 2026',
                            fontSize: 12,
                            color: AppColors.grey,
                            fw: FontWeight.w400,
                          ),
                          inter(
                            text: '2d left',
                            fontSize: 12,
                            color: AppColors.grey,
                            fw: FontWeight.w400,
                          ),
                          Container(height: screenHeight * 0.02),
                        ],
                      ),
                    ),
                    Card(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  'assets/swizerland2.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 80),
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.keyboard_arrow_down_sharp,
                                        size: 30,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          inter(
                            text: 'Switzerland',
                            fontSize: 14,
                            color: AppColors.black,
                            fw: FontWeight.w500,
                          ),
                          inter(
                            text: '12–15 Jan, 2026',
                            fontSize: 12,
                            color: AppColors.grey,
                            fw: FontWeight.w400,
                          ),
                          inter(
                            text: '2d left',
                            fontSize: 12,
                            color: AppColors.grey,
                            fw: FontWeight.w400,
                          ),
                          Container(height: screenHeight * 0.02),
                        ],
                      ),
                    ),
                    Card(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  'assets/swizerland3.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 80),
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        setState(() {});
                                      },
                                      icon: Icon(
                                        Icons.keyboard_arrow_down_sharp,
                                        size: 30,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          inter(
                            text: 'Switzerland',
                            fontSize: 14,
                            color: AppColors.black,
                            fw: FontWeight.w500,
                          ),
                          inter(
                            text: '12–15 Jan, 2026',
                            fontSize: 12,
                            color: AppColors.grey,
                            fw: FontWeight.w400,
                          ),
                          inter(
                            text: '2d left',
                            fontSize: 12,
                            color: AppColors.grey,
                            fw: FontWeight.w400,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.02),

              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
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
                    Image.asset('assets/icon.png'),
                  ],
                ),
              ),

              //grid view builder start
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

                  return RefreshIndicator(
                    onRefresh: () async {
                      setState(() {});
                    },
                    child: GridView.builder(
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

                        return Flexible(
                          child: Card(
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
                                              BorderRadiusGeometry.circular(12),
                                          child: Image.asset(
                                            'assets/swizerland3.png',
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height: 120,
                                          ),
                                        ),

                                        Positioned(
                                          top: 10,
                                          left: 10,
                                          child: Row(
                                            children: [
                                              ClipOval(
                                                child: Image.asset(
                                                  'assets/maria.png',
                                                  height: 28,
                                                  width: 28,
                                                ),
                                              ),
                                              const SizedBox(width: 6),

                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  inter(
                                                    text: 'Planned by',
                                                    fontSize: 10,
                                                    color: Colors.white,
                                                  ),

                                                  SizedBox(
                                                    width: 90,
                                                    child: inter(
                                                      text: trip.username,
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),

                                        Positioned(
                                          top: 8,
                                          right: 8,
                                          child: Icon(
                                            Icons.favorite_outline,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              const BorderRadius.vertical(
                                                top: Radius.circular(12),
                                              ),
                                          child: Image.asset(
                                            'assets/swizerland3.png',
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height: 120,
                                          ),
                                        ),

                                        Positioned(
                                          top: 10,
                                          left: 10,
                                          child: Row(
                                            children: [
                                              ClipOval(
                                                child: Image.asset(
                                                  'assets/maria.png',
                                                  height: 28,
                                                  width: 28,
                                                ),
                                              ),
                                              const SizedBox(width: 6),

                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  inter(
                                                    text: 'Planned by',
                                                    fontSize: 10,
                                                    color: Colors.white,
                                                  ),

                                                  SizedBox(
                                                    width: 90,
                                                    child: inter(
                                                      text: trip.username,
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
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
                                            '${trip.startDate.day}-${trip.startDate.month}-${trip.startDate.year}',
                                        fontSize: 12,
                                        color: AppColors.grey,
                                        fw: FontWeight.w400,
                                      ),

                                      SizedBox(height: screenHeight * 0.01),
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
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
