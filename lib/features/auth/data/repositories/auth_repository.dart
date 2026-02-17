import 'package:noviindus_test/features/auth/domain/entities/auth_entity.dart';

abstract class AuthRepository {
  Future<AuthEntity> login({
    required String phone,
    required String countryCode,
  });
}
