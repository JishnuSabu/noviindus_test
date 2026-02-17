import 'package:noviindus_test/features/home/domain/entities/category_entity.dart';
import 'package:noviindus_test/features/home/data/repositories/home_repository.dart';

class GetCategoriesUseCase {
  final HomeRepository repository;

  GetCategoriesUseCase(this.repository);

  Future<List<CategoryEntity>> call() async {
    return await repository.getCategories();
  }
}
