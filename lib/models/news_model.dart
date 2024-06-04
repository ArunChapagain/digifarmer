class NewsModel {
  const NewsModel({
    int? id,
    String? author,
    String? title,
    String? description,
    String? urlToImage,
    String? publishedAt,
    String? content,
  });

  factory NewsModel.fromJson(Map<String, dynamic> map) {
    return NewsModel(
      author: map['author'] ?? "",
      title: map['title'] ?? "",
      description: map['description'] ?? "",
      urlToImage: map['urlToImage'] ?? "",
      publishedAt: map['publishedAt'] ?? "",
      content: map['content'] ?? "",
    );
  }
}
