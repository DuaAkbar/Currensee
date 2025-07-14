import 'package:curren_see/services/supabase_service.dart';
import 'package:curren_see/utils/Helpers.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  Future<void> register(
    String userName,
    String userEmail,
    String userPassword,
  ) async {
    try {
      // print("✅ Attempting Registration:");
      // print("📧 Email: $userEmail");
      // print("👤 Name: $userName");
      // print("🔑 Password: $userPassword");

      final AuthResponse response = await SupabaseService.client.auth.signUp(
        email: userEmail,
        password: userPassword,
        data: {"name": userName},
      );

      if (response.user != null) {
        Helpers.showCustomSnackBar(
          "Congratulations!!",
          "You have been Registered Succesfully",
        );
        Get.offAllNamed("/login");
      }
    } on AuthException catch (e) {
      Helpers.showCustomSnackBar("Error", e.message);
    }
  }

  Future<void> login(String userEmail, String userPassword) async {
    try {
      isLoading.value = true;

      final AuthResponse response = await SupabaseService.client.auth
          .signInWithPassword(email: userEmail, password: userPassword);

      if (response.user != null) {
        Helpers.showCustomSnackBar("Sucess", "Logged In Sucessfully");
        Get.offAllNamed("/");
      } else {
        Helpers.showCustomSnackBar("Error", "log in failed");
      }
    } on AuthException catch (e) {
      Helpers.showCustomSnackBar("Error", e.message);

    }
  }
}
