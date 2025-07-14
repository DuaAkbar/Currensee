import 'package:curren_see/services/supabase_service.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  Future<void> logout() async {
   await  SupabaseService.client.auth.signOut();
    Get.offAllNamed("/login");
  }
}
