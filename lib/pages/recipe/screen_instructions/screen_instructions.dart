import 'package:flavorful/bloc/translation/translation_bloc.dart';
import 'package:flavorful/bloc/translation/translation_helper.dart';
import 'package:flavorful/data/api/model/recipe_ingredient.dart';
import 'package:flavorful/data/api/model/recipe_instruction.dart';
import 'package:flavorful/data/recipe_repository.dart';
import 'package:flavorful/shared/components/app_bar/custom_app_bar.dart';
import 'package:flavorful/shared/components/shader_mask/fade_in_out_shader.dart';
import 'package:flavorful/shared/components/tappable/tappable.dart';
import 'package:flavorful/shared/components/tappable/tappable_button.dart';
import 'package:flavorful/shared/extensions.dart';
import 'package:flavorful/shared/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flavorful/shared/constants/design.dart' as design;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../recipe_ingredient_display.dart';
import 'bloc/recipe_instructions/recipe_instructions_bloc.dart';

class ScreenInstructions extends StatefulWidget {
  final int recipeId;
  final double? factor;

  const ScreenInstructions(
      {super.key, required this.recipeId, required this.factor});

  @override
  State<ScreenInstructions> createState() => _ScreenInstructionsState();
}

class _ScreenInstructionsState extends State<ScreenInstructions> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.485);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecipeInstructionsBloc(
          RepositoryProvider.of<RecipeRepository>(context))
        ..add(FetchRecipeInstructions(widget.recipeId)),
      child: BlocBuilder<TranslationBloc, TranslationState>(
        builder: (_, ts) {
          return Scaffold(
              appBar: const CustomAppBar(
                  foregroundColor: design.kBlack,
                  backgroundColor: Colors.transparent),
              backgroundColor: design.kWhite,
              body:
                  BlocBuilder<RecipeInstructionsBloc, RecipeInstructionsState>(
                builder: (context, state) {
                  if (state is RecipeInstructionsSuccess) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: design.kNormalInset),
                      child: Row(children: [
                        Expanded(
                          child: Center(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                  maxWidth: Device.kPcBreakpoint),
                              child: FadeInOutShader(
                                child: PageView.builder(
                                  controller: _pageController,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    List<TextSpan> instructionSpans =
                                        getInstructionSpans(ts, state, index);

                                    return Instruction(
                                        index: index,
                                        isLastInstruction: index ==
                                            state.recipeInstructions.length - 1,
                                        onTap: () => onTapInstruction(index),
                                        instructionSpans: instructionSpans);
                                  },
                                  itemCount: state.recipeInstructions.length,
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (Screen(context).device != Device.phone) ...[
                          const SizedBox(
                            width: design.kNormalInset,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TappableButton(
                                onTap: goToPrevPage,
                                content: const [
                                  Icon(Icons.arrow_upward_rounded),
                                ],
                                boxShadow: const [design.kNormalBoxShadow],
                              ),
                              const SizedBox(
                                height: design.kSmallInset,
                              ),
                              TappableButton(
                                onTap: goToNextPage,
                                content: const [
                                  Icon(Icons.arrow_downward_rounded),
                                ],
                                boxShadow: const [design.kNormalBoxShadow],
                              ),
                            ],
                          ),
                        ],
                      ]),
                    );
                  }
                  return const Center(
                      child: design.kNormalCircularProgressIndicator);
                },
              ));
        },
      ),
    );
  }

  void onTapInstruction(index) {
    double? page = _pageController.page;
    if (page != null) {
      if (page.round() > index) {
        goToPrevPage();
      } else if (page.round() < index) {
        goToNextPage();
      }
    }
  }

  void goToNextPage() => _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.linearToEaseOut,
      );

  void goToPrevPage() => _pageController.previousPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.linearToEaseOut,
      );

  /// Gets the styled TextSpans of the instruction.
  List<TextSpan> getInstructionSpans(
      TranslationState ts, RecipeInstructionsSuccess state, int index) {
    List<TextSpan> textSpans = [];
    //Replaces all referenced ingredient ids with their translation, quantity and unit.
    String text = getSuccessOrNull(ts)
            ?.instructions[state.recipeInstructions[index].instruction] ??
        state.recipeInstructions[index].instruction;
    text.splitMapJoin(RegExp(r"{([^}]*)}"), onMatch: (match) {
      String ingredient = match[0]!.replaceAll(RegExp(r"[{,}]"), "");
      textSpans.add(TextSpan(
          text: getIngredientText(ingredient, state.recipeIngredients,
              state.recipeInstructions, index, ts),
          style: design.kH1TitleStylePrimaryBold));
      return '';
    }, onNonMatch: (String text) {
      textSpans.add(TextSpan(
        text: text,
      ));
      return '';
    });
    return textSpans;
  }

  ///Gets the ingredient properties as a displayable string.
  String getIngredientText(
      String ingredient,
      List<RecipeIngredient> recipeIngredients,
      List<RecipeInstruction> recipeInstructions,
      int index,
      TranslationState ts) {
    RecipeIngredient recipeIngredient = recipeIngredients.firstWhere((e) =>
        e.instructionId == recipeInstructions[index].id &&
        e.ingredient == ingredient);
    String quantity = RecipeIngredientDisplay.getQuantity(
        recipeIngredient, widget.factor ?? 1);
    String unit =
        RecipeIngredientDisplay.getTranslatedUnit(recipeIngredient, ts);
    String translatedIngredient =
        RecipeIngredientDisplay.getTranslatedIngredient(recipeIngredient, ts);
    return "$quantity$unit$translatedIngredient";
  }
}

class Instruction extends StatelessWidget {
  final int index;
  final bool isLastInstruction;
  final Function() onTap;
  final List<TextSpan> instructionSpans;

  const Instruction({
    super.key,
    required this.index,
    required this.onTap,
    this.isLastInstruction = false,
    required this.instructionSpans,
  });

  @override
  Widget build(BuildContext context) {
    return Tappable(
      showAnimation: false,
      onTap: onTap,
      child: FractionallySizedBox(
        heightFactor: 1,
        child: Container(
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                          children: instructionSpans,
                          style: design.kH1TitleStyleBlack),
                    ),
                    //Add a "Finish"-Button if the instruction is the last one
                    if (isLastInstruction) const FinishButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FinishButton extends StatelessWidget {
  const FinishButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(design.kNormalInset),
          child: TappableButton(
              onTap: () => context.pop(),
              color: design.kPrimary,
              content: [
                Text(
                  AppLocalizations.of(context)!.finish.capitalize(),
                  style: design.kButtonStyleWhite,
                )
              ]),
        ),
      ],
    );
  }
}
