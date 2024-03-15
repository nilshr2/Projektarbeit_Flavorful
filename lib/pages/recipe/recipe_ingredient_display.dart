import 'package:flavorful/bloc/translation/translation_bloc.dart';
import 'package:flavorful/bloc/translation/translation_helper.dart';
import 'package:flavorful/data/api/model/recipe_ingredient.dart';
import 'package:flavorful/shared/extensions.dart';

class RecipeIngredientDisplay {
  static String getQuantity(RecipeIngredient recipeIngredient, double factor) {
    if (recipeIngredient.quantity != null) {
      double quantity = factor * recipeIngredient.quantity!;
      return "${quantity.toStringWithoutTrailingZeros()} ";
    }
    return "";
  }

  static String getTranslatedUnit(
      RecipeIngredient recipeIngredient, TranslationState ts) {
    return recipeIngredient.unit != null
        ? "${getSuccessOrNull(ts)?.units[recipeIngredient.unit]} "
        : "";
  }

  static String getTranslatedIngredient(
      RecipeIngredient recipeIngredient, TranslationState ts) {
    return getSuccessOrNull(ts)?.ingredients(
            recipeIngredient.plural)[recipeIngredient.ingredient] ??
        recipeIngredient.ingredient;
  }
}
