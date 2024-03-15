import 'package:flavorful/bloc/translation/translation_bloc.dart';
import 'package:flavorful/data/cookbook_repository.dart';
import 'package:flavorful/data/recipe_repository.dart';
import 'package:flavorful/pages/categories/screen_recipes/components/recipe_card.dart';
import 'package:flavorful/pages/home/screen_home/bloc/home/home_bloc.dart';
import 'package:flavorful/shared/components/app_bar/custom_app_bar.dart';
import 'package:flavorful/shared/components/grid/horizontal_grid.dart';
import 'package:flavorful/shared/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flavorful/shared/constants/design.dart' as design;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/compact_category_card.dart';

class ScreenHome extends StatelessWidget {
  final void Function(int recipeId) navToRecipe;
  final void Function(int categoryId) navToCategory;

  const ScreenHome(
      {super.key, required this.navToRecipe, required this.navToCategory});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
          RepositoryProvider.of<RecipeRepository>(context),
          RepositoryProvider.of<CookbookRepository>(context))
        ..add(FetchHome()),
      child: Scaffold(
          appBar: CustomAppBar(
            title: AppLocalizations.of(context)!.for_you.capitalize(),
          ),
          backgroundColor: design.kWhite,
          body: ListView(children: [
            LatestRecipes(nav: navToRecipe),
            const SizedBox(
              height: design.kLargeInset,
            ),
            RandomCategories(nav: navToCategory),
            const SizedBox(
              height: design.kLargeInset,
            ),
            RandomRecipes(nav: navToRecipe),
            const SizedBox(height: design.kSmallInset),
          ])),
    );
  }
}

class LatestRecipes extends StatelessWidget {
  const LatestRecipes({
    super.key,
    required this.nav,
  });

  final void Function(int recipeId) nav;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: design.kNormalInset),
          child: Text(
            AppLocalizations.of(context)!.latest.capitalize(),
            style: design.kH1TitleStylePrimaryBold,
          ),
        ),
        const SizedBox(height: design.kSmallInset),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: design.kSmallInset),
          child: BlocBuilder<TranslationBloc, TranslationState>(
            builder: (_, ts) {
              return BlocBuilder<HomeBloc, HomeState>(builder: (_, hs) {
                if (ts is TranslationSuccess && hs is HomeSuccess) {
                  return HorizontalGrid(
                      crossAxisCount: 1,
                      maxExtent: 250,
                      childCrossAxisAddedPx: 15,
                      mainAxisSpacing: design.kSmallInset,
                      crossAxisSpacing: design.kSmallInset,
                      itemBuilder: (context, index) => RecipeCard(
                          recipe: hs.latestRecipes[index],
                          nav: nav // category.recipeIds[index],
                          ),
                      itemCount: hs.latestRecipes.length);
                }
                return const SizedBox(
                  height: 250,
                  child: Center(child: design.kNormalCircularProgressIndicator),
                );
              });
            },
          ),
        )
      ],
    );
  }
}

class RandomCategories extends StatelessWidget {
  const RandomCategories({
    super.key,
    required this.nav,
  });

  final void Function(int categoryId) nav;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: design.kNormalInset),
            child: DiscoverText(
                text: AppLocalizations.of(context)!.categories.capitalize())),
        const SizedBox(height: design.kSmallInset),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: design.kSmallInset),
          child: BlocBuilder<TranslationBloc, TranslationState>(
            builder: (_, ts) {
              return BlocBuilder<HomeBloc, HomeState>(builder: (_, hs) {
                if (ts is TranslationSuccess && hs is HomeSuccess) {
                  return HorizontalGrid(
                      crossAxisCount: 2,
                      maxExtent: 200,
                      childAspectRatio: 3,
                      mainAxisSpacing: design.kSmallInset,
                      crossAxisSpacing: design.kSmallInset,
                      itemBuilder: (context, index) => CompactCategoryCard(
                          category: hs.randomCategories[index],
                          nav: nav // category.recipeIds[index],
                          ),
                      itemCount: hs.randomCategories.length);
                }
                return const SizedBox(
                  height: 200,
                  child: Center(child: design.kNormalCircularProgressIndicator),
                );
              });
            },
          ),
        )
      ],
    );
  }
}

class RandomRecipes extends StatelessWidget {
  const RandomRecipes({
    super.key,
    required this.nav,
  });

  final void Function(int recipeId) nav;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: design.kNormalInset),
          child: DiscoverText(
            text: AppLocalizations.of(context)!.recipes.capitalize(),
          ),
        ),
        const SizedBox(height: design.kSmallInset),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: design.kSmallInset),
          child: BlocBuilder<TranslationBloc, TranslationState>(
            builder: (_, ts) {
              return BlocBuilder<HomeBloc, HomeState>(builder: (_, hs) {
                if (ts is TranslationSuccess && hs is HomeSuccess) {
                  return HorizontalGrid(
                      crossAxisCount: 2,
                      maxExtent: 250,
                      childCrossAxisAddedPx: 15,
                      mainAxisSpacing: design.kSmallInset,
                      crossAxisSpacing: design.kSmallInset,
                      itemBuilder: (context, index) => RecipeCard(
                          recipe: hs.randomRecipes[index],
                          nav: nav // category.recipeIds[index],
                          ),
                      itemCount: hs.randomRecipes.length);
                }
                return const SizedBox(
                  height: 250,
                  child: Center(child: design.kNormalCircularProgressIndicator),
                );
              });
            },
          ),
        )
      ],
    );
  }
}

class DiscoverText extends StatelessWidget {
  final String text;

  const DiscoverText({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: "${AppLocalizations.of(context)!.discover.capitalize()} ",
          style: design.kH1TitleStylePrimaryBold,
          children: [
            TextSpan(
              text: text,
              style: design.kH1TitleStyleBlackBold,
            )
          ]),
    );
  }
}
