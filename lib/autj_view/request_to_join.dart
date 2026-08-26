import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:journeyX/classes/day_classes.dart';
import 'package:journeyX/classes/degree_class.dart';
import 'package:journeyX/components/inter_text.dart';
import 'package:journeyX/components/popin_text.dart';
import 'package:journeyX/practise/watsapp_service.dart';
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

class RequesttojoinTripDetails extends StatefulWidget {
  const RequesttojoinTripDetails({super.key});

  @override
  State<RequesttojoinTripDetails> createState() =>
      _RequesttojoinTripDetailsState();
}

class _RequesttojoinTripDetailsState extends State<RequesttojoinTripDetails> {
  final dayClass = DayClasses();
  final degreeClass = DegreeClass();

  int? selectedDegreeIndex;
  int? selectedDayIndex;
  // double? temperature;
  double? temperature;

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  // WhatsApp launch function
  void launchWhatsapp({required String number, required String message}) async {
    final Uri whatsappUri = Uri.parse(
      'https://wa.me/$number?text=${Uri.encodeComponent(message)}',
    );

    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(
        // ignore: use_build_context_synchronously
        context,
      ).showSnackBar(const SnackBar(content: Text('WhatsApp not installed')));
    }
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
      print('Weather Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        titleSpacing: screenWidth * 0.2,
        title: popintext(
          text: 'Trip Details',
          fontSize: 16,
          color: AppColors.black,
          fw: FontWeight.w600,
        ),
        actions: const [Icon(Icons.more_vert_outlined)],
      ),
      body: FutureBuilder(
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
                  // Trip image + planner
                  Card(
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            'assets/swizerland.png',
                            width: screenWidth,
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

                  const SizedBox(height: 10),

                  // Location
                  ListTile(
                    leading: IconButton(
                      icon: const Icon(Icons.location_on_outlined),
                      onPressed: () {
                        openGoogleMaps(trip.location.toString());
                      },
                    ),

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
                          text: '32°C',
                          // text: temperature != null
                          //     ? '${temperature!.round()}℃'
                          //     : '--℃',
                          fontSize: 14,
                          color: AppColors.grey,
                          fw: FontWeight.w400,
                        ),
                        SizedBox(width: screenHeight * 0.01),
                        Icon(Icons.wb_cloudy_outlined, color: AppColors.grey),
                      ],
                    ),
                  ),

                  // Dates
                  ListTile(
                    leading: const Icon(Icons.calendar_month_outlined),
                    title: inter(
                      text:
                          '${trip.startDate.day} to ${trip.endDate.day}-${trip.endDate.month}-${trip.endDate.year}',
                      fontSize: 14,
                      color: AppColors.grey,
                      fw: FontWeight.w400,
                    ),
                  ),

                  // Members
                  ListTile(
                    leading: const Icon(Icons.person_3_outlined),
                    title: Row(
                      children: [
                        popintext(
                          text: '${trip.members}',
                          fontSize: 14,
                          color: AppColors.grey,
                          fw: FontWeight.w400,
                        ),
                        inter(
                          text: ' Member',
                          fontSize: 14,
                          color: AppColors.grey,
                          fw: FontWeight.w400,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.07),

                  // Join via WhatsApp button
                  SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) =>
                              const Center(child: CircularProgressIndicator()),
                        );

                        launchWhatsapp(
                          number: '923288898341',
                          message: 'Hello! I want to join this trip 😊',
                        );

                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.blueascent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.message, color: Colors.white),
                      label: const Text(
                        'Join',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.07),

                  // Members list
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
                          onPressed: () {},
                          icon: Icon(Icons.add, color: AppColors.blueascent),
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

                  SizedBox(height: screenHeight * 0.01),

                  // Example members
                  ListTile(
                    leading: ClipOval(child: Image.asset('assets/maria.png')),
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
                      child: ClipOval(child: Image.asset('assets/michal.png')),
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
                      child: ClipOval(child: Image.asset('assets/sarah.png')),
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
                      child: ClipOval(child: Image.asset('assets/girl.png')),
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

                  SizedBox(height: screenHeight * 0.07),

                  // Expenses
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
                          onPressed: () {},
                          icon: Icon(Icons.add, color: AppColors.blueascent),
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

                  SizedBox(height: screenHeight * 0.07),

                  // Weather block
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(83, 191, 216, 249),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            popintext(
                              // text: '26°C',
                              text: trip.location.toString(),

                              fontSize: 32,
                              color: AppColors.black,
                              fw: FontWeight.w600,
                            ),
                            inter(
                              text: '32°C',

                              // text: temperature != null
                              //     ? '${temperature!.round()}℃'
                              //     : '--℃',
                              fontSize: 14,
                              color: AppColors.grey,
                              fw: FontWeight.w400,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.07),

                  // Horizontal
                  SizedBox(
                    height: screenHeight * 0.07,

                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: dayClass.days.length,
                      itemBuilder: (context, idx) {
                        final isSelected = selectedDayIndex == idx;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedDayIndex = idx;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.blueascent
                                  : AppColors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                dayClass.days[idx],
                                style: TextStyle(
                                  color: isSelected
                                      ? AppColors.white
                                      : AppColors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.07),
                  // Horizontal Degree Selector
                  SizedBox(
                    height: screenHeight * 0.07,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: degreeClass.degree.length,
                      itemBuilder: (context, idx) {
                        final isSelected = selectedDegreeIndex == idx;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedDegreeIndex = idx;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 7),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.blueascent
                                  : AppColors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                degreeClass.degree[idx],
                                style: TextStyle(
                                  color: isSelected
                                      ? AppColors.white
                                      : AppColors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.07),

                  // WhatsApp Chat ListTile
                  ListTile(
                    onTap: () async {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) =>
                            const Center(child: CircularProgressIndicator()),
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

                  SizedBox(height: screenHeight * 0.13),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
