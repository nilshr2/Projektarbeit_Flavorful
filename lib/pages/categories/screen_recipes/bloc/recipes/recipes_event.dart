part of 'recipes_bloc.dart';

abstract class RecipesEvent extends Equatable {
  const RecipesEvent();
}

class FetchRecipes extends RecipesEvent {
  final int categoryId;

  const FetchRecipes(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}
