import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flavorful/data/api/model/ingredient.dart';
import 'package:flavorful/data/api/model/recipe_ingredient.dart';
import 'package:flavorful/data/api/model/recipe_instruction.dart';
import 'package:flavorful/data/recipe_repository.dart';

part 'recipe_instructions_event.dart';

part 'recipe_instructions_state.dart';

class RecipeInstructionsBloc
    extends Bloc<RecipeInstructionsEvent, RecipeInstructionsState> {
  final RecipeRepository recipeRepository;

  RecipeInstructionsBloc(this.recipeRepository)
      : super(RecipeInstructionsInitial()) {
    on<FetchRecipeInstructions>((event, emit) async {
      try {
        List<dynamic> futures = await Future.wait([
          recipeRepository.getRecipeInstructions(event.recipeId),
          recipeRepository.getRecipeIngredients(event.recipeId)
        ]);
        List<RecipeInstruction> recipeInstructions = futures[0];
        recipeInstructions.sort((a, b) => a.step.compareTo(b.step));

        List<RecipeIngredient> recipeIngredients = futures[1];
        List<String> ingredientNames =
            recipeIngredients.map((e) => e.ingredient).toList();
        List<Ingredient> ingredients =
            await recipeRepository.getIngredients(ingredientNames);
        emit(RecipeInstructionsSuccess(
            recipeInstructions: recipeInstructions,
            ingredients: ingredients,
            recipeIngredients: recipeIngredients));
      } catch (e) {
        emit(RecipeInstructionsFailure());
      }
    });
  }
}
