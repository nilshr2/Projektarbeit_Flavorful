import 'cookbook_api.dart';

class CookbookApiClient {
  final CookbookApi _api = CookbookApi();

  Future<List<Map<String, dynamic>>> getCategoryTypes() async {
    return await _api.getCategoryTypes();
  }

  Future<List<Map<String, dynamic>>> getCategories(int categoryTypeId) async {
    return await _api.getCategories(categoryTypeId);
  }

  Future<List<Map<String, dynamic>>> getCategoryEntries(int categoryId) async {
    return await _api.getCategoryEntries(categoryId);
  }

  Future<List<Map<String, dynamic>>> getRandomCategories(int count) async {
    return await _api.getRandomCategories(count);
  }
}
