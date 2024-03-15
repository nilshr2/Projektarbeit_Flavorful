import 'translation_bloc.dart';

TranslationSuccess? getSuccessOrNull(TranslationState state) {
  if (state is TranslationSuccess) {
    return state;
  }
  return null;
}
