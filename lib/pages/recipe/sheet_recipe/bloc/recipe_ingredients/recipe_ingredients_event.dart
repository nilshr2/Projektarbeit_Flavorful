part of 'recipe_ingredients_bloc.dart';

abstract class RecipeIngredientsEvent extends Equatable {
  const RecipeIngredientsEvent();
}

class FetchRecipeIngredients extends RecipeIngredientsEvent {
  final int recipeId;

  const FetchRecipeIngredients(this.recipeId);

  @override
  List<Object> get props => [recipeId];
}
