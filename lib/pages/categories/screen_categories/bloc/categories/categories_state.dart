part of 'categories_bloc.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();
}

class CategoriesInitial extends CategoriesState {
  @override
  List<Object> get props => [];
}

class CategoriesFailure extends CategoriesState {
  @override
  List<Object> get props => [];
}

class CategoriesSuccess extends CategoriesState {
  final CategoryType categoryType;
  final List<Category> categories;

  const CategoriesSuccess(
      {required this.categoryType, required this.categories});

  @override
  List<Object> get props => [categoryType, categories];
}
