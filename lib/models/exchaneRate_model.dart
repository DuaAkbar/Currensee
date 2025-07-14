class ExchangeRateResponse {
  final String result;
  final String baseCode;
  final Map<String, double> conversionRates;

  ExchangeRateResponse({
    required this.result,
    required this.baseCode,
    required this.conversionRates,
  });

  factory ExchangeRateResponse.fromJson(Map<String, dynamic> json) {
    final rates = Map<String, double>.from(
      (json['conversion_rates'] as Map<String, dynamic>)
          .map((k, v) => MapEntry(k, (v as num).toDouble())),
    );

    return ExchangeRateResponse(
      result: json['result'] ?? '',
      baseCode: json['base_code'] ?? '',
      conversionRates: rates,
    );
  }
}
