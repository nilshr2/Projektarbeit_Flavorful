part of 'servings_counter_bloc.dart';

abstract class ServingsCounterEvent extends Equatable {
  const ServingsCounterEvent();
}

class InitializeServingsCounter extends ServingsCounterEvent {
  final int counter;

  const InitializeServingsCounter(this.counter);

  @override
  List<Object?> get props => [counter];
}

class IncrementServingsCounter extends ServingsCounterEvent {
  @override
  List<Object?> get props => [];
}

class DecrementServingsCounter extends ServingsCounterEvent {
  @override
  List<Object?> get props => [];
}
