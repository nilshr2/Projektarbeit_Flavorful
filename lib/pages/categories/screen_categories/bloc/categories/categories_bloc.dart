
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flavorful/data/api/model/category.dart';
import 'package:flavorful/data/api/model/category_type.dart';
import 'package:flavorful/data/cookbook_repository.dart';

part 'categories_event.dart';

part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final CookbookRepository categoryRepository;

  CategoriesBloc(this.categoryRepository) : super(CategoriesInitial()) {
    on<FetchCategories>((event, emit) async {
      try {
        List<Category> categories =
            await categoryRepository.getCategories(event.categoryType.id);
        emit(CategoriesSuccess(
            categoryType: event.categoryType, categories: categories));
      } catch (e) {
        emit(CategoriesFailure());
      }
    });
  }
}
