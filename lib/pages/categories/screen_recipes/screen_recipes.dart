import 'package:flavorful/bloc/translation/translation_bloc.dart';
import 'package:flavorful/data/cookbook_repository.dart';
import 'package:flavorful/data/recipe_repository.dart';
import 'package:flavorful/shared/components/app_bar/custom_app_bar.dart';
import 'package:flavorful/shared/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flavorful/shared/constants/design.dart' as design;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'bloc/recipes/recipes_bloc.dart';
import 'components/recipe_card.dart';

class ScreenRecipes extends StatelessWidget {
  final int categoryId;
  final void Function(int recipeId) nav;

  const ScreenRecipes({super.key, required this.categoryId, required this.nav});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecipesBloc(
          RepositoryProvider.of<CookbookRepository>(context),
          RepositoryProvider.of<RecipeRepository>(context))
        ..add(FetchRecipes(categoryId)),
      child: BlocBuilder<TranslationBloc, TranslationState>(
        builder: (_, ts) {
          return Scaffold(
            appBar: CustomAppBar(
                title: AppLocalizations.of(context)!.recipes.capitalize()),
            backgroundColor: design.kWhite,
            body: CustomScrollView(
              slivers: [
                BlocBuilder<RecipesBloc, RecipesState>(
                  buildWhen: (prev, state) {
                    if (prev is RecipesSuccess && state is RecipesSuccess) {
                      return !(prev.recipes == state.recipes);
                    }
                    return true;
                  },
                  builder: (recipesContext, recipesState) {
                    if (ts is TranslationSuccess &&
                        recipesState is RecipesSuccess) {
                      return SliverPadding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: design.kSmallInset),
                        sliver: SliverAlignedGrid(
                            gridDelegate:
                                const SliverSimpleGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 250),
                            mainAxisSpacing: design.kSmallInset,
                            crossAxisSpacing: design.kSmallInset,
                            itemBuilder: (BuildContext context, int index) {
                              return RecipeCard(
                                  recipe: recipesState.recipes[index],
                                  nav: nav // category.recipeIds[index],
                                  );
                            },
                            itemCount: recipesState
                                .recipes.length //category.recipeIds.length,
                            ),
                      );
                    }
                    return const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                          child: design.kNormalCircularProgressIndicator),
                    );
                  },
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: design.kSmallInset),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
