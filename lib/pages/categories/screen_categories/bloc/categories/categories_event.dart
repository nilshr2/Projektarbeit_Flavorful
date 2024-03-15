part of 'categories_bloc.dart';

abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();
}

class FetchCategories extends CategoriesEvent {
  final CategoryType categoryType;

  const FetchCategories(this.categoryType);

  @override
  List<Object> get props => [categoryType];
}
