import 'package:flavorful/bloc/translation/translation_bloc.dart';
import 'package:flavorful/data/api/model/recipe.dart';
import 'package:flavorful/data/api/model/recipe_ingredient.dart';
import 'package:flavorful/shared/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flavorful/shared/constants/design.dart' as design;

import '../../recipe_ingredient_display.dart';
import '../bloc/recipe_ingredients/recipe_ingredients_bloc.dart';
import '../bloc/servings_counter/servings_counter_bloc.dart';

class Ingredients extends StatelessWidget {
  final Recipe? recipe;

  const Ingredients({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    if (recipe?.id != null) {
      context
          .read<RecipeIngredientsBloc>()
          .add(FetchRecipeIngredients(recipe!.id));
    }

    return Padding(
      padding: const EdgeInsets.all(design.kNormalInset),
      child: BlocBuilder<RecipeIngredientsBloc, RecipeIngredientsState>(
          builder: (context, state) {
        return Row(
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                AppLocalizations.of(context)!.ingredients.capitalize(),
                style: design.kH1TitleStyleBlack,
              ),
              BlocBuilder<RecipeIngredientsBloc, RecipeIngredientsState>(
                  builder: (context, state) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: (state is RecipeIngredientsSuccess)
                        ? state.recipeIngredients
                            .map((RecipeIngredient e) =>
                                IngredientItem(recipeIngredient: e))
                            .toList()
                        : [
                            const Center(
                                child: design.kNormalCircularProgressIndicator)
                          ]);
              }),
            ]),
          ],
        );
      }),
    );
  }
}

class IngredientItem extends StatelessWidget {
  final RecipeIngredient recipeIngredient;

  const IngredientItem({
    super.key,
    required this.recipeIngredient,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TranslationBloc, TranslationState>(
      builder: (_, ts) {
        return Padding(
          padding: const EdgeInsets.only(top: design.kSmallInset),
          child: Row(
            children: [
              BlocBuilder<RecipeIngredientsBloc, RecipeIngredientsState>(
                builder: (context, state) {
                  String? imageUrl = state is IngredientsSuccess
                      ? state.ingredients
                          .firstWhere(
                              (e) => e.name == recipeIngredient.ingredient)
                          .imageUrl
                      : null;

                  return Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: design.kCategoryCardImageRad,
                      color: design.kAccent,
                      image: imageUrl != null
                          ? DecorationImage(
                              image: NetworkImage(
                              imageUrl,
                            ))
                          : null,
                    ),
                  );
                },
              ),
              const SizedBox(
                width: design.kSmallInset,
              ),
              BlocBuilder<ServingsCounterBloc, ServingsCounterState>(
                builder: (context, state) {
                  String quantity = RecipeIngredientDisplay.getQuantity(
                      recipeIngredient,
                      state is ServingsCounterSet ? state.factor : 1);
                  String unit = RecipeIngredientDisplay.getTranslatedUnit(
                      recipeIngredient, ts);
                  String translatedIngredient =
                      RecipeIngredientDisplay.getTranslatedIngredient(
                          recipeIngredient, ts);
                  return Text(
                    "$quantity$unit$translatedIngredient",
                    style: design.kH3TitleStyleBlack,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
