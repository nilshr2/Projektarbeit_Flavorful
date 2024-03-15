import 'api/cookbook_api_client.dart';
import 'api/model/category.dart';
import 'api/model/category_type.dart';

class CookbookRepository {
  final CookbookApiClient _apiClient = CookbookApiClient();

  Future<List<CategoryType>> getCategoryTypes() async {
    var res = await _apiClient.getCategoryTypes();
    return res.map((e) => CategoryType.fromJson(e)).toList();
  }

  Future<List<Category>> getCategories(int categoryTypeId) async {
    var res = await _apiClient.getCategories(categoryTypeId);
    return res.map((e) => Category.fromJson(e)).toList();
  }

  Future<List<int>> getRecipeIdsForCategory(int categoryId) async {
    var entriesRes = await _apiClient.getCategoryEntries(categoryId);
    return entriesRes.map<int>((e) => e["recipeId"]).toList();
  }

  Future<List<Category>> getRandomCategories(int count) async {
    var res = await _apiClient.getRandomCategories(count);
    return res.map((e) => Category.fromJson(e)).toList();
  }
}
