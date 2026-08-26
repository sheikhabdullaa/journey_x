import 'package:flutter/material.dart';
import 'package:journey_x/lib/practise/watsapp_service.dart';

class Watsppractise extends StatelessWidget {
  const Watsppractise({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Join Trip')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Optional loader (UX like Foodpanda)
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(child: CircularProgressIndicator()),
            );

            await WhatsAppService.openChat(
              context: context,
              phone: '923336988873',
              message: 'Hello! I want to join this trip 😊',
            );

            // ignore: use_build_context_synchronously
            Navigator.pop(context); // close loader
          },
          child: const Text('Join via WhatsApp'),
        ),
      ),
    );
  }
}
