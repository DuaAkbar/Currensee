import 'package:curren_see/services/supabase_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final subjectController = TextEditingController();
  final messageController = TextEditingController();
  var isLoading = false.obs;
  var errorMessage = "".obs;

  Future<void> submitContactForm() async {
    errorMessage.value = "";
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        subjectController.text.isEmpty ||
        messageController.text.isEmpty) {
      errorMessage.value = "Please fill all fields";
      return;
    }

    isLoading.value = true;

    try {
      final userId = SupabaseService.client.auth.currentUser?.id;
      if (userId != null) {
        await SupabaseService.client.from("contacts").insert({
          "user_id": userId,
          "name": nameController.text.trim(),
          "email": emailController.text.trim(),
          "subject": subjectController.text.trim(),
          "message": messageController.text.trim(),
          "created_at": DateTime.now().toIso8601String(),
        });
      }

      clearForm();
    } catch (e) {
      errorMessage.value = "Error submitting form: ${e.toString()}";
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> clearForm() async {
    nameController.clear();
    emailController.clear();
    subjectController.clear();
    messageController.clear();
  }

  // Open default email app with pre-filled recipient
  Future<void> openGmail() async {
    final Uri gmailUri = Uri(
      scheme: "https",
      host: "mail.google.com",
      path: "/mail/u/0",
      queryParameters: {
        "view": "cm",
        'to': 'support@currensee.app',
        'su': 'Support Request',
        'body': 'Hello, I need help with...',
      },
    );

    if (await canLaunchUrl(gmailUri)) {
      await launchUrl(gmailUri);
    } else {
      final Uri fallbackUri = Uri(
        scheme: 'mailto',
        path: 'support@currensee.app',
        queryParameters: {
          'subject': 'Support Request',
          'body': 'Hello, I need help with...',
        },
      );
      await launchUrl(fallbackUri);
    }
  }

  // Open phone dialer with pre-filled number
  Future<void> launchPhone() async {
    final Uri phoneUri = Uri(scheme: 'tel', path: '(021)34980576');

    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not launch phone dialer';
}
}
}