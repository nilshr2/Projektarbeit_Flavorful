part of 'category_types_bloc.dart';

abstract class CategoryTypesEvent extends Equatable {
  const CategoryTypesEvent();
}

class FetchCategoryTypes extends CategoryTypesEvent {
  const FetchCategoryTypes();

  @override
  List<Object> get props => [];
}
