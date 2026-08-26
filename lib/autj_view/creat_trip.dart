import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:journeyX/active_trip.dart';
import 'package:journeyX/classes/date_picker.dart';
import 'package:journeyX/classes/prson_count.dart';
import 'package:journeyX/components/custom_drop_down.dart';
import 'package:journeyX/components/custom_text_field.dart';
import 'package:journeyX/components/inter_text.dart';
import 'package:journeyX/components/popin_text.dart';
import 'package:journeyX/repository/creat_trip_repo.dart';
import 'package:journeyX/utils/app_colors.dart';
import 'package:random_string/random_string.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreatTrip extends StatefulWidget {
  const CreatTrip({super.key});

  @override
  State<CreatTrip> createState() => _CreatTripState();
}

class _CreatTripState extends State<CreatTrip> {
  // dates
  DateTime? startDate;
  DateTime? endDate;

  // members
  int memberCount = 1;

  // image picker
  File? _image;
  final ImagePicker _picker = ImagePicker();

  // checkboxes
  bool femaleFriends = false;
  bool Public = false;

  // dropdown values (IMPORTANT)
  String? selectedCategory;
  String? selectedTransport;
  String? selectedAccommodation;

  // controllers
  final TextEditingController discriptioncontroller = TextEditingController();
  final TextEditingController destinationcontroller = TextEditingController();
  final TextEditingController budgetecontroller = TextEditingController();
  TextEditingController hotelbookingcontroller = TextEditingController();
  TextEditingController transportcontroller = TextEditingController();
  TextEditingController dinnercontroller = TextEditingController();
  TextEditingController totalspendcontroller = TextEditingController();
  TextEditingController perpersoncontroller = TextEditingController();

