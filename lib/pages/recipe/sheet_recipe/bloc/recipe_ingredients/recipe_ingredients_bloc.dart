
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flavorful/data/api/model/ingredient.dart';
import 'package:flavorful/data/api/model/recipe_ingredient.dart';
import 'package:flavorful/data/recipe_repository.dart';

part 'recipe_ingredients_event.dart';

part 'recipe_ingredients_state.dart';

class RecipeIngredientsBloc
    extends Bloc<RecipeIngredientsEvent, RecipeIngredientsState> {
  final RecipeRepository recipeRepository;

  RecipeIngredientsBloc(this.recipeRepository)
      : super(RecipeIngredientsInitial()) {
    on<FetchRecipeIngredients>((event, emit) async {
      try {
        List<RecipeIngredient> recipeIngredients =
            await recipeRepository.getRecipeIngredients(event.recipeId);
        emit(RecipeIngredientsSuccess(recipeIngredients: recipeIngredients));
        List<String> ingredientNames =
            recipeIngredients.map((e) => e.ingredient).toList();
        List<Ingredient> ingredients =
            await recipeRepository.getIngredients(ingredientNames);
        emit(IngredientsSuccess(
            ingredients: ingredients, recipeIngredients: recipeIngredients));
      } catch (e) {
        emit(RecipeIngredientsFailure());
      }
    });
  }
}
