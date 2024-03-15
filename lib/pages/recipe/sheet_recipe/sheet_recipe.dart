import 'package:flavorful/data/recipe_repository.dart';
import 'package:flavorful/shared/components/app_bar/custom_app_bar.dart';
import 'package:flavorful/shared/components/sheet/draggable_scrollable_bottom_sheet.dart';
import 'package:flavorful/shared/components/sheet/modal_bottom_sheet_page.dart';
import 'package:flavorful/shared/screen.dart';
import 'package:flutter/material.dart';

import 'package:flavorful/shared/constants/design.dart' as design;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/recipe/recipe_bloc.dart';
import 'bloc/recipe_ingredients/recipe_ingredients_bloc.dart';
import 'bloc/servings_counter/servings_counter_bloc.dart';
import 'components/ingredients.dart';
import 'components/recipe_header.dart';

class SheetRecipe extends StatelessWidget {
  final int recipeId;
  final void Function(int recipeId, double factor) nav;

  static const bottomSheetRecipeOptions = BottomSheetOptions(
    isScrollControlled: true,
    constraints: BoxConstraints(maxWidth: Device.kPcBreakpoint),
  );

  const SheetRecipe({super.key, required this.recipeId, required this.nav});

  @override
  Widget build(BuildContext context) {
    const double imageHeight = 250;
    //Only use an offset if the device is a phone.
    final double imageOffset =
        Screen(context).device != Device.phone ? -1 * design.kNormalInset : 75;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              RecipeBloc(RepositoryProvider.of<RecipeRepository>(context))
                ..add(FetchRecipe(recipeId)),
        ),
        BlocProvider(
          create: (context) => RecipeIngredientsBloc(
              RepositoryProvider.of<RecipeRepository>(context)),
        ),
        BlocProvider(
          create: (context) => ServingsCounterBloc(),
        ),
      ],
      child: DraggableScrollableBottomSheet(
        builder: (_, scrollController) {
          return Container(
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              color: design.kWhite,
              borderRadius: design.kNormalBorderRadTop,
            ),
            child: Stack(
              children: [
                SingleChildScrollView(
                  controller: scrollController,
                  child: Column(children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: design.kPrimary,
                        borderRadius: design.kNormalBorderRadBottom,
                      ),
                      padding: const EdgeInsets.only(top: kToolbarHeight),
                      child: BlocBuilder<RecipeBloc, RecipeState>(
                        builder: (context, state) {
                          if (state is RecipeSuccess) {
                            return RecipeHeader(
                              recipe: state.recipe,
                              imageHeight: imageHeight,
                              imageOffset: imageOffset,
                              nav: nav,
                            );
                          }
                          return ConstrainedBox(
                            constraints:
                                const BoxConstraints(minHeight: imageHeight),
                            child: const Center(
                                child: design.kNormalCircularProgressIndicator),
                          );
                        },
                      ),
                    ),
                    BlocBuilder<RecipeBloc, RecipeState>(
                      builder: (context, state) {
                        if (state is RecipeSuccess) {
                          return Ingredients(recipe: state.recipe);
                        }
                        return ConstrainedBox(
                          constraints:
                              const BoxConstraints(minHeight: imageHeight),
                          child: const Center(
                              child: design.kNormalCircularProgressIndicator),
                        );
                      },
                    ),
                  ]),
                ),
                const Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: CustomAppBar(
                      foregroundColor: design.kWhite,
                      backgroundColor: design.kPrimary),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
