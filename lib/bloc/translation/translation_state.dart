part of 'translation_bloc.dart';

abstract class TranslationState extends Equatable {
  const TranslationState();
}

class TranslationInitial extends TranslationState {
  @override
  List<Object> get props => [];
}

class TranslationFailure extends TranslationState {
  @override
  List<Object> get props => [];
}

class TranslationSuccess extends TranslationState {
  final Map<String, String> categoryTypes;
  final Map<String, String> categories;
  final Map<String, String> recipes;
  final Map<String, String> ingredientsSingular;
  final Map<String, String> ingredientsPlural;
  final Map<String, String> instructions;
  final Map<String, String> units;

  const TranslationSuccess(
      {required this.categoryTypes,
      required this.categories,
      required this.recipes,
      required this.ingredientsSingular,
      required this.ingredientsPlural,
      required this.instructions,
      required this.units});

  Map<String, String> ingredients(bool plural) {
    return plural ? ingredientsPlural : ingredientsSingular;
  }

  @override
  List<Object> get props => [
        categoryTypes,
        categories,
        recipes,
        ingredientsSingular,
        instructions,
        units
      ];
}
