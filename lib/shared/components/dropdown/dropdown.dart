import 'package:flavorful/shared/components/tappable/tappable.dart';
import 'package:flutter/material.dart';

import 'package:flavorful/shared/constants/design.dart' as design;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/selected_entry_bloc.dart';

class Dropdown<T extends Object> extends StatefulWidget {
  final List<T> entries;
  final String Function(T) getString;
  final VoidCallback? onToggle;
  final Function(T)? onChange;

  const Dropdown({
    super.key,
    required this.entries,
    required this.getString,
    this.onToggle,
    this.onChange,
  });

  @override
  State<Dropdown<T>> createState() => _DropdownState<T>();
}

class _DropdownState<T extends Object> extends State<Dropdown<T>> {
  final OverlayPortalController _controller = OverlayPortalController();

  final _link = LayerLink();

  void _onToggleMenu() {
    widget.onToggle?.call();
    _controller.toggle();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _link,
      child: BlocProvider(
        create: (context) => SelectedEntryBloc<T>(widget.onChange),
        child: Builder(builder: (context) {
          if (widget.entries.isNotEmpty) {
            context
                .read<SelectedEntryBloc<T>>()
                .add(ChangeSelectedEntry<T>(widget.entries[0]));
          }
          return OverlayPortal.targetsRootOverlay(
              controller: _controller,
              overlayChildBuilder: (ctx) {
                return Stack(
                  children: [
                    Container(
                      color: Colors.transparent,
                    ),
                    TapRegion(
                      onTapOutside: (PointerDownEvent event) {
                        _onToggleMenu();
                      },
                      child: CompositedTransformFollower(
                        link: _link,
                        targetAnchor: Alignment.bottomLeft,
                        child: Align(
                          alignment: AlignmentDirectional.topStart,
                          child: DropdownEntries<T>(
                            entries: widget.entries,
                            getString: widget.getString,
                            onChange: (_) {
                              _onToggleMenu();
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
              child: DropdownButton<T>(
                getString: widget.getString,
                onTap: _onToggleMenu,
              ));
        }),
      ),
    );
  }
}

class DropdownEntries<T extends Object> extends StatelessWidget {
  final List<T> entries;
  final String Function(T) getString;
  final Function(T) onChange;

  const DropdownEntries({
    super.key,
    required this.entries,
    required this.getString,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: design.kSmallInset),
      child: Container(
        width: 150,
        decoration: design.kDropdownOuterContainerDecoration,
        padding: const EdgeInsets.symmetric(vertical: design.kSmallInset),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: (entries.isNotEmpty)
              ? entries
                  .map<Widget>((entry) => Tappable(
                        onTap: () {
                          context
                              .read<SelectedEntryBloc<T>>()
                              .add(ChangeSelectedEntry<T>(entry));
                          onChange(entry);
                        },
                        child: Container(
                          height: 34,
                          padding: const EdgeInsets.symmetric(
                              horizontal: design.kNormalInset),
                          decoration:
                              const BoxDecoration(color: Colors.transparent),
                          child: Row(
                            children: [
                              Text(
                                getString(entry),
                                style: design.kDropdownEntryStyle,
                              ),
                            ],
                          ),
                        ),
                      ))
                  .toList()
              : [],
        ),
      ),
    );
  }
}

class DropdownButton<T extends Object> extends StatelessWidget {
  final String Function(T) getString;
  final Function() onTap;

  const DropdownButton({
    super.key,
    required this.getString,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedEntryBloc<T>, SelectedEntryState>(
      builder: (context, state) {
        return Tappable(
          onTap: state is SelectedEntrySet<T> ? onTap : () {},
          child: Container(
              height: 34,
              padding:
                  const EdgeInsets.symmetric(horizontal: design.kSmallInset),
              decoration: design.kDropdownInnerContainerDecoration,
              child: Row(
                children: state is SelectedEntrySet<T>
                    ? [
                        Text(getString(state.entry),
                            style: design.kDropdownSelectedEntryStyle),
                        const Icon(
                          Icons.arrow_drop_down_rounded,
                          color: design.kAccent,
                        )
                      ]
                    : [design.kSmallCircularProgressIndicator],
              )),
        );
      },
    );
  }
}
