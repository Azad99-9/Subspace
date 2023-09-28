class Article {
  String paperName;
  String authorName;
  String title;
  String description;
  String articleUrl;
  String imageurl;
  String date;
  String content;

  Article({
    required this.paperName,
    required this.authorName,
    required this.title,
    required this.description,
    required this.articleUrl,
    required this.imageurl,
    required this.date,
    required this.content,
  });

  // Convert Article object to JSON
  Map<String, dynamic> toJson() {
    return {
      'paperName': paperName ,
      'authorName': authorName ,
      'title': title ,
      'description': description ,
      'articleUrl': articleUrl,
      'imageurl': imageurl ,
      'date': date ,
      'content': content ,
    };
  }

  // Create an Article object from JSON
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      paperName: json['source']['name'],
      authorName: json['author'] ?? '',
      title: json['title']  ?? '',
      description: json['description'] ?? '',
      articleUrl: json['url'] ?? '',
      imageurl: json['urlToImage'] ?? '',
      date: json['publishedAt'] ?? '',
      content: json['content'] ?? '',
    );
  }

   @override
  String toString() {
    return 'Article {'
        'paperName: $paperName, '
        'authorName: $authorName, '
        'title: $title, '
        'description: $description, '
        'articleUrl: $articleUrl, '
        'imageurl: $imageurl, '
        'date: $date, '
        'content: $content'
        '}';
  }
}
