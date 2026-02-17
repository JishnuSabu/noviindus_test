import 'package:noviindus_test/features/home/domain/entities/category_entity.dart';
import 'package:noviindus_test/features/home/domain/entities/feed_entity.dart';

abstract class HomeRepository {
  Future<List<CategoryEntity>> getCategories();
  Future<List<FeedEntity>> getFeeds();
  Future<List<FeedEntity>> getMyFeeds({required String token});
}