  Future<void> pickImage() async {
    final XFile? pickedImage = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      setState(() => _image = File(pickedImage.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        titleSpacing: screenWidth * 0.2,
        title: popintext(
          text: 'Create Trip',
          fontSize: 16,
          color: AppColors.black,
          fw: FontWeight.w600,
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// CHECKBOX
              Row(
                children: [
                  Transform.scale(
                    scale: 1.4,
                    child: Checkbox(
                      shape: CircleBorder(),
                      value: femaleFriends,
                      onChanged: (v) {
                        setState(() {
                          femaleFriends = v!;
                          if (v) Public = false;
                        });
                      },
                    ),
                  ),
                  inter(text: 'Public', fontSize: 14, color: AppColors.black),

                  const SizedBox(width: 20),

                  Transform.scale(
                    scale: 1.4,
                    child: Checkbox(
                      shape: CircleBorder(),

                      // checkColor: AppColors.black,
                      value: Public,
                      onChanged: (v) {
                        setState(() {
                          Public = v!;
                          if (v) femaleFriends = false;
                        });
                      },
                    ),
                  ),
                  inter(
                    text: 'Female Friends',
                    fontSize: 14,
                    color: AppColors.black,
                  ),
                ],
              ),

              SizedBox(height: screenheight * 0.04),

              /// DESTINATION (MAP)
              inter(
                text: 'Destination',
                fontSize: 14,
                color: AppColors.black,
                fw: FontWeight.w400,
              ),
              customTextField(
                hint: 'Where are you going?',
                icon: Icon(Icons.location_pin),
                readOnly: true,
                controller: destinationcontroller,
              ),

              SizedBox(height: screenheight * 0.04),

              /// IMAGE
              inter(
                text: 'Trip Cover',
                fontSize: 14,
                color: AppColors.black,
                fw: FontWeight.w400,
              ),

              InkWell(
                onTap: pickImage,
                child: Container(
                  height: screenheight * 0.25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Color.fromARGB(67, 158, 158, 158),
                    ),
                    image: _image != null
                        ? DecorationImage(
                            image: FileImage(_image!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: _image == null
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_circle_outline_outlined,
                                color: AppColors.grey,
                              ),
                              inter(
                                text: 'Add cover photo',
                                fontSize: 16,
                                color: AppColors.grey,
                                fw: FontWeight.w400,
                              ),
                            ],
                          ),
                        )
                      : null,
                ),
              ),

              SizedBox(height: screenheight * 0.04),

              /// DATES
              inter(
                text: 'Dates',
                fontSize: 16,
                color: AppColors.black,
                fw: FontWeight.w400,
              ),
              Row(
                children: [
                  Expanded(
                    child: DatePickerField(
                      label: 'dd/mm/yy',
                      selectedDate: startDate,
                      onDateChanged: (d) => setState(() => startDate = d),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DatePickerField(
                      label: 'dd/mm/yy',
                      selectedDate: endDate,
                      onDateChanged: (d) => setState(() => endDate = d),
                    ),
                  ),
                ],
              ),

              SizedBox(height: screenheight * 0.04),

              /// DESCRIPTION (FIXED)
              inter(
                text: 'Trip Description',
                fontSize: 14,
                color: AppColors.black,
                fw: FontWeight.w400,
              ),
              Container(
                height: screenheight * 0.25,
                decoration: BoxDecoration(
                  // color: AppColors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color.fromARGB(66, 0, 0, 0)),
                ),
                child: TextFormField(
                  controller: discriptioncontroller,
                  decoration: InputDecoration(
                    hintText: 'Write short description about trip',
                    hintStyle: TextStyle(color: AppColors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(color: AppColors.white, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(color: AppColors.white),
                    ),
                  ),
                ),
              ),

              SizedBox(height: screenheight * 0.04),

              /// MEMBERS
              inter(
                text: 'Travel Members',
                fontSize: 14,
                color: AppColors.black,
                fw: FontWeight.w400,
              ),
              MemberCounter(
                count: memberCount,
                onIncrement: () => setState(() => memberCount++),
                onDecrement: () =>
                    setState(() => memberCount > 1 ? memberCount-- : null),
              ),

              SizedBox(height: screenheight * 0.04),
              // budget astimate
              inter(
                text: 'Budget Estimated',
                fontSize: 14,
                color: AppColors.black,
                fw: FontWeight.w400,
              ),
              customTextField(
                hint: 'Budget estimated',
                controller: budgetecontroller,
                icon: Icon(
                  Icons.monetization_on_outlined,
                  color: AppColors.grey,
                ),
                readOnly: true,
                hintStyle: TextStyle(color: AppColors.grey),
              ),

              SizedBox(height: screenheight * 0.04),

              /// CATEGORY
              inter(
                text: 'Category',
                fontSize: 14,
                color: AppColors.black,
                fw: FontWeight.w400,
              ),
              customDropdownField(
                hint: 'Select trip category',
                items: const [
                  DropdownMenuItem(value: 'Friends', child: Text('Public')),
                  DropdownMenuItem(
                    value: 'Family',
                    child: Text('Female friends'),
                  ),
                  DropdownMenuItem(value: 'Group', child: Text('Group')),
                ],
                onChanged: (v) => selectedCategory = v,
              ),

              SizedBox(height: screenheight * 0.04),

              /// TRANSPORT
              inter(
                text: 'Transport',
                fontSize: 14,
                color: AppColors.black,
                fw: FontWeight.w400,
              ),

              customDropdownField(
                hint: 'Select transport',
                items: const [
                  DropdownMenuItem(value: 'Bus', child: Text('Bus')),
                  DropdownMenuItem(value: 'Car', child: Text('Car')),
                  DropdownMenuItem(value: 'Own Ride', child: Text('Own Ride')),
                ],
                onChanged: (v) => selectedTransport = v,
              ),

              SizedBox(height: screenheight * 0.04),

              /// ACCOMMODATION
              inter(
                text: 'Accommodation',
                fontSize: 14,
                color: AppColors.black,
                fw: FontWeight.w400,
              ),

              customDropdownField(
                hint: 'Select accommodation',
                items: const [
                  DropdownMenuItem(value: 'Room', child: Text('Room')),
                  DropdownMenuItem(value: 'Rooms', child: Text('Rooms')),
                  DropdownMenuItem(value: 'Building', child: Text('Building')),
                ],
                onChanged: (v) => selectedAccommodation = v,
              ),
              SizedBox(height: screenheight * 0.02),

              Container(
                // margin: EdgeInsets.symmetric(vertical: screenheight * 0.02),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),

                  // color: Colors.white,
                ),
                child: ExpansionTile(
                  tilePadding: EdgeInsets.symmetric(horizontal: 16),
                  childrenPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  leading: Icon(
                    Icons.account_balance_wallet,
                    color: AppColors.blueascent,
                  ),
                  title: Text(
                    'Expenses Details',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_down),
                  children: [
                    // 👇👇 AAP KA CODE – NO CHANGE 👇👇
                    SizedBox(height: screenheight * 0.04),
                    customTextField(
                      hint: 'hotel booking expense',
                      controller: hotelbookingcontroller,
                      icon: Icon(Icons.hotel, color: AppColors.grey),
                      readOnly: true,
                      hintStyle: TextStyle(color: AppColors.grey),
                    ),
                    SizedBox(height: screenheight * 0.04),

                    customTextField(
                      hint: 'transportation expense',
                      controller: transportcontroller,
                      icon: Icon(Icons.directions_car, color: AppColors.grey),
                      readOnly: true,
                      hintStyle: TextStyle(color: AppColors.grey),
                    ),
                    SizedBox(height: screenheight * 0.04),

                    customTextField(
                      hint: 'dinner expense',
                      controller: dinnercontroller,
                      icon: Icon(Icons.dinner_dining, color: AppColors.grey),
                      readOnly: true,
                      hintStyle: TextStyle(color: AppColors.grey),
                    ),
                    SizedBox(height: screenheight * 0.04),

                    customTextField(
                      hint: 'Total Spend Expense',
                      controller: totalspendcontroller,
                      icon: Icon(Icons.attach_money, color: AppColors.grey),
                      readOnly: true,
                      hintStyle: TextStyle(color: AppColors.grey),
                    ),
                    SizedBox(height: screenheight * 0.04),

                    customTextField(
                      hint: 'Per Person Expense',
                      controller: perpersoncontroller,
                      icon: Icon(Icons.person, color: AppColors.grey),
                      readOnly: true,
                      hintStyle: TextStyle(color: AppColors.grey),
                    ),
                  ],
                ),
              ),

              // SizedBox(height: screenheight * 0.04),
              // customTextField(
              //   hint: 'hotel booking expence',
              //   controller: hotelbookingcontroller,
              //   icon: Icon(Icons.hotel, color: AppColors.grey),
              //   readOnly: true,
              //   hintStyle: TextStyle(color: AppColors.grey),
              // ),
              // SizedBox(height: screenheight * 0.04),

              // customTextField(
              //   hint: 'transportation expence',
              //   controller: transportcontroller,
              //   icon: Icon(Icons.hotel, color: AppColors.grey),
              //   readOnly: true,
              //   hintStyle: TextStyle(color: AppColors.grey),
              // ),
              // SizedBox(height: screenheight * 0.04),

              // customTextField(
              //   hint: 'dinner expence',
              //   controller: dinnercontroller,
              //   icon: Icon(Icons.dinner_dining, color: AppColors.grey),
              //   readOnly: true,
              //   hintStyle: TextStyle(color: AppColors.grey),
              // ),
              // SizedBox(height: screenheight * 0.04),
              // customTextField(
              //   hint: 'Total Spend Expence',
              //   controller: totalspendcontroller,
              //   icon: Icon(Icons.attach_money, color: AppColors.grey),
              //   readOnly: true,
              //   hintStyle: TextStyle(color: AppColors.grey),
              // ),
              // SizedBox(height: screenheight * 0.04),
              // customTextField(
              //   hint: 'Per Person Expence',
              //   controller: perpersoncontroller,
              //   icon: Icon(Icons.person, color: AppColors.grey),
              //   readOnly: true,
              //   hintStyle: TextStyle(color: AppColors.grey),
              // ),

              /// SAVE BUTTON (FINAL & WORKING)
              SizedBox(height: screenheight * 0.04),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: inter(
                        text: 'Cancel',
                        fontSize: 16,
                        color: AppColors.black,
                        fw: FontWeight.w500,
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          AppColors.blueascent,
                        ),
                      ),
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ActiveTrip()),
                        );
                        final user = FirebaseAuth.instance.currentUser;
                        if (user == null) {
                          Fluttertoast.showToast(msg: "Please login first");
                          return;
                        }

                        String tripId = randomAlphaNumeric(10);

                        await CreatTripRepo().createTrip({
                          'tripId': tripId,
                          'userId': user.uid,
                          'withFamily': femaleFriends,
                          'withFriends': Public,
                          'description': discriptioncontroller.text,
                          'members': memberCount,
                          'category': selectedCategory,
                          'transport': selectedTransport,
                          'accommodation': selectedAccommodation,
                          'startDate': startDate,
                          'endDate': endDate,
                          'createdAt': DateTime.now(),
                          'budgeteastimatr': budgetecontroller.text,
                          'location': destinationcontroller.text,
                          'hotel expence': hotelbookingcontroller.text,
                          'transportation': transportcontroller.text,
                          'dinner expence': dinnercontroller.text,
                          'perperson expence': perpersoncontroller.text,
                          'total spend expence': totalspendcontroller.text,
                        }, tripId);

                        Fluttertoast.showToast(msg: "Trip saved successfully");
                      },
                      child: inter(
                        text: 'Save Trip',
                        fontSize: 16,
                        color: AppColors.white,
                        fw: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
