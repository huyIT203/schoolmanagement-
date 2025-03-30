class NewsModel {
  final int id;
  final String title;
  final String content;
  final String author;
  final String publishedDate;
  final String imageUrl;

  NewsModel({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.publishedDate,
    required this.imageUrl,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      author: json['author'],
      publishedDate: json['publishedDate'],
      imageUrl: json['imageUrl'],
    );
  }
}
