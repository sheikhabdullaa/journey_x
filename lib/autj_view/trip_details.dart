// ignore: file_names
import 'package:flutter/material.dart';
import 'package:journey_x/autj_view/creat_trip.dart';
import 'package:journey_x/autj_view/notification_page.dart';
import 'package:journey_x/classes/day_classes.dart';
import 'package:journey_x/classes/degree_class.dart';
import 'package:journey_x/components/inter_text.dart';
import 'package:journey_x/components/popin_text.dart';
import 'package:journey_x/practise/watsapp_service.dart';
import 'package:journey_x/repository/creat_trip_repo.dart';
import 'package:journey_x/utils/app_colors.dart';

class TripDaetails extends StatefulWidget {
  const TripDaetails({super.key});

  @override
  State<TripDaetails> createState() => _TripDaetailsState();
}

final dayClass = DayClasses();
final degreeClass = DegreeClass();

class _TripDaetailsState extends State<TripDaetails> {
  // ignore: strict_top_level_inference
  get selectedDayIndex => null;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: AppColors.black),
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 40),
          child: popintext(
            text: 'Trip Details',
            fontSize: 20,
            color: AppColors.black,
            fw: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert, color: AppColors.black),
          ),
        ],
      ),
      body:
          // SizedBox(height: screenheight*0.5,),
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

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemCount: trips.length,

                  itemBuilder: (context, index) {
                    final trip = trips[index];

                    return Column(
                      children: [
                        popintext(
                          text: 'Active Trips',
                          fontSize: 16,
                          color: AppColors.black,
                          fw: FontWeight.w600,
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
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          child: Image.asset(
                                            'assets/maria.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(width: screenWidth * 0.02),
                                        inter(
                                          text: 'Planned by ',
                                          fontSize: 12,
                                          color: AppColors.white,
                                          fw: FontWeight.w400,
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 30),
                                      child: inter(
                                        text: trip.username.toString(),
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
                          title: popintext(
                            text: trip.location.toString(),
                            fontSize: 16,
                            color: AppColors.black,
                            fw: FontWeight.w600,
                          ),

                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              inter(
                                text: '26℃',
                                fontSize: 14,
                                color: AppColors.grey,
                                fw: .w400,
                              ),
                              SizedBox(width: screenheight * 0.01),
                              Icon(
                                Icons.wb_cloudy_outlined,
                                color: AppColors.grey,
                              ),
                            ],
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.calendar_month_outlined),
                          title: inter(
                            text:
                                '${trip.startDate.day} to ${trip.endDate.day}-${trip.endDate.month}-${trip.endDate.year}',
                            fontSize: 14,
                            color: AppColors.grey,
                            fw: FontWeight.w400,
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.person_3_outlined),
                          title: Row(
                            children: [
                              popintext(
                                text: trip.members.toString(),
                                fontSize: 14,
                                color: AppColors.grey,
                                fw: FontWeight.w400,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              inter(
                                text: 'Member',
                                fontSize: 14,
                                color: AppColors.grey,
                                fw: FontWeight.w400,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: screenheight * 0.07),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            popintext(
                              text: 'Pending Requests (2)',
                              fontSize: 16,
                              color: AppColors.black,
                              fw: .w600,
                            ),

                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: ClipOval(
                                child: SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: Image.asset(
                                    'assets/maria.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              title: inter(
                                text: trip.username.toString(),
                                fontSize: 12,
                                color: AppColors.white,
                                fw: FontWeight.w400,
                              ),
                              subtitle: Row(
                                children: [
                                  Expanded(
                                    child: inter(
                                      text: 'Wants to join trip',
                                      fontSize: 12,
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
                                          const EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                        ),
                                        // ignore: deprecated_member_use
                                        backgroundColor:
                                            WidgetStateProperty.all(
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
                                          const EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                        ),
                                        // ignore: deprecated_member_use
                                        backgroundColor:
                                            WidgetStateProperty.all(
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
                                  child: Image.asset(
                                    'assets/maria.png',
                                    fit: BoxFit.cover,
                                  ),
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
                                      fontSize: 12,
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
                                          const EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                        ),
                                        // ignore: deprecated_member_use
                                        backgroundColor:
                                            WidgetStateProperty.all(
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
                                          const EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                        ),
                                        // ignore: deprecated_member_use
                                        backgroundColor:
                                            WidgetStateProperty.all(
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
                            SizedBox(height: screenheight * 0.07),
                            ListTile(
                              leading: popintext(
                                text: 'Members (4)',
                                fontSize: 16,
                                color: AppColors.black,
                                fw: FontWeight.w600,
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              NotificationPage(),
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      color: AppColors.blueascent,
                                    ),
                                  ),
                                  inter(
                                    text: 'Add',
                                    fontSize: 14,
                                    color: AppColors.blueascent,
                                    fw: FontWeight.w400,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: screenheight * 0.01),
                            ListTile(
                              leading: ClipOval(
                                child: Image.asset('assets/maria.png'),
                              ),

                              title: inter(
                                text: 'Maria Joe',
                                fontSize: 16,
                                color: AppColors.black,
                                fw: FontWeight.w400,
                              ),
                              trailing: inter(
                                text: 'Owner',
                                fontSize: 14,
                                color: AppColors.grey,
                                fw: FontWeight.w700,
                              ),
                            ),
                            ListTile(
                              leading: SizedBox(
                                height: 25,
                                width: 25,
                                child: ClipOval(
                                  child: Image.asset('assets/michal.png'),
                                ),
                              ),
                              title: inter(
                                text: 'Michal',
                                fontSize: 16,
                                color: AppColors.black,
                                fw: FontWeight.w400,
                              ),
                              trailing: inter(
                                text: 'Guide',
                                fontSize: 14,
                                color: AppColors.grey,
                                fw: FontWeight.w400,
                              ),
                            ),
                            ListTile(
                              leading: SizedBox(
                                height: 25,
                                width: 25,
                                child: ClipOval(
                                  child: Image.asset('assets/sarah.png'),
                                ),
                              ),
                              title: inter(
                                text: 'Sarah Smith',
                                fontSize: 16,
                                color: AppColors.black,
                                fw: FontWeight.w400,
                              ),
                              trailing: inter(
                                text: 'Member',
                                fontSize: 14,
                                color: AppColors.grey,
                                fw: FontWeight.w400,
                              ),
                            ),
                            ListTile(
                              leading: SizedBox(
                                height: 25,
                                width: 25,
                                child: ClipOval(
                                  child: Image.asset('assets/girl.png'),
                                ),
                              ),
                              title: inter(
                                text: 'Emma Wilson',
                                fontSize: 16,
                                color: AppColors.black,
                                fw: FontWeight.w400,
                              ),
                              trailing: inter(
                                text: 'Member',
                                fontSize: 14,
                                color: AppColors.grey,
                                fw: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: screenheight * 0.07),
                            ListTile(
                              leading: popintext(
                                text: 'Expenses',
                                fontSize: 16,
                                color: AppColors.black,
                                fw: FontWeight.w600,
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CreatTrip(),
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      color: AppColors.blueascent,
                                    ),
                                  ),
                                  inter(
                                    text: 'Add',
                                    fontSize: 14,
                                    color: AppColors.blueascent,
                                    fw: FontWeight.w400,
                                  ),
                                ],
                              ),
                            ),

                            ListTile(
                              leading: inter(
                                text: 'Total Expenses',
                                fontSize: 16,
                                color: AppColors.grey,
                                fw: FontWeight.w400,
                              ),
                              trailing: popintext(
                                text: '${trip.totalSpendExpense}',
                                fontSize: 20,
                                color: AppColors.blueascent,
                                fw: FontWeight.w600,
                              ),
                            ),

                            ListTile(
                              leading: inter(
                                text: 'Per Person',
                                fontSize: 16,
                                color: AppColors.grey,
                                fw: FontWeight.w400,
                              ),
                              trailing: inter(
                                text: '${trip.perPersonExpense}',
                                fontSize: 14,
                                color: AppColors.grey,
                                fw: FontWeight.w600,
                              ),
                            ),

                            ListTile(
                              leading: Icon(Icons.business),
                              title: inter(
                                text: 'Hotel Booking',
                                fontSize: 16,
                                color: AppColors.black,
                                fw: FontWeight.w400,
                              ),
                              trailing: popintext(
                                text: '${trip.hotelExpense}',
                                fontSize: 16,
                                color: AppColors.black,
                                fw: FontWeight.w600,
                              ),
                            ),

                            ListTile(
                              leading: Icon(Icons.location_on_outlined),
                              title: inter(
                                text: 'Transportation',
                                fontSize: 16,
                                color: AppColors.black,
                                fw: FontWeight.w400,
                              ),
                              trailing: popintext(
                                text: '${trip.transportationExpense}',
                                fontSize: 16,
                                color: AppColors.black,
                                fw: FontWeight.w600,
                              ),
                            ),

                            ListTile(
                              leading: Icon(Icons.room_service_outlined),
                              title: inter(
                                text: 'Dinner Restaurant',
                                fontSize: 16,
                                color: AppColors.black,
                                fw: FontWeight.w400,
                              ),
                              trailing: popintext(
                                text: '${trip.dinnerExpense}',
                                fontSize: 16,
                                color: AppColors.black,
                                fw: FontWeight.w600,
                              ),
                            ),

                            SizedBox(height: screenheight * 0.07),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Column(
                                children: [
                                  popintext(
                                    text: 'Weather',
                                    fontSize: 16,
                                    color: AppColors.black,
                                    fw: FontWeight.w600,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(
                                          83,
                                          191,
                                          216,
                                          249,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Icon(
                                        Icons.sunny,
                                        color: AppColors.blueascent,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: screenWidth * 0.02),
                                  Column(
                                    children: [
                                      popintext(
                                        text: '26°C',
                                        fontSize: 32,
                                        color: AppColors.black,
                                        fw: FontWeight.w600,
                                      ),
                                      inter(
                                        text: 'Sunny • Tokyo',
                                        fontSize: 14,
                                        color: AppColors.grey,
                                        fw: FontWeight.w400,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: screenheight * 0.02),

                            SizedBox(
                              height: screenheight * 0.1,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: dayClass.days.length,
                                itemBuilder: (context, index) {
                                  final isSelected = selectedDayIndex == index;
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {});
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      // ignore: avoid_unnecessary_containers
                                      child: Container(
                                        child: Center(
                                          child: Text(
                                            dayClass.days[index],
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: isSelected
                                                  ? AppColors.white
                                                  : AppColors.grey,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Row(
                                children: [
                                  Image.asset('assets/monday.png'),
                                  SizedBox(width: 25),
                                  Image.asset('assets/monday.png'),
                                  SizedBox(width: 25),
                                  Image.asset('assets/wednesday.png'),
                                  SizedBox(width: 25),
                                  Image.asset('assets/thursday.png'),
                                  SizedBox(width: 25),
                                  Image.asset('assets/thursday.png'),
                                  SizedBox(width: 25),
                                  Image.asset('assets/friday.png'),
                                ],
                              ),
                            ),

                            SizedBox(
                              height: screenheight * 0.1,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: dayClass.days.length,
                                itemBuilder: (context, index) {
                                  final isSelected = selectedDayIndex == index;
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {});
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      // ignore: avoid_unnecessary_containers
                                      child: Container(
                                        child: Center(
                                          child: Text(
                                            degreeClass.degree[index],
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: isSelected
                                                  ? AppColors.white
                                                  : AppColors.grey,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Column(
                                children: [
                                  popintext(
                                    text: 'Group Chat',
                                    fontSize: 16,
                                    color: AppColors.black,
                                    fw: FontWeight.w600,
                                  ),
                                ],
                              ),
                            ),
                            ListTile(
                              onTap: () async {
                                // Optional loader for better UX
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (_) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );

                                await WhatsAppService.openChat(
                                  context: context,
                                  phone: '923288898341',
                                  message: 'Hello! I want to join the trip 😊',
                                );

                                // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                              },
                              leading: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  color: AppColors.green,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.messenger_outline_rounded,
                                  color: AppColors.white,
                                ),
                              ),
                              title: inter(
                                text: 'Open Chat',
                                fontSize: 16,
                                color: AppColors.black,
                                fw: FontWeight.w600,
                              ),
                              subtitle: inter(
                                text: 'Chat with guider or honour from here',
                                fontSize: 11,
                                color: AppColors.grey,
                                fw: FontWeight.w300,
                              ),
                            ),

                            SizedBox(height: screenheight * 0.1),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
    );
  }
}

// // ignore: file_names
// import 'package:flutter/material.dart';
// import 'package:turist_app/classes/day_classes.dart' show DayClasses;
// import 'package:turist_app/classes/degree_class.dart';
// import 'package:turist_app/components/inter_text.dart';
// import 'package:turist_app/components/popin_text.dart';
// import 'package:turist_app/repository/creat_trip_repo.dart';
// import 'package:turist_app/utils/app_colors.dart';

// import 'package:url_launcher/url_launcher.dart';

// class TripDaetails extends StatefulWidget {
//   const TripDaetails({super.key});

//   @override
//   State<TripDaetails> createState() => _TripDaetailsState();
// }

// final dayClass = DayClasses();
// final degreeClass = DegreeClass();

// class _TripDaetailsState extends State<TripDaetails> {
//   get selectedDayIndex => null;

//   // ✅ FIXED GOOGLE MAP FUNCTION (GUARANTEED WORKING)
//   Future<void> openGoogleMap(String location) async {
//     final Uri uri = Uri.parse(
//       "https://www.google.com/maps/search/?api=1&query=$location",
//     );

//     try {
//       await launchUrl(
//         uri,
//         mode: LaunchMode.externalApplication, // IMPORTANT
//       );
//     } catch (e) {
//       debugPrint("Map open error: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenheight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: Icon(Icons.arrow_back, color: AppColors.black),
//         ),
//         title: Padding(
//           padding: const EdgeInsets.only(left: 40),
//           child: popintext(
//             text: 'Trip Details',
//             fontSize: 20,
//             color: AppColors.black,
//             fw: FontWeight.w600,
//           ),
//         ),
//       ),

//       body: Expanded(
//         child: FutureBuilder(
//           future: CreatTripRepo().activeTripsGet(),
//           builder: (context, snapshot) {
//             if (!snapshot.hasData) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             final trips = snapshot.data!;

//             return ListView.builder(
//               itemCount: trips.length,
//               itemBuilder: (context, index) {
//                 final trip = trips[index];

//                 return Column(
//                   children: [
//                     popintext(
//                       text: 'Active Trips',
//                       fontSize: 16,
//                       color: AppColors.black,
//                       fw: FontWeight.w600,
//                     ),

//                     // ================= LOCATION ROW FIX =================
//                     ListTile(
//                       leading: GestureDetector(
//                         behavior: HitTestBehavior.opaque,
//                         onTap: () {
//                           openGoogleMap(trip.location.toString());
//                         },
//                         child: const Padding(
//                           padding: EdgeInsets.all(8.0),
//                           child: Icon(Icons.location_on_outlined),
//                         ),
//                       ),
//                       title: popintext(
//                         text: trip.location.toString(),
//                         fontSize: 16,
//                         color: AppColors.black,
//                         fw: FontWeight.w600,
//                       ),
//                       trailing: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           inter(
//                             text: '26℃',
//                             fontSize: 14,
//                             color: AppColors.grey,
//                             fw: FontWeight.w400,
//                           ),
//                           const SizedBox(width: 8),
//                           Icon(Icons.wb_cloudy_outlined, color: AppColors.grey),
//                         ],
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
