import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class SupabaseService extends GetxService {
  static final SupabaseClient client = Supabase.instance.client;

@override
  Future<void> onInit() async {
    await Supabase.initialize(
      url: "https://ydvnzsxlvaegobqluqep.supabase.co",
      anonKey:"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inlkdm56c3hsdmFlZ29icWx1cWVwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTE1NjcxMTQsImV4cCI6MjA2NzE0MzExNH0.SvbBaG1DEAwtRePf979ib1mqbcl8mK1OwyCXhehyWRM",
    );
    
    super.onInit();
  }
   
}
