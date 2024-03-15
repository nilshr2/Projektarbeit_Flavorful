import 'package:flavorful/bloc/translation/translation_bloc.dart';
import 'package:flavorful/bloc/translation/translation_helper.dart';
import 'package:flavorful/data/api/model/recipe.dart';
import 'package:flavorful/shared/components/tappable/tappable.dart';
import 'package:flavorful/shared/constants/design.dart' as design;
import 'package:flavorful/shared/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final void Function(int recipeId) nav;

  const RecipeCard({super.key, required this.recipe, required this.nav});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TranslationBloc, TranslationState>(
      builder: (_, ts) {
        DecorationImage? image = getRecipeImage();
        String recipeName = getRecipeName(ts);

        return Tappable(
            onTap: () {
              nav(recipe.id);
            },
            backgroundColor: design.kPrimary,
            child: Stack(
              children: [
                Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: design.kLargeBorderRad,
                          color: design.kAccent,
                          image: image,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    )
                  ],
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  top: 0,
                  child: Transform.translate(
                    offset: const Offset(-5, 0),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius: design.kSmallBorderRad,
                            color: design.kPrimary,
                            boxShadow: [design.kNormalBoxShadow]),
                        padding: const EdgeInsets.all(design.kSmallInset),
                        child: Text(
                          recipeName,
                          textAlign: TextAlign.left,
                          textWidthBasis: TextWidthBasis.longestLine,
                          style: design.kH2TitleStyleWhite,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }

  DecorationImage? getRecipeImage() {
    return recipe.imageUrl != null
        ? DecorationImage(
            image: NetworkImage(
            recipe.imageUrl!,
          ))
        : null;
  }

  String getRecipeName(TranslationState ts) {
    return getSuccessOrNull(ts)?.recipes[recipe.name]?.capitalize() ??
        recipe.name;
  }
}
