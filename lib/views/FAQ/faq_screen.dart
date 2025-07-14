import "package:curren_see/widgets/faq_widget/faq_items_widget.dart";
import "package:flutter/material.dart";

class FAQScreen extends StatelessWidget {
  FAQScreen({super.key});

  final List<Map<String, String>> faqs = [
    {
      "question": "How do I convert currencies?",
      "answer":
          "Go to the Convert tab, select your base currency and target currency, then enter the amount. The conversion will happen automatically.",
    },
    {
      "question": "Are exchange rates updated in real-time?",
      "answer":
          "Yes, we update rates every minute from reliable financial data sources. You can also pull down to refresh manually.",
    },
    {
      "question": "Why is there a small difference from bank rates?",
      "answer":
          "Our rates come from interbank markets. Banks typically add a small margin for their services, which explains the difference.",
    },
    {
      "question": "Can I track multiple currencies?",
      "answer":
          "Yes! Use the Watchlist feature to monitor your favorite currencies. Tap the star icon next to any currency to add it.",
    },
    {
      "question": "How accurate are the historical charts?",
      "answer":
          "Our historical data comes directly from central banks and financial institutions, with daily updates for precision.",
    },
    {
      "question": "Is there a limit on conversions?",
      "answer":
          "No, you can convert any amount, but remember these are market rates - actual bank conversions may have limits.",
    },
    {
      "question": "How do I change my base currency?",
      "answer":
          "Go to Settings > Currency Preferences to set your default base currency for all calculations.",
    },
    {
      "question": "Do you support cryptocurrency?",
      "answer":
          "Currently we focus on fiat currencies, but crypto support is coming in our next update!",
    },
    {
      "question": "Why do some currencies show as unavailable?",
      "answer":
          "We temporarily disable currencies during extreme market volatility or when reliable data sources are unavailable.",
    },
    {
      "question": "How do I report an incorrect rate?",
      "answer":
          "Tap the Report button next to any rate, or contact our support team through the app.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(
          "Currency App FAQs",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontFamily: 'DancingScript',
            fontWeight: FontWeight.w700, // 500 is for Medium
            fontSize: 35,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          return FAQItem(
            question: faqs[index]["question"]!,
            answer: faqs[index]["answer"]!,
            isLast: index == faqs.length - 1,
          );
        },
      ),
    );
  }
}
