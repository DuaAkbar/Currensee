import 'package:curren_see/services/navigation_services.dart';
import 'package:curren_see/services/supabase_service.dart';
import 'package:curren_see/widgets/pageroute.dart';
import 'package:curren_see/widgets/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(SupabaseService());
  Get.put(NavigationServices());
  await GetStorage.init();
  runApp(Currensee());
}

class Currensee extends StatelessWidget {
  const Currensee({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: mytheme,
      getPages: appRoute,
      initialRoute: "/login",
    );
  }
}
