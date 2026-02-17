import 'package:noviindus_test/features/home/data/data_sources/add_feed_data_source.dart';
import 'package:noviindus_test/features/home/data/repositories/add_feed_repository.dart';

class AddFeedRepositoryImpl implements AddFeedRepository {
  final AddFeedDataSource dataSource;

  AddFeedRepositoryImpl(this.dataSource);

  @override
  Future<void> uploadFeed({
    required String videoPath,
    required String imagePath,
    required String desc,
    required List<int> categoryIds,
    required String token,
    required Function(double progress) onProgress,
  }) {
    return dataSource.uploadFeed(
      videoPath: videoPath,
      imagePath: imagePath,
      desc: desc,
      categoryIds: categoryIds,
      token: token,
      onProgress: onProgress,
    );
  }
}
