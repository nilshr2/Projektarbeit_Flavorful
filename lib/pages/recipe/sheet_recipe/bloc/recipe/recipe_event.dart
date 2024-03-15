part of 'recipe_bloc.dart';

abstract class RecipeEvent extends Equatable {
  const RecipeEvent();
}

class FetchRecipe extends RecipeEvent {
  final int recipeId;

  const FetchRecipe(this.recipeId);

  @override
  List<Object> get props => [recipeId];
}
