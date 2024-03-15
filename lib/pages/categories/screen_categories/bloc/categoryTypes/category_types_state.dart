part of 'category_types_bloc.dart';

abstract class CategoryTypesState extends Equatable {
  const CategoryTypesState();
}

class CategoryTypesInitial extends CategoryTypesState {
  @override
  List<Object> get props => [];
}

class CategoryTypesFailure extends CategoryTypesState {
  @override
  List<Object> get props => [];
}

class CategoryTypesSuccess extends CategoryTypesState {
  final List<CategoryType> categoryTypes;

  const CategoryTypesSuccess(this.categoryTypes);

  @override
  List<Object> get props => [categoryTypes];
}
