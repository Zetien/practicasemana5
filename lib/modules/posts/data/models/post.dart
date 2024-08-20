import 'dart:convert';

List<Post> postFromJson(String str) => List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postToJson(List<Post> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
    final int userId;
    final int id;
    final String title;
    final String body;

    Post({
        required this.userId,
        required this.id,
        required this.title,
        required this.body,
    });

    Post copyWith({
        int? userId,
        int? id,
        String? title,
        String? body,
    }) => 
        Post(
            userId: userId ?? this.userId,
            id: id ?? this.id,
            title: title ?? this.title,
            body: body ?? this.body,
        );

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
    };

  @override
  String toString() {
  return 'Post(id: $id, title: "$title", body: "$body", userId: $userId)';
  }
}
