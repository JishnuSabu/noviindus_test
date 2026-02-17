import '../entities/auth_entity.dart';
import '../../data/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<AuthEntity> call({
    required String phone,
    required String countryCode,
  }) {
    return repository.login(phone: phone, countryCode: countryCode);
  }
}
