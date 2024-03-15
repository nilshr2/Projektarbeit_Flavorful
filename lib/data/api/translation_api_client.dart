import 'translation_api.dart';

class TranslationApiClient {
  final TranslationApi _api = TranslationApi();

  Future<List<Map<String, dynamic>>> getCategoryTypesTranslations(
      String languageId) async {
    return await _api.getCategoryTypesTranslations(languageId);
  }

  Future<List<Map<String, dynamic>>> getCategoriesTranslations(
      String languageId) async {
    return await _api.getCategoriesTranslations(languageId);
  }

  Future<List<Map<String, dynamic>>> getRecipesTranslations(
      String languageId) async {
    return await _api.getRecipesTranslations(languageId);
  }

  Future<List<Map<String, dynamic>>> getIngredientsSingularTranslations(
      String languageId) async {
    return await _api.getIngredientsSingularTranslations(languageId);
  }

  Future<List<Map<String, dynamic>>> getIngredientsPluralTranslations(
      String languageId) async {
    return await _api.getIngredientsPluralTranslations(languageId);
  }

  Future<List<Map<String, dynamic>>> getInstructionsTranslations(
      String languageId) async {
    return await _api.getInstructionsTranslations(languageId);
  }

  Future<List<Map<String, dynamic>>> getUnitsTranslations(
      String languageId) async {
    return await _api.getUnitsTranslations(languageId);
  }
}
