import 'package:noviindus_test/features/auth/domain/entities/auth_entity.dart';

class AuthModel extends AuthEntity {
  AuthModel({required String access}) : super(access);

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(access: json["token"]["access"]);
  }
}
