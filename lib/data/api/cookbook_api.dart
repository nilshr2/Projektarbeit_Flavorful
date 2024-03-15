import 'package:supabase_flutter/supabase_flutter.dart';

class CookbookApi {
  final _supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getCategoryTypes() async {
    return await _supabase.from("CategoryTypes").select();
  }

  Future<List<Map<String, dynamic>>> getCategories(int categoryTypeId) async {
    return await _supabase
        .from("Categories")
        .select()
        .eq("categoryTypeId", categoryTypeId);
  }

  Future<List<Map<String, dynamic>>> getCategoryEntries(int categoryId) async {
    return await _supabase
        .from("CategoryEntries")
        .select("recipeId")
        .eq("categoryId", categoryId);
  }

  Future<List<Map<String, dynamic>>> getRandomCategories(int count) async {
    return await _supabase
        .rpc("get_random_categories", params: {"count": count});
  }
}
