import 'package:flavorful/bloc/translation/translation_bloc.dart';
import 'package:flavorful/bloc/translation/translation_helper.dart';
import 'package:flavorful/data/api/model/category.dart';
import 'package:flavorful/data/api/model/category_type.dart';
import 'package:flavorful/data/cookbook_repository.dart';
import 'package:flavorful/shared/components/app_bar/custom_app_bar.dart';
import 'package:flavorful/shared/components/app_bar/sliver_sub_app_bar.dart';
import 'package:flavorful/shared/components/dropdown/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flavorful/shared/extensions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flavorful/shared/constants/design.dart' as design;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'bloc/categories/categories_bloc.dart';
import 'bloc/categoryTypes/category_types_bloc.dart';
import 'components/category_card.dart';

class ScreenCategories extends StatelessWidget {
  final void Function(int categoryId) nav;

  const ScreenCategories({super.key, required this.nav});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CategoriesBloc(
              RepositoryProvider.of<CookbookRepository>(context)),
        ),
        BlocProvider(
          create: (context) => CategoryTypesBloc(
              RepositoryProvider.of<CookbookRepository>(context))
            ..add(const FetchCategoryTypes()),
        ),
      ],
      child: BlocBuilder<TranslationBloc, TranslationState>(
        builder: (_, ts) {
          return Scaffold(
            appBar: CustomAppBar(
                title: AppLocalizations.of(context)!.categories.capitalize()),
            backgroundColor: design.kWhite,
            body: CustomScrollView(
              slivers: [
                SliverSubAppBar(
                  title: Row(
                    children: [
                      BlocBuilder<CategoryTypesBloc, CategoryTypesState>(
                        builder: (context, cs) {
                          return Dropdown<CategoryType>(
                            entries: (ts is TranslationSuccess &&
                                    cs is CategoryTypesSuccess)
                                ? cs.categoryTypes
                                : [],
                            getString: (CategoryType e) =>
                                getSuccessOrNull(ts)
                                    ?.categoryTypes[e.name]
                                    ?.capitalize() ??
                                e.name,
                            onChange: (CategoryType categoryType) => context
                                .read<CategoriesBloc>()
                                .add(FetchCategories(categoryType)),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                BlocBuilder<CategoriesBloc, CategoriesState>(
                  buildWhen: (prev, state) {
                    if (prev is CategoriesSuccess &&
                        state is CategoriesSuccess) {
                      return !(prev.categories == state.categories);
                    }
                    return true;
                  },
                  builder: (categoriesContext, categoriesState) {
                    if (ts is TranslationSuccess &&
                        categoriesState is CategoriesSuccess) {
                      return SliverPadding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: design.kSmallInset),
                        sliver: SliverAlignedGrid(
                            gridDelegate:
                                const SliverSimpleGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 500),
                            mainAxisSpacing: design.kSmallInset,
                            crossAxisSpacing: design.kSmallInset,
                            itemBuilder: (BuildContext context, int index) {
                              Category category =
                                  categoriesState.categories[index];
                              return CategoryCard(category: category, nav: nav);
                            },
                            itemCount: categoriesState.categories.length),
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
