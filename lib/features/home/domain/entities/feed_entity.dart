class FeedEntity {
  final int id;
  final String description;
  final String thumbnail;
  final String videoUrl;
  final String userName;
  final String? userImage;
  final String createdAt;

  const FeedEntity({
    required this.id,
    required this.description,
    required this.thumbnail,
    required this.videoUrl,
    required this.userName,
    required this.userImage,
    required this.createdAt,
  });
}
