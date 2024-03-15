import 'package:flavorful/data/api/model/recipe_ingredient.dart';

import 'api/model/ingredient.dart';
import 'api/model/recipe.dart';
import 'api/model/recipe_instruction.dart';
import 'api/recipe_api_client.dart';

class RecipeRepository {
  final RecipeApiClient _apiClient = RecipeApiClient();

  Future<Recipe> getRecipe(int recipeId) async {
    var res = await _apiClient.getRecipe(recipeId);
    return Recipe.fromJson(res);
  }

  Future<List<Recipe>> getRecipes(List<int> recipeIds) async {
    var res = await _apiClient.getRecipes(recipeIds);
    return res.map((e) => Recipe.fromJson(e)).toList();
  }

  Future<List<RecipeIngredient>> getRecipeIngredients(int recipeId) async {
    var res = await _apiClient.getRecipeIngredients(recipeId);
    return res.map((e) => RecipeIngredient.fromJson(e)).toList();
  }

  Future<List<Ingredient>> getIngredients(List<String> ingredientNames) async {
    var res = await _apiClient.getIngredients(ingredientNames);
    return res.map((e) => Ingredient.fromJson(e)).toList();
  }

  Future<List<RecipeInstruction>> getRecipeInstructions(int recipeId) async {
    var res = await _apiClient.getRecipeInstructions(recipeId);
    return res.map((e) => RecipeInstruction.fromJson(e)).toList();
  }

  Future<List<Recipe>> getLatestRecipes(int count) async {
    var res = await _apiClient.getLatestRecipes(count);
    return res.map((e) => Recipe.fromJson(e)).toList();
  }

  Future<List<Recipe>> getRandomRecipes(int count) async {
    var res = await _apiClient.getRandomRecipes(count);
    return res.map((e) => Recipe.fromJson(e)).toList();
  }
}
