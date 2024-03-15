import 'package:supabase_flutter/supabase_flutter.dart';

class TranslationApi {
  final _supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getCategoryTypesTranslations(
      String languageId) async {
    return await _supabase
        .schema("translations")
        .from("Translations_${languageId}_CategoryTypes")
        .select();
  }

  Future<List<Map<String, dynamic>>> getCategoriesTranslations(
      String languageId) async {
    return await _supabase
        .schema("translations")
        .from("Translations_${languageId}_Categories")
        .select();
  }

  Future<List<Map<String, dynamic>>> getRecipesTranslations(
      String languageId) async {
    return await _supabase
        .schema("translations")
        .from("Translations_${languageId}_Recipes")
        .select();
  }

  Future<List<Map<String, dynamic>>> getIngredientsSingularTranslations(
      String languageId) async {
    return await _supabase
        .schema("translations")
        .from("Translations_${languageId}_Ingredients_Singular")
        .select();
  }

  Future<List<Map<String, dynamic>>> getIngredientsPluralTranslations(
      String languageId) async {
    return await _supabase
        .schema("translations")
        .from("Translations_${languageId}_Ingredients_Plural")
        .select();
  }

  Future<List<Map<String, dynamic>>> getInstructionsTranslations(
      String languageId) async {
    return await _supabase
        .schema("translations")
        .from("Translations_${languageId}_Instructions")
        .select();
  }

  Future<List<Map<String, dynamic>>> getUnitsTranslations(
      String languageId) async {
    return await _supabase
        .schema("translations")
        .from("Translations_${languageId}_Units")
        .select();
  }
}
