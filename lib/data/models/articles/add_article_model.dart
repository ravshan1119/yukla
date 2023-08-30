class AddArticleModel {
  String image;
  String title;
  String description;
  String hashtag;

  AddArticleModel({
    required this.image,
    required this.title,
    required this.description,
    required this.hashtag,
  });

  AddArticleModel copyWith({
    String? image,
    String? title,
    String? description,
    String? hashtag,
  }) =>
      AddArticleModel(
        image: image ?? this.image,
        title: title ?? this.title,
        description: description ?? this.description,
        hashtag: hashtag ?? this.hashtag,
      );

  factory AddArticleModel.fromJson(Map<String, dynamic> json) => AddArticleModel(
    image: json["image"] as String? ?? "",
    title: json["title"] as String? ?? "",
    description: json["description"] as String? ?? "",
    hashtag: json["hashtag"] as String? ?? "",
  );

  Map<String, dynamic> toJson() => {
    "image": image,
    "title": title,
    "description": description,
    "hashtag": hashtag,
  };
}
