import 'package:flutter/material.dart';
import 'package:journey_x/lib/classes/day_classes.dart';
import 'package:journey_x/lib/classes/degree_class.dart';
import 'package:journey_x/lib/components/inter_text.dart';
import 'package:journey_x/lib/components/popin_text.dart';
import 'package:journey_x/lib/practise/watsapp_service.dart';
import 'package:journey_x/lib/repository/creat_trip_repo.dart';
import 'package:journey_x/lib/utils/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState ();
}

class _WeatherPageState extends State<WeatherPage> {
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
          text: 'Weather Page',
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
                                color: Color.fromARGB(83, 191, 216, 249),
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
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
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
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
                    ),

                    ListTile(
                      onTap: () async {
                        // Optional loader for better UX
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) =>
                              const Center(child: CircularProgressIndicator()),
                        );

                        await WhatsAppService.openChat(
                          context: context,
                          phone: '923288898341', // Replace with guider's number
                          message: 'Hello! I want to join the trip 😊',
                        );

                        // ignore: use_build_context_synchronously
                        Navigator.pop(context); // Close loader
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
