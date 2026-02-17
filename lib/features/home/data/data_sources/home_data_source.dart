import 'package:dio/dio.dart';
import 'package:noviindus_test/features/home/data/models/feed_model.dart';
import '../models/category_model.dart';

class HomeRemoteDataSource {
  final Dio dio;

  HomeRemoteDataSource(this.dio);

  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await dio.get("category_list");

      if (response.data['status'] == true) {
        final List categoriesJson = response.data['categories'];

        return categoriesJson.map((e) => CategoryModel.fromJson(e)).toList();
      } else {
        throw Exception("API returned status false");
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? "Failed to load categories");
    }
  }

  Future<List<FeedModel>> getFeeds() async {
    try {
      final response = await dio.get("home");

      final feeds = (response.data['results'] as List)
          .map((e) => FeedModel.fromJson(e))
          .toList();

      return feeds;
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? "Failed to load feeds");
    }
  }

  Future<List<FeedModel>> getMyFeeds({required String token}) async {
    try {
      final response = await dio.get(
        "my_feed",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
          },
        ),
      );

      final feeds = (response.data['results'] as List)
          .map((e) => FeedModel.fromJson(e))
          .toList();

      return feeds;
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? "Failed to load my feeds");
    }
  }
}
