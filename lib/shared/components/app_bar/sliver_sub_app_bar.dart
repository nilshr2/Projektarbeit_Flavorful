import 'package:flutter/material.dart';

import 'package:flavorful/shared/constants/design.dart' as design;

class SliverSubAppBar extends StatelessWidget {
  final Widget title;

  const SliverSubAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: design.kWhite,
      foregroundColor: design.kBlack,
      elevation: 0,
      titleSpacing: design.kNormalInset,
      scrolledUnderElevation: 0,
      floating: true,
      snap: true,
      centerTitle: false,
      toolbarHeight: kToolbarHeight - 8,
      title: Padding(
          padding: const EdgeInsets.only(bottom: design.kSmallInset),
          child: title),
    );
  }
}
