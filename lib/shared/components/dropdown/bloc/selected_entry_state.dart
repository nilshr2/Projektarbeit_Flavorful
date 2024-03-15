part of 'selected_entry_bloc.dart';

abstract class SelectedEntryState<T extends Object> extends Equatable {
  const SelectedEntryState();
}

class SelectedEntryInitial<T extends Object> extends SelectedEntryState {
  @override
  List<Object> get props => [];
}

final class SelectedEntrySet<T extends Object> extends SelectedEntryState {
  final T entry;

  const SelectedEntrySet(this.entry);

  @override
  List<Object> get props => [entry];
}
