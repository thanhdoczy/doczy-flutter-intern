import 'dart:convert';

import 'package:hive/hive.dart';

part 'post.g.dart';
Post PostFromJson(String str) => Post.fromJson(json.decode(str));

String PostToJson(Post data) => json.encode(data.toJson());
@HiveType(typeId: 1)
class Post {
  Post({
    required this.storyId,
    required this.title,
    required this.summary,
    required this.modifiedAt,
    required this.image,
  });

  @HiveField(0)
  final int storyId;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String summary;
  @HiveField(3)
  final DateTime modifiedAt;
  @HiveField(4)
  final String image;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        storyId: json["storyId"],
        title: json["title"],
        summary: json["summary"],
        modifiedAt: DateTime.parse(json["modifiedAt"]),
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "storyId": storyId,
        "title": title,
        "summary": summary,
        "modifiedAt": modifiedAt.toIso8601String(),
        "image": image,
      };
}
