import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsAppService {
  static Future<void> openChat({
    required BuildContext context,
    required String phone,
    String message = '',
  }) async {

    // Basic validation
    if (phone.isEmpty || phone.length < 10) {
      _showError(context, 'Invalid WhatsApp number');
      return;
    }

    final Uri uri = Uri.parse(
      'https://wa.me/$phone?text=${Uri.encodeComponent(message)}',
    );

    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched) {
        throw 'Launch failed';
      }
    } catch (e) {
      _showError(
        // ignore: use_build_context_synchronously
        context,
        Platform.isIOS
            ? 'Please install WhatsApp from App Store'
            : 'Please install WhatsApp from Play Store',
      );
    }
  }

  static void _showError(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }
}
