import 'api/model/translation.dart';
import 'api/translation_api_client.dart';

class TranslationRepository {
  final TranslationApiClient _apiClient = TranslationApiClient();

  Future<Map<String, String>> getCategoryTypesTranslations(
      String languageId) async {
    var res = await _apiClient.getCategoryTypesTranslations(languageId);
    Iterable<Translation> translations =
        res.map((e) => Translation.fromJson(e));
    return {for (var e in translations) e.textContentId: e.translation};
  }

  Future<Map<String, String>> getCategoriesTranslations(
      String languageId) async {
    var res = await _apiClient.getCategoriesTranslations(languageId);
    Iterable<Translation> translations =
        res.map((e) => Translation.fromJson(e));
    return {for (var e in translations) e.textContentId: e.translation};
  }

  Future<Map<String, String>> getRecipesTranslations(String languageId) async {
    var res = await _apiClient.getRecipesTranslations(languageId);
    Iterable<Translation> translations =
        res.map((e) => Translation.fromJson(e));
    return {for (var e in translations) e.textContentId: e.translation};
  }

  Future<Map<String, String>> getIngredientsSingularTranslations(
      String languageId) async {
    var res = await _apiClient.getIngredientsSingularTranslations(languageId);
    Iterable<Translation> translations =
        res.map((e) => Translation.fromJson(e));
    return {for (var e in translations) e.textContentId: e.translation};
  }

  Future<Map<String, String>> getIngredientsPluralTranslations(
      String languageId) async {
    var res = await _apiClient.getIngredientsPluralTranslations(languageId);
    Iterable<Translation> translations =
        res.map((e) => Translation.fromJson(e));
    return {for (var e in translations) e.textContentId: e.translation};
  }

  Future<Map<String, String>> getInstructionsTranslations(
      String languageId) async {
    var res = await _apiClient.getInstructionsTranslations(languageId);
    Iterable<Translation> translations =
        res.map((e) => Translation.fromJson(e));
    return {for (var e in translations) e.textContentId: e.translation};
  }

  Future<Map<String, String>> getUnitsTranslations(String languageId) async {
    var res = await _apiClient.getUnitsTranslations(languageId);
    Iterable<Translation> translations =
        res.map((e) => Translation.fromJson(e));
    return {for (var e in translations) e.textContentId: e.translation};
  }
}
