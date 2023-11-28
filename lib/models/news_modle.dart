class NewsModel {
  final String id;
  String title;
  String imgUrl;
  String url;
  NewsModel({
    required this.id,
    required this.title,
    required this.imgUrl,
    required this.url,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'imgUrl': imgUrl,
      'url': url,
    };
  }

  factory NewsModel.fromMap(Map<String, dynamic> map, String documentId) {
    return NewsModel(
      id: documentId,
      title: map['title'] ?? '',
      imgUrl: map['imgUrl'] ?? '',
      url: map['url'] ?? '',
    );
  }
}
