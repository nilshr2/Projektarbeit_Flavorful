import 'package:flavorful/bloc/translation/translation_bloc.dart';
import 'package:flavorful/bloc/translation/translation_helper.dart';
import 'package:flavorful/data/api/model/recipe.dart';
import 'package:flutter/material.dart';
import 'package:flavorful/shared/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flavorful/shared/constants/design.dart' as design;

class RecipeInformation extends StatelessWidget {
  const RecipeInformation({
    super.key,
    required this.recipe,
    required this.imageHeight,
    required this.imageOffset,
  });

  final Recipe recipe;
  final double imageHeight;
  final double imageOffset;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TranslationBloc, TranslationState>(
      builder: (_, ts) {
        String recipeName = getRecipeName(ts);

        return ConstrainedBox(
          constraints: BoxConstraints(minHeight: imageHeight),
          child: Row(
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(design.kNormalInset),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recipeName,
                        style: design.kH1TitleStyleWhiteBold,
                      ),
                      const Divider(
                        color: design.kWhite,
                      ),
                      RecipeProperties(recipe: recipe),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: imageHeight - imageOffset,
              )
            ],
          ),
        );
      },
    );
  }

  String getRecipeName(TranslationState ts) {
    return getSuccessOrNull(ts)?.recipes[recipe.name]?.capitalize() ??
        recipe.name;
  }
}

class RecipeProperties extends StatelessWidget {
  const RecipeProperties({
    super.key,
    required this.recipe,
  });

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    String calories = getCalories(context);
    String duration = getDuration();
    String inactiveDuration = getInactiveDuration(context);

    return Column(
      children: [
        const SizedBox(
          height: design.kSmallInset,
        ),
        RecipeProperty(
          text: calories,
          iconData: Icons.local_fire_department_rounded,
        ),
        const SizedBox(
          height: design.kSmallInset,
        ),
        RecipeProperty(
          text: duration,
          iconData: Icons.timer_rounded,
        ),
        const SizedBox(
          height: design.kSmallInset,
        ),
        inactiveDuration.isNotEmpty
            ? RecipeProperty(
                text: inactiveDuration,
                iconData: Icons.schedule_rounded,
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  String getCalories(BuildContext context) =>
      "${recipe.calories} ${AppLocalizations.of(context)!.calories_per_serving}";

  String getDuration() => Duration(minutes: recipe.duration).formatToString();

  String getInactiveDuration(BuildContext context) {
    return (recipe.inactiveDuration != null)
        ? "${Duration(minutes: recipe.inactiveDuration!).formatToString()} ${AppLocalizations.of(context)!.waiting}"
        : "";
  }
}

class RecipeProperty extends StatelessWidget {
  final IconData iconData;
  final String text;

  const RecipeProperty({
    super.key,
    required this.iconData,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          iconData,
          color: design.kWhite,
        ),
        const SizedBox(
          width: design.kTextSpacingInset,
        ),
        Flexible(
          child: Text(
            text,
            maxLines: 2,
            style: design.kH3TitleStyleWhite,
          ),
        ),
      ],
    );
  }
}
