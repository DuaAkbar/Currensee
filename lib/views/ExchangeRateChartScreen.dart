import 'dart:math';

import 'package:curren_see/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class ExchangeRateChartScreen extends StatefulWidget {
  @override
  _ExchangeRateScreenState createState() => _ExchangeRateScreenState();
}

class _ExchangeRateScreenState extends State<ExchangeRateChartScreen> {
  NavigationServices navigationServices = Get.find<NavigationServices>();
  // Controller variables
  String baseCurrency = 'USD';
  String targetCurrency = 'EUR';
  double currentRate = 0.0;
  List<RateData> historicalRates = [];
  bool isLoading = false;
  DateTime selectedDate = DateTime.now();

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

  final String apiUrl = "https://api.exchangerate-api.com/v4/latest/";

  @override
  void initState() {
    super.initState();
    fetchExchangeRate();
  }

  // Fetch current exchange rate
  Future<void> fetchExchangeRate() async {
    setState(() => isLoading = true);
    try {
      final response = await http.get(Uri.parse('$apiUrl$baseCurrency'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          currentRate = data['rates'][targetCurrency]?.toDouble() ?? 0.0;
        });
        generateHistoricalData(
          data['rates'][targetCurrency]?.toDouble() ?? 0.0,
        );
      }
    } catch (e) {
      print('Error fetching exchange rate: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  // Generate mock historical data
  void generateHistoricalData(double currentRate) {
    final now = DateTime.now();
    final random = Random(currentRate.toInt());

    List<RateData> tempData = [];
    for (int i = 12; i >= 1; i--) {
      final date = DateTime(now.year, now.month - i, 1);
      final rate = currentRate * (0.9 + random.nextDouble() * 0.2);
      tempData.add(RateData(date, rate));
    }

    setState(() {
      historicalRates = tempData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Exchange Rate Information',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 35,
            fontFamily: 'DancingScript',
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            navigationServices.currentPage.value =
                navigationServices.previousPage.value;
          },
          icon: Icon(Icons.arrow_back),
        ),
        centerTitle: true,
      ),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Currency selection dropdowns
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("From", style: TextStyle(fontSize: 16)),
                              DropdownButtonFormField<String>(
                                value: baseCurrency,
                                items:
                                    currencies
                                        .map(
                                          (currency) => DropdownMenuItem(
                                            value: currency,
                                            child: Text(currency),
                                          ),
                                        )
                                        .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    baseCurrency = value!;
                                  });
                                  fetchExchangeRate();
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: BorderSide(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      width: 2.0,
                                      strokeAlign: BorderSide.strokeAlignInside,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("To", style: TextStyle(fontSize: 16)),
                              DropdownButtonFormField<String>(
                                value: targetCurrency,
                                items:
                                    currencies
                                        .map(
                                          (currency) => DropdownMenuItem(
                                            value: currency,
                                            child: Text(currency),
                                          ),
                                        )
                                        .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    targetCurrency = value!;
                                  });
                                  fetchExchangeRate();
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: BorderSide(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      width: 2.0,
                                      strokeAlign: BorderSide.strokeAlignInside,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    // Current rate display
                    Center(
                      child: Text(
                        '1 $baseCurrency = ${currentRate.toStringAsFixed(4)} $targetCurrency',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'As of ${DateFormat('MMM d, y').format(selectedDate)}',
                      style: TextStyle(color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30),

                    // Chart title
                    Text(
                      'Historical Rates (Last 12 Months)',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 25,
                        fontFamily: 'DancingScript',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: SfCartesianChart(
                        plotAreaBackgroundColor: Colors.transparent,
                        primaryXAxis: DateTimeAxis(
                          dateFormat: DateFormat.MMM(),
                          intervalType: DateTimeIntervalType.months,
                          interval: 2,
                          majorGridLines: MajorGridLines(width: 0),
                        ),
                        primaryYAxis: NumericAxis(
                          title: AxisTitle(text: 'Exchange Rate'),
                          majorGridLines: MajorGridLines(
                            color: Colors.grey.withOpacity(0.3),
                          ),
                          axisLine: AxisLine(width: 0),
                        ),
                        tooltipBehavior: TooltipBehavior(
                          enable: true,
                          builder: (
                            dynamic data,
                            dynamic point,
                            dynamic series,
                            int pointIndex,
                            int seriesIndex,
                          ) {
                            final rateData = data as RateData;
                            return Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              child: Text(
                                '${DateFormat('MMM y').format(rateData.date)}\nRate: ${rateData.rate.toStringAsFixed(4)}',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                            );
                          },
                        ),
                        series: <CartesianSeries<RateData, DateTime>>[
                          LineSeries<RateData, DateTime>(
                            dataSource: historicalRates,
                            xValueMapper: (RateData rate, _) => rate.date,
                            yValueMapper: (RateData rate, _) => rate.rate,
                            color: Theme.of(context).colorScheme.primary,
                            width: 3,
                            animationDuration: 2000,
                            markerSettings: MarkerSettings(
                              isVisible: true,
                              shape: DataMarkerType.circle,
                              borderWidth: 2,
                              borderColor:
                                  Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}

class RateData {
  final DateTime date;
  final double rate;

  RateData(this.date, this.rate);
}

// Random number generator helper
class Random {
  final int seed;

  Random(this.seed);

  double nextDouble() {
    var x = sin(seed * 1000.0) * 10000.0;
    return x - x.floor();
  }
}
