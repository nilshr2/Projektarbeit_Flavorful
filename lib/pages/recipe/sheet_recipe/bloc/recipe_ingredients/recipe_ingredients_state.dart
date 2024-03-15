part of 'recipe_ingredients_bloc.dart';

abstract class RecipeIngredientsState extends Equatable {
  const RecipeIngredientsState();
}

class RecipeIngredientsInitial extends RecipeIngredientsState {
  @override
  List<Object> get props => [];
}

class RecipeIngredientsFailure extends RecipeIngredientsState {
  @override
  List<Object> get props => [];
}

class RecipeIngredientsSuccess extends RecipeIngredientsState {
  final List<RecipeIngredient> recipeIngredients;

  const RecipeIngredientsSuccess({required this.recipeIngredients});

  @override
  List<Object> get props => [recipeIngredients];
}

class IngredientsSuccess extends RecipeIngredientsSuccess {
  final List<Ingredient> ingredients;

  const IngredientsSuccess(
      {required this.ingredients, required super.recipeIngredients});

  @override
  List<Object> get props => [ingredients];
}
