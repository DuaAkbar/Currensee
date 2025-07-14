import 'package:curren_see/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final NavigationServices navigationServices = Get.put(NavigationServices());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: navigationServices.pages[navigationServices.currentPage.value],
        bottomNavigationBar: NavigationBar(
          height: 60,
          selectedIndex: navigationServices.currentPage.value,
          onDestinationSelected: (value) {
            navigationServices.updateindex(value);
          },
          destinations: [
            NavigationDestination( icon: Icon(Icons.currency_exchange), label: ""),
            NavigationDestination(icon: Icon(Icons.newspaper), label: ""),
            NavigationDestination(icon: Icon(Icons.bar_chart), label: ""),
            NavigationDestination(icon: Icon(Icons.monetization_on), label: ""),
            NavigationDestination(icon: Icon(Icons.settings), label: ""),
          ],
        ),
      ),
    );
  }
}
