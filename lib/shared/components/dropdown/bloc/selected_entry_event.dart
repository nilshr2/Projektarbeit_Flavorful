part of 'selected_entry_bloc.dart';

abstract class SelectedEntryEvent<T extends Object> extends Equatable {
  const SelectedEntryEvent();
}

class ChangeSelectedEntry<T extends Object> extends SelectedEntryEvent {
  final T entry;

  const ChangeSelectedEntry(this.entry);

  @override
  List<Object> get props => [entry];
}
