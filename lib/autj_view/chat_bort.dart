// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// import 'package:turist_app/components/popin_text.dart';
// import 'package:turist_app/utils/app_colors.dart';

// class ChatBort extends StatefulWidget {
//   const ChatBort({super.key});

//   @override
//   State<ChatBort> createState() => _ChatBortState();
// }

// class _ChatBortState extends State<ChatBort> {
//   final TextEditingController chatcontroller = TextEditingController();

//   List<Map<String, dynamic>> messages = [];
//   bool isLoading = false;

//   static const String baseUrl = "http://192.168.43.172:5000/api/chat";
//   Future<void> sendMessage() async {
//     final text = chatcontroller.text.trim();
//     if (text.isEmpty || isLoading) return;

//     setState(() {
//       messages.add({"message": text, "isUser": true});
//       isLoading = true;
//     });

//     chatcontroller.clear();

//     try {
//       final response = await http
//           .post(
//             Uri.parse(baseUrl),
//             headers: {"Content-Type": "application/json"},
//             body: jsonEncode({"query": text}),
//           )
//           .timeout(const Duration(seconds: 10));

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);

//         setState(() {
//           messages.add({
//             "message": data["answer"] ?? "No response",
//             "isUser": false,
//           });
//         });
//       } else {
//         setState(() {
//           messages.add({
//             "message": "Server Error: ${response.statusCode}",
//             "isUser": false,
//           });
//         });
//       }
//     } catch (e) {
//       setState(() {
//         messages.add({
//           "message": "Connection failed. Server not responding.",
//           "isUser": false,
//         });
//       });
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   void dispose() {
//     chatcontroller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: const Icon(Icons.arrow_back),
//         ),
//         titleSpacing: screenWidth * 0.2,
//         title: popintext(
//           text: 'Chat Bot',
//           fontSize: 16,
//           color: AppColors.black,
//           fw: FontWeight.w600,
//         ),
//         actions: const [Icon(Icons.more_vert_outlined)],
//       ),

//       body: Column(
//         children: [
//           /// CHAT LIST
//           Expanded(
//             child: ListView.builder(
//               padding: const EdgeInsets.all(15),
//               itemCount: messages.length,
//               itemBuilder: (context, index) {
//                 final msg = messages[index];

//                 return Align(
//                   alignment: msg["isUser"]
//                       ? Alignment.centerRight
//                       : Alignment.centerLeft,
//                   child: Container(
//                     margin: const EdgeInsets.only(bottom: 10),
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 14,
//                       vertical: 12,
//                     ),
//                     constraints: BoxConstraints(maxWidth: screenWidth * 0.75),
//                     decoration: BoxDecoration(
//                       color: msg["isUser"]
//                           ? AppColors.blueascent
//                           : Colors.grey.shade300,
//                       borderRadius: BorderRadius.circular(14),
//                     ),
//                     child: Text(
//                       msg["message"],
//                       style: TextStyle(
//                         color: msg["isUser"] ? Colors.white : Colors.black,
//                         fontSize: 15,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),

//           /// LOADING INDICATOR
//           if (isLoading)
//             const Padding(
//               padding: EdgeInsets.only(bottom: 8),
//               child: CircularProgressIndicator(),
//             ),

//           /// INPUT BOX
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextFormField(
//                     controller: chatcontroller,
//                     textInputAction: TextInputAction.send,
//                     onFieldSubmitted: (_) => sendMessage(),
//                     decoration: InputDecoration(
//                       hintText: 'Ask anything...',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(14),
//                       ),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(width: 8),

//                 Container(
//                   height: screenHeight * 0.07,
//                   width: screenWidth * 0.15,
//                   decoration: BoxDecoration(
//                     color: AppColors.blueascent,
//                     borderRadius: BorderRadius.circular(14),
//                   ),
//                   child: IconButton(
//                     onPressed: sendMessage,
//                     icon: const Icon(Icons.arrow_upward, color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
