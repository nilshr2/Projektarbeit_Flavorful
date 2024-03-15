import 'package:flavorful/bloc/translation/translation_bloc.dart';
import 'package:flavorful/bloc/translation/translation_helper.dart';
import 'package:flavorful/data/api/model/category.dart';
import 'package:flavorful/shared/components/tappable/tappable.dart';
import 'package:flavorful/shared/constants/design.dart' as design;
import 'package:flavorful/shared/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final void Function(int categoryId) nav;

  const CategoryCard({super.key, required this.category, required this.nav});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TranslationBloc, TranslationState>(
      builder: (_, ts) {
        DecorationImage? image = getCategoryImage();
        String categoryName = getCategoryName(ts);

        return Tappable(
          onTap: () {
            nav(category.id);
          },
          backgroundColor: design.kPrimary,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: design.kCategoryCardRad,
              color: design.kPrimary,
            ),
            height: 100,
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(design.kSmallInset),
                  width: 84,
                  height: 84,
                  decoration: BoxDecoration(
                    border: design.kSmallImageBorder,
                    borderRadius: design.kCategoryCardImageRad,
                    color: design.kWhite,
                    image: image,
                  ),
                ),
                Flexible(
                    child: Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.all(design.kSmallInset),
                  child: Text(categoryName, style: design.kH1TitleStyleWhite),
                ))
              ],
            ),
          ),
        );
      },
    );
  }

  DecorationImage? getCategoryImage() {
    return category.imageUrl != null
        ? DecorationImage(
            image: NetworkImage(
            category.imageUrl!,
          ))
        : null;
  }

  String getCategoryName(TranslationState ts) {
    return getSuccessOrNull(ts)?.categories[category.name]?.capitalize() ??
        category.name;
  }
}
