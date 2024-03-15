
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flavorful/data/api/model/category_type.dart';
import 'package:flavorful/data/cookbook_repository.dart';

part 'category_types_event.dart';

part 'category_types_state.dart';

class CategoryTypesBloc extends Bloc<CategoryTypesEvent, CategoryTypesState> {
  final CookbookRepository categoryRepository;

  CategoryTypesBloc(this.categoryRepository) : super(CategoryTypesInitial()) {
    on<FetchCategoryTypes>((event, emit) async {
      try {
        List<CategoryType> categoryTypes =
            await categoryRepository.getCategoryTypes();
        emit(CategoryTypesSuccess(categoryTypes));
      } catch (e) {
        emit(CategoryTypesFailure());
      }
    });
  }
}
