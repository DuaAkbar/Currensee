class NewsModel {
  final String title;
  final String text;
  final String image;
  final String url;
  final String publishedDate;

  NewsModel({
    required this.title,
    required this.text,
    required this.image,
    required this.url,
    required this.publishedDate,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json['title'],
      text: json['text'],
      image: json['image'],
      url: json['url'],
      publishedDate: json['publishedDate'],
    );
  }
}
