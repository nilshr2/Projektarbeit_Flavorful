import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flavorful/data/translation_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'translation_event.dart';

part 'translation_state.dart';

class TranslationBloc extends Bloc<TranslationEvent, TranslationState> {
  final TranslationRepository translationRepository;

  TranslationBloc(this.translationRepository) : super(TranslationInitial()) {
    on<FetchTranslations>((event, emit) async {
      try {
        List<Map<String, String>> translations = await Future.wait([
          translationRepository.getCategoryTypesTranslations(event.languageId),
          translationRepository.getCategoriesTranslations(event.languageId),
          translationRepository.getRecipesTranslations(event.languageId),
          translationRepository
              .getIngredientsSingularTranslations(event.languageId),
          translationRepository
              .getIngredientsPluralTranslations(event.languageId),
          translationRepository.getInstructionsTranslations(event.languageId),
          translationRepository.getUnitsTranslations(event.languageId),
        ]);

        emit(TranslationSuccess(
            categoryTypes: translations[0],
            categories: translations[1],
            recipes: translations[2],
            ingredientsSingular: translations[3],
            ingredientsPlural: translations[4],
            instructions: translations[5],
            units: translations[6]));
      } catch (e) {
        emit(TranslationFailure());
      }
    });
  }
}
