class Category {
  final String id;
  final String title;

  const Category({
    required this.id,
    required this.title,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json['id'] as String,
        title: json['title'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
      };
}
