import 'package:curren_see/controllers/settings_controller.dart';
import 'package:curren_see/services/navigation_services.dart';
import 'package:curren_see/utils/Helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  SettingsController settingsController = Get.put(SettingsController());
  NavigationServices navigationServices = Get.find<NavigationServices>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(
            fontSize: 35,
            fontFamily: 'DancingScript',
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.offNamed("/");
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: [
          ListTile(
            onTap: () {
              Helpers.showConfirmationDialogue(
                "Are you Sure?",
                "This action will log you out from the App",
                () {
                  settingsController.logout();
                },
              );
            },
            title: Text(
              "Logout",
              style: TextStyle(
                fontFamily: 'DancingScript',
                fontWeight: FontWeight.w400, // 500 is for Medium
                fontSize: 24,
              ),
            ),
            leading: Icon(Icons.logout),
            trailing: Icon(Icons.arrow_forward),
          ),

          ListTile(
            onTap: () {
              Get.toNamed("/faq");
            },
            title: Text(
              "FAQ",
              style: TextStyle(
                fontFamily: 'DancingScript',
                fontWeight: FontWeight.w400, // 500 is for Medium
                fontSize: 24,
              ),
            ),
            leading: Icon(Icons.question_answer),
            trailing: Icon(Icons.arrow_forward),
          ),

          ListTile(
            onTap: () {
              Get.toNamed("/contact");
            },
            title: Text(
              "Contact Us",
              style: TextStyle(
                fontFamily: 'DancingScript',
                fontWeight: FontWeight.w400, // 500 is for Medium
                fontSize: 24,
              ),
            ),
            leading: Icon(Icons.phone),
            trailing: Icon(Icons.arrow_forward),
          ),

          ListTile(
            onTap: () {
              Get.toNamed("/userPreference");
            },
            title: Text(
              "User Preference",
              style: TextStyle(
                fontFamily: 'DancingScript',
                fontWeight: FontWeight.w400, // 500 is for Medium
                fontSize: 24,
              ),
            ),
            leading: Icon(Icons.verified_user_sharp),
            trailing: Icon(Icons.arrow_forward),
          ),
        ],
      ),
    );
  }
}
