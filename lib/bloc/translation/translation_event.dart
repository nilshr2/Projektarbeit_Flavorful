part of 'translation_bloc.dart';

abstract class TranslationEvent extends Equatable {
  const TranslationEvent();
}

class FetchTranslations extends TranslationEvent {
  final String languageId;

  const FetchTranslations(this.languageId);

  @override
  List<Object> get props => [languageId];
}
