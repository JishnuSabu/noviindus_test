import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

/// AUTH
import 'package:noviindus_test/features/auth/data/data_sources/auth_data_source.dart';
import 'package:noviindus_test/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:noviindus_test/features/auth/data/repositories/auth_repository.dart';
import 'package:noviindus_test/features/auth/domain/use_cases/login_use_case.dart';
import 'package:noviindus_test/features/auth/presentation/provider/auth_provider.dart';
import 'package:noviindus_test/features/home/data/data_sources/add_feed_data_source.dart';

/// HOME
import 'package:noviindus_test/features/home/data/data_sources/home_data_source.dart';
import 'package:noviindus_test/features/home/data/repositories/add_feed_repository.dart';
import 'package:noviindus_test/features/home/data/repositories/add_feed_repository_impl.dart';
import 'package:noviindus_test/features/home/data/repositories/home_repository.dart';
import 'package:noviindus_test/features/home/data/repositories/home_repository_impl.dart';
import 'package:noviindus_test/features/home/domain/use_cases/add_feed_use_case.dart';
import 'package:noviindus_test/features/home/domain/use_cases/get_category_use_case.dart';
import 'package:noviindus_test/features/home/domain/use_cases/get_feed_use_case.dart';
import 'package:noviindus_test/features/home/domain/use_cases/get_my_feed_use_case.dart';
import 'package:noviindus_test/features/home/presentation/provider/add_feed_provider.dart';
import 'package:noviindus_test/features/home/presentation/provider/home_provider.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<Dio>(() {
    final dio = Dio();

    dio.options.baseUrl = "https://frijo.noviindus.in/api/";
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);
    dio.options.headers = {"Accept": "application/json"};

    return dio;
  });

  // ================================
  // AUTH SECTION
  // ================================

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(sl<Dio>()),
  );

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl()));

  sl.registerFactory<AuthProvider>(() => AuthProvider(sl()));

  // ================================
  // HOME SECTION
  // ================================

  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSource(sl<Dio>()),
  );

  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(sl()));

  sl.registerLazySingleton<GetCategoriesUseCase>(
    () => GetCategoriesUseCase(sl()),
  );

  sl.registerLazySingleton<GetFeedsUseCase>(() => GetFeedsUseCase(sl()));

  sl.registerFactory<HomeProvider>(() => HomeProvider(sl(), sl(), sl()));

  // ================================
  // ADD FEED SECTION
  // ================================

  sl.registerLazySingleton<AddFeedDataSource>(
    () => AddFeedDataSource(sl<Dio>()),
  );

  sl.registerLazySingleton<AddFeedRepository>(
    () => AddFeedRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<AddFeedUseCase>(() => AddFeedUseCase(sl()));

  sl.registerFactory<AddFeedProvider>(() => AddFeedProvider(sl()));

  // ================================
  // MY FEED SECTION
  // ================================

  sl.registerLazySingleton(() => GetMyFeedsUseCase(sl()));
}
