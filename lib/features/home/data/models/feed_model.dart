import 'package:noviindus_test/features/home/domain/entities/feed_entity.dart';

class FeedModel extends FeedEntity {
  const FeedModel({
    required super.id,
    required super.description,
    required super.thumbnail,
    required super.videoUrl,
    required super.userName,
    required super.userImage,
    required super.createdAt,
  });

  factory FeedModel.fromJson(Map<String, dynamic> json) {
    return FeedModel(
      id: json['id'],
      description: json['description'] ?? '',
      thumbnail: json['image'] ?? '',
      videoUrl: json['video'] ?? '',
      createdAt: json['created_at'] ?? '',
      userName: json['user']?['name'] ?? 'Unknown',
      userImage: json['image'],
    );
  }
}
