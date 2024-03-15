part of 'recipe_instructions_bloc.dart';

abstract class RecipeInstructionsEvent extends Equatable {
  const RecipeInstructionsEvent();
}

class FetchRecipeInstructions extends RecipeInstructionsEvent {
  final int recipeId;

  const FetchRecipeInstructions(this.recipeId);

  @override
  List<Object> get props => [recipeId];
}
