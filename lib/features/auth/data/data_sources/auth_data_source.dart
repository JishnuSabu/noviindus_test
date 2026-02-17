import 'package:dio/dio.dart';
import 'package:noviindus_test/features/auth/data/models/auth_model.dart';

class AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSource(this.dio);

  Future<AuthModel> login({
    required String phone,
    required String countryCode,
  }) async {
    try {
      final formData = FormData.fromMap({
        "phone": phone,
        "country_code": countryCode,
      });

      final response = await dio.post("otp_verified", data: formData);
      if (response.statusCode == 200 || response.statusCode == 202) {
        return AuthModel.fromJson(response.data);
      } else {
        throw Exception("Login failed");
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? "Login failed");
    }
  }
}
