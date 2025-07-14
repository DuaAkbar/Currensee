import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/news_model.dart';

class NewsController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<NewsModel> newsList = <NewsModel>[].obs;

  @override
  void onInit() {
    fetchNews();
    super.onInit();
  }

  void fetchNews() async {
    try {
      isLoading(true);

      final url = Uri.parse(
        'https://gnews.io/api/v4/search?q=currency&lang=en&apikey=4febce9dabd093024e253066b9b9a644',
      );

      final response = await http.get(url);

      print(" API RESPONSE STATUS: ${response.statusCode}");
      print(" BODY: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        final List<dynamic> articles = jsonData['articles'];

        newsList.value =
            articles
                .map(
                  (e) => NewsModel.fromJson({
                    "title": e["title"] ?? "",
                    "text": e["description"] ?? "",
                    "image": e["image"] ?? "",
                    "url": e["url"] ?? "",
                    "publishedDate": e["publishedAt"] ?? "",
                  }),
                )
                .toList();
      } else {
        print(" Failed to load data");
      }
    } catch (e) {
      print(" ERROR: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
