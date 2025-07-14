import "package:curren_see/services/supabase_service.dart";
import "package:curren_see/utils/Helpers.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:get_storage/get_storage.dart";
import "package:http/http.dart" as http;
import "dart:convert";

class ConversionController extends GetxController {
  final amountController = TextEditingController();

  final storage = GetStorage();
  var amount = 0.0.obs;
  var fromCurrency = "USD".obs;
  var toCurrency = "".obs;
  var conversionRate = 0.0.obs;
  var convertedAmount = 0.0.obs;
  var isLoading = false.obs;
  var errorMessage = "".obs;

  final String apiUrl = "https://api.exchangerate-api.com/v4/latest/";

  var conversionHistory = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    toCurrency.value = storage.read('default_currency') ?? 'EUR';
    loadConversionHistory();
  }

  @override
  void onClose() {
    amountController.dispose();
    super.onClose();
  }

  Future<void> convertCurrency() async {
    if (amountController.text.isEmpty) {
      errorMessage.value = "Please enter an amount";
      return;
    }

    isLoading.value = true;
    errorMessage.value = "";

    try {
      amount.value = double.parse(amountController.text);

      final response = await http.get(
        Uri.parse("$apiUrl${fromCurrency.value}"),
      );
      if (response.statusCode != 200) {
        throw Exception("Failed to fetch exchange rates");
      }

      final data = jsonDecode(response.body);
      final rates = data["rates"] as Map<String, dynamic>;
      conversionRate.value = rates[toCurrency.value]?.toDouble() ?? 0.0;

      if (conversionRate.value == 0.0) {
        throw Exception("Invalid conversion rate");
      }

      convertedAmount.value = amount.value * conversionRate.value;

      // Save to Supabase
      final userId = SupabaseService.client.auth.currentUser?.id;
      if (userId != null) {
        await SupabaseService.client.from("conversion_history").insert({
          "user_id": userId,
          "amount": amount.value,
          "from_currency": fromCurrency.value,
          "to_currency": toCurrency.value,
          "rate": conversionRate.value,
          "converted_amount": convertedAmount.value,
        });
      }
      // Reload history
      await loadConversionHistory();
    } catch (e) {
      errorMessage.value = "Conversion failed: $e";
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadConversionHistory() async {
    try {
      final userId = SupabaseService.client.auth.currentUser?.id;
      if (userId == null) return;

      final response = await SupabaseService.client
          .from("conversion_history")
          .select()
          .eq("user_id", userId)
          .order("created_at", ascending: false)
          .limit(10);

      conversionHistory.value = List<Map<String, dynamic>>.from(response);
    } catch (e) {
      errorMessage.value = "Failed to load history: $e.";
    }
  }

  void updateToCurrency(String newCurrency) {
    toCurrency.value = newCurrency;
    storage.write('default_currency', newCurrency);
    Helpers.showCustomSnackBar(
      "Congratulations!",
      "Your currency has been saved to default mode",
    );
    
  }
}
