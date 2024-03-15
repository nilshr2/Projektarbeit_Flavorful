
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flavorful/data/api/model/recipe.dart';
import 'package:flavorful/data/recipe_repository.dart';

part 'recipe_event.dart';

part 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final RecipeRepository recipeRepository;

  RecipeBloc(this.recipeRepository) : super(RecipeInitial()) {
    on<FetchRecipe>((event, emit) async {
      try {
        Recipe recipe = await recipeRepository.getRecipe(event.recipeId);
        emit(RecipeSuccess(recipe));
      } catch (e) {
        emit(RecipeFailure());
      }
    });
  }
}
