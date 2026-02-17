abstract class AddFeedRepository {
  Future<void> uploadFeed({
    required String videoPath,
    required String imagePath,
    required String desc,
    required List<int> categoryIds,
    required String token,
    required Function(double progress) onProgress,
  });
}
