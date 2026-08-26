import 'package:flutter/material.dart';
import 'package:journeyX/classes/day_classes.dart';
import 'package:journeyX/classes/degree_class.dart';
import 'package:journeyX/components/inter_text.dart';
import 'package:journeyX/components/popin_text.dart';
import 'package:journeyX/repository/creat_trip_repo.dart';
import 'package:journeyX/utils/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: camel_case_types
class expencesPage extends StatefulWidget {
  const expencesPage({super.key});

  @override
  State<expencesPage> createState() =>
      _expencesPageState();
}

// ignore: camel_case_types
class _expencesPageState extends State<expencesPage> {
  final dayClass = DayClasses();
  final degreeClass = DegreeClass();

  // ignore: strict_top_level_inference
  get selectedDayIndex => null;

  // ✅ ADDED: WhatsApp open function
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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;

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
          text: 'Trip Details',
          fontSize: 16,
          color: AppColors.black,
          fw: FontWeight.w600,
        ),
        actions: const [Icon(Icons.more_vert_outlined)],
      ),
      body: Expanded(
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
                          Icon(Icons.wb_cloudy_outlined, color: AppColors.grey),
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

                    SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          // Show loader while opening WhatsApp
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );

                          // Launch WhatsApp
                          final Uri whatsappUrl = Uri.parse(
                            'https://wa.me/923288898341?text=${Uri.encodeComponent("Hello! I want to join this trip 😊")}',
                          );

                          try {
                            await launchUrl(
                              whatsappUrl,
                              mode: LaunchMode.externalApplication,
                            );
                          } catch (e) {
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Unable to open WhatsApp'),
                              ),
                            );
                          }

                          // ignore: use_build_context_synchronously
                          Navigator.pop(context); // Close loader
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.blueascent, // Button color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: Icon(Icons.message, color: Colors.white),
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

                    SizedBox(height: screenheight * 0.07),
                    ListTile(
                      leading: popintext(
                        text: 'Expenses',
                        fontSize: 16,
                        color: AppColors.black,
                        fw: FontWeight.w600,
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

                    



                    SizedBox(height: screenheight * 0.13),
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
