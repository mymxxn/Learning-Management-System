class CourseModel {
  String? id;
  String? title;
  String? description;
  String? imageUrl;

  CourseModel({
    this.id,
    this.title,
    this.description,
    this.imageUrl,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'].toString(),
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
      imageUrl: json['image'] ?? '',
    );
  }
}
