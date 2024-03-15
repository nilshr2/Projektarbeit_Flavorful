
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'selected_entry_event.dart';

part 'selected_entry_state.dart';

class SelectedEntryBloc<T extends Object>
    extends Bloc<SelectedEntryEvent, SelectedEntryState> {
  final Function(T)? onEntryChange;

  SelectedEntryBloc(this.onEntryChange) : super(SelectedEntryInitial()) {
    on<ChangeSelectedEntry<T>>((event, emit) {
      onEntryChange?.call(event.entry);
      emit(SelectedEntrySet<T>(event.entry));
    });
  }
}
