import 'recipe_api.dart';

class RecipeApiClient {
  final RecipeApi _api = RecipeApi();

  Future<Map<String, dynamic>> getRecipe(int recipeId) async {
    return await _api.getRecipe(recipeId);
  }

  Future<List<Map<String, dynamic>>> getRecipes(List<int> recipeIds) async {
    return await _api.getRecipes(recipeIds);
  }

  Future<List<Map<String, dynamic>>> getRecipeIngredients(int recipeId) async {
    return await _api.getRecipeIngredients(recipeId);
  }

  Future<List<Map<String, dynamic>>> getIngredients(
      List<String> ingredientNames) async {
    return await _api.getIngredients(ingredientNames);
  }

  Future<List<Map<String, dynamic>>> getRecipeInstructions(int recipeId) async {
    return await _api.getRecipeInstructions(recipeId);
  }

  Future<List<Map<String, dynamic>>> getLatestRecipes(int count) async {
    return await _api.getLatestRecipes(count);
  }

  Future<List<Map<String, dynamic>>> getRandomRecipes(int count) async {
    return await _api.getRandomRecipes(count);
  }
}
