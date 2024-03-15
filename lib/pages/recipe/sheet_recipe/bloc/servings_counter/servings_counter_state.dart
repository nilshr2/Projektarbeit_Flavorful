part of 'servings_counter_bloc.dart';

abstract class ServingsCounterState extends Equatable {
  const ServingsCounterState();
}

class ServingsCounterInitial extends ServingsCounterState {
  @override
  List<Object> get props => [];
}

class ServingsCounterSet extends ServingsCounterState {
  final int initialValue;
  final int counter;
  final double factor;

  const ServingsCounterSet({
    required this.initialValue,
    required this.counter,
  }) : factor = counter / initialValue;

  @override
  List<Object> get props => [counter];
}
