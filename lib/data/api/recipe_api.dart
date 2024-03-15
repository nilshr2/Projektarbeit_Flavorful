import 'package:supabase_flutter/supabase_flutter.dart';

class RecipeApi {
  final _supabase = Supabase.instance.client;

  Future<Map<String, dynamic>> getRecipe(int recipeId) async {
    return await _supabase.from("Recipes").select().eq("id", recipeId).single();
  }

  Future<List<Map<String, dynamic>>> getRecipes(List<int> recipeIds) async {
    return await _supabase.from("Recipes").select().inFilter("id", recipeIds);
  }

  Future<List<Map<String, dynamic>>> getRecipeIngredients(int recipeId) async {
    return await _supabase
        .from("RecipeIngredients")
        .select()
        .eq("recipeId", recipeId);
  }

  Future<List<Map<String, dynamic>>> getIngredients(
      List<String> ingredientNames) async {
    return await _supabase
        .from("Ingredients")
        .select()
        .inFilter("name", ingredientNames);
  }

  Future<List<Map<String, dynamic>>> getRecipeInstructions(int recipeId) async {
    return await _supabase
        .from("RecipeInstructions")
        .select()
        .eq("recipeId", recipeId);
  }

  Future<List<Map<String, dynamic>>> getLatestRecipes(int count) async {
    return await _supabase
        .from("Recipes")
        .select()
        .order("createdAt")
        .limit(count);
  }

  Future<List<Map<String, dynamic>>> getRandomRecipes(int count) async {
    return await _supabase.rpc("get_random_recipes", params: {"count": count});
  }
}
