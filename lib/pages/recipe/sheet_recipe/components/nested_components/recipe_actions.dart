import 'package:flavorful/data/api/model/recipe.dart';
import 'package:flavorful/pages/recipe/sheet_recipe/bloc/servings_counter/servings_counter_bloc.dart';
import 'package:flavorful/shared/components/tappable/tappable_button.dart';
import 'package:flavorful/shared/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flavorful/shared/constants/design.dart' as design;
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipeActions extends StatelessWidget {
  final Recipe recipe;
  final void Function(int recipeId, double factor) nav;

  const RecipeActions({
    super.key,
    required this.recipe,
    required this.nav,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ServingsDisplay(recipe: recipe),
            const SizedBox(
              width: design.kSmallInset,
            ),
            TappableButton(
              onTap: () {
                context
                    .read<ServingsCounterBloc>()
                    .add(DecrementServingsCounter());
              },
              content: const [Icon(Icons.remove_rounded)],
            ),
            const SizedBox(
              width: design.kSmallInset,
            ),
            TappableButton(
              onTap: () {
                context
                    .read<ServingsCounterBloc>()
                    .add(IncrementServingsCounter());
              },
              content: const [Icon(Icons.add_rounded)],
            )
          ],
        ),
        const SizedBox(
          height: design.kSmallInset,
        ),
        BlocBuilder<ServingsCounterBloc, ServingsCounterState>(
          builder: (context, state) {
            return TappableButton(
              onTap: () {
                if (state is ServingsCounterSet) {
                  nav(recipe.id, state.factor);
                }
              },
              content: [
                Text(
                  AppLocalizations.of(context)!.start_preparation.capitalize(),
                  style: design.kButtonStyleBlack,
                ),
                const Icon(Icons.local_restaurant_rounded)
              ],
            );
          },
        ),
      ],
    );
  }
}

class ServingsDisplay extends StatelessWidget {
  const ServingsDisplay({
    super.key,
    required this.recipe,
  });

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    context
        .read<ServingsCounterBloc>()
        .add(InitializeServingsCounter(recipe.servings));

    return Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: design.kButtonInset),
        decoration: const BoxDecoration(
            color: design.kWhite, borderRadius: design.kSmallBorderRad),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            AppLocalizations.of(context)!.servings.capitalize(),
            style: design.kButtonStyleBlack,
          ),
          const SizedBox(
            width: design.kSmallInset,
          ),
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
                borderRadius: design.kSmallBorderRad, color: design.kAccent),
            child: Center(
              child: BlocBuilder<ServingsCounterBloc, ServingsCounterState>(
                builder: (context, state) {
                  int count = state is ServingsCounterSet
                      ? state.counter
                      : recipe.servings;
                  return Text(
                    "$count",
                    style: design.kButtonStyleWhite,
                  );
                },
              ),
            ),
          )
        ]));
  }
}
