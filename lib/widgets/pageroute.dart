import 'package:curren_see/auth/login.dart';
import 'package:curren_see/auth/register.dart';
import 'package:curren_see/home/HomeScreen.dart';
import 'package:curren_see/home/conversion_screen.dart';
import 'package:curren_see/views/ExchangeRateChartScreen.dart';
import 'package:curren_see/views/FAQ/faq_screen.dart';
import 'package:curren_see/views/contact_screen.dart';
import 'package:curren_see/views/exchangeRateListpage.dart';
import 'package:curren_see/views/news_screen.dart';
import 'package:curren_see/views/settings.dart';
import 'package:curren_see/views/userPreference.dart';
import 'package:get/route_manager.dart';

final List<GetPage> appRoute =[
GetPage(name: "/", page: () => Homescreen()),
GetPage(name: "/register", page: () => Register()),
GetPage(name: "/login", page: () => Login()),
GetPage(name: "/conversion_screen", page: () => ConversionScreen()),
GetPage(name: "/newsScreen", page: () => NewsScreen()), 
GetPage(name: "/chartScreen", page: () => ExchangeRateChartScreen()), 
GetPage(name: "/settings", page: () => Settings()), 
GetPage(name: "/faq", page: () => FAQScreen()), 
GetPage(name: "/contact", page: () => ContactPage()),
GetPage(name: "/currencylist", page: () => Exchangeratelistpage()),  
GetPage(name: "/userPreference", page: () => Userpreference()),  


];
