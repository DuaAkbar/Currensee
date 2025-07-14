import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../models/exchaneRate_model.dart';
import '../utils/Helpers.dart';

class ExchangeratelistController extends GetxController {
  final apiKey = '6c79582a79a72f143b5775c4';

  final storage = GetStorage();
  var isLoading = false.obs;
  var selectedCurrency = ''.obs;
  var amount = 1.0.obs;
  var exchangeRates = <String, double>{}.obs;

  final List<String> currencies = [
    "USD",
    "EUR",
    "GBP",
    "JPY",
    "CAD",
    "AUD",
    "PKR",
    "INR",
    "CNY",
    "CHF",
    "SGD",
    "AED",
    "SAR",
    "TRY",
    "RUB",
    "THB",
    "MYR",
    "KRW",
    "BRL",
    "ZAR",
  ];

  @override
  void onInit() {
    super.onInit();
    selectedCurrency.value = storage.read('default_currency') ?? 'PKR';
    fetchRates();
  }

  Future<void> fetchRates() async {
    try {
      isLoading.value = true;
      final url =
          "https://v6.exchangerate-api.com/v6/$apiKey/latest/${selectedCurrency.value}";
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final model = ExchangeRateResponse.fromJson(data);
        exchangeRates.value = model.conversionRates;
      } else {
        Helpers.showCustomSnackBar("Error", "Failed to fetch rates");
      }
    } catch (e) {
      Helpers.showCustomSnackBar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  double convertTo(String targetCurrency) {
    final rate = exchangeRates[targetCurrency] ?? 1.0;
    return amount.value * rate;
  }

  void UpdateCurrency(String newCurrency) {
    selectedCurrency.value = newCurrency;
    storage.write('default_currency', newCurrency);
    fetchRates();
  }
}
