import 'package:curren_see/home/conversion_screen.dart';
import 'package:curren_see/views/ExchangeRateChartScreen.dart';
import 'package:curren_see/views/FAQ/faq_screen.dart';
import 'package:curren_see/views/contact_screen.dart';
import 'package:curren_see/views/exchangeRateListpage.dart';
import 'package:curren_see/views/news_screen.dart';
import 'package:curren_see/views/settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationServices extends GetxService {
  var currentPage = 0.obs;
  var previousPage = 0.obs;

  List<Widget> pages = [ConversionScreen(), NewsScreen(), ExchangeRateChartScreen(), Exchangeratelistpage(), Settings(), FAQScreen(), ContactPage()];

  void updateindex(int index) {
    previousPage.value = currentPage.value;
    currentPage.value = index;  
  }
}
