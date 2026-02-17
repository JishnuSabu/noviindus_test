import 'package:noviindus_test/features/home/data/repositories/home_repository.dart';
import 'package:noviindus_test/features/home/domain/entities/feed_entity.dart';

class GetMyFeedsUseCase {
  final HomeRepository repository;

  GetMyFeedsUseCase(this.repository);

  Future<List<FeedEntity>> call({required String token}) async {
    return await repository.getMyFeeds(token: token);
  }
}
