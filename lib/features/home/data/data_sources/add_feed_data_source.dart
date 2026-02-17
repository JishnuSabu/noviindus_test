import 'package:dio/dio.dart';

class AddFeedDataSource {
  final Dio dio;

  AddFeedDataSource(this.dio);

  Future<void> uploadFeed({
    required String videoPath,
    required String imagePath,
    required String desc,
    required List<int> categoryIds,
    required String token,
    required Function(double progress) onProgress,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        "video": await MultipartFile.fromFile(videoPath),
        "image": await MultipartFile.fromFile(imagePath),
        "desc": desc,
        "category": categoryIds,
      });

      await dio.post(
        "my_feed",
        data: formData,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "multipart/form-data",
          },
        ),
        onSendProgress: (sent, total) {
          if (total != 0) {
            double progress = sent / total;
            onProgress(progress);
          }
        },
      );
    } on DioException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
