import 'package:noviindus_test/features/auth/data/data_sources/auth_data_source.dart';
import 'package:noviindus_test/features/auth/domain/entities/auth_entity.dart';
import 'package:noviindus_test/features/auth/data/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<AuthEntity> login({
    required String phone,
    required String countryCode,
  }) async {
    return await remoteDataSource.login(phone: phone, countryCode: countryCode);
  }
}
