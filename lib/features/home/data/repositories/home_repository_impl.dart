import 'package:noviindus_test/features/home/data/data_sources/home_data_source.dart';
import 'package:noviindus_test/features/home/data/repositories/home_repository.dart';
import 'package:noviindus_test/features/home/domain/entities/category_entity.dart';
import 'package:noviindus_test/features/home/domain/entities/feed_entity.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<CategoryEntity>> getCategories() async {
    final models = await remoteDataSource.getCategories();

    return models.map((model) {
      return CategoryEntity(
        id: model.id,
        title: model.title,
        image: model.image,
      );
    }).toList();
  }

  @override
  Future<List<FeedEntity>> getFeeds() async {
    final models = await remoteDataSource.getFeeds();

    return models.map((model) {
      return FeedEntity(
        id: model.id,
        description: model.description,
        thumbnail: model.thumbnail,
        videoUrl: model.videoUrl,
        userName: model.userName,
        userImage: model.userImage,
        createdAt: model.createdAt,
      );
    }).toList();
  }

  @override
  Future<List<FeedEntity>> getMyFeeds({required String token}) async {
    final models = await remoteDataSource.getMyFeeds(token: token);

    return models.map((model) {
      return FeedEntity(
        id: model.id,
        description: model.description,
        thumbnail: model.thumbnail,
        videoUrl: model.videoUrl,
        userName: model.userName,
        userImage: model.userImage,
        createdAt: model.createdAt,
      );
    }).toList();
  }
}
