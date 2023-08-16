class Blog {
  String? BlogId;
  String? author;
  String? title;
  String? description;
  String? category;
  String? date;
  String? pictureURL;

  Blog({
    this.BlogId,
    this.author,
    this.title,
    this.description,
    this.category,
    this.date,
    this.pictureURL,
  });

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      BlogId: json['_id'],
      author: json['blog_author'],
      title: json['blog_title'],
      description: json['blog_description'],
      category: json['blog_category'],
      date: json['date'],
      pictureURL: json['picture_url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = BlogId;
    data['author'] = author;
    data['blog_title'] = title;
    data['description'] = description;
    data['category'] = category;
    data['date'] = date;
    data['picture_url'] = pictureURL;
    return data;
  }
}
