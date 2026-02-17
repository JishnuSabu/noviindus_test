import 'package:noviindus_test/features/home/data/repositories/add_feed_repository.dart';

class AddFeedUseCase {
  final AddFeedRepository repository;

  AddFeedUseCase(this.repository);

  Future<void> call({
    required String videoPath,
    required String imagePath,
    required String desc,
    required List<int> categoryIds,
    required String token,
    required Function(double progress) onProgress,
  }) {
    return repository.uploadFeed(
      videoPath: videoPath,
      imagePath: imagePath,
      desc: desc,
      categoryIds: categoryIds,
      token: token,
      onProgress: onProgress,
    );
  }
}
