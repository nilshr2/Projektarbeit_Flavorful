
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'servings_counter_event.dart';

part 'servings_counter_state.dart';

class ServingsCounterBloc
    extends Bloc<ServingsCounterEvent, ServingsCounterState> {
  ServingsCounterBloc() : super(ServingsCounterInitial()) {
    on<InitializeServingsCounter>((event, emit) {
      emit(ServingsCounterSet(
          initialValue: event.counter, counter: event.counter));
    });

    on<IncrementServingsCounter>((event, emit) {
      if (state is ServingsCounterSet) {
        ServingsCounterSet prev = (state as ServingsCounterSet);
        if (prev.counter < 99) {
          emit(ServingsCounterSet(
              initialValue: prev.initialValue, counter: prev.counter + 1));
        }
      }
    });

    on<DecrementServingsCounter>((event, emit) {
      if (state is ServingsCounterSet) {
        ServingsCounterSet prev = (state as ServingsCounterSet);
        if (prev.counter > 1) {
          emit(ServingsCounterSet(
              initialValue: prev.initialValue, counter: prev.counter - 1));
        }
      }
    });
  }
}
