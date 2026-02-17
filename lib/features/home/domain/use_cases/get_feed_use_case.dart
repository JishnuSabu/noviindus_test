import 'package:noviindus_test/features/home/data/repositories/home_repository.dart';
import 'package:noviindus_test/features/home/domain/entities/feed_entity.dart';

class GetFeedsUseCase {
  final HomeRepository repository;

  GetFeedsUseCase(this.repository);

  Future<List<FeedEntity>> call() async {
    return await repository.getFeeds();
  }
}
