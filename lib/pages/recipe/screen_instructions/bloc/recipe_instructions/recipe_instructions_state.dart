part of 'recipe_instructions_bloc.dart';

abstract class RecipeInstructionsState extends Equatable {
  const RecipeInstructionsState();
}

class RecipeInstructionsInitial extends RecipeInstructionsState {
  @override
  List<Object> get props => [];
}

class RecipeInstructionsFailure extends RecipeInstructionsState {
  @override
  List<Object> get props => [];
}

class RecipeInstructionsSuccess extends RecipeInstructionsState {
  final List<RecipeInstruction> recipeInstructions;
  final List<RecipeIngredient> recipeIngredients;
  final List<Ingredient> ingredients;

  const RecipeInstructionsSuccess({
    required this.recipeInstructions,
    required this.recipeIngredients,
    required this.ingredients,
  });

  @override
  List<Object> get props =>
      [recipeInstructions, recipeIngredients, ingredients];
}
