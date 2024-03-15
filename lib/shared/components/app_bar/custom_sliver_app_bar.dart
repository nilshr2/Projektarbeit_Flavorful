import 'package:flutter/material.dart';

import 'package:flavorful/shared/constants/design.dart' as design;

class SliverCustomAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String? title;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool pinned;

  const SliverCustomAppBar(
      {super.key,
      this.title,
      this.backgroundColor = design.kWhite,
      this.foregroundColor = design.kBlack,
      this.pinned = false});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      elevation: 0,
      titleSpacing: design.kNormalInset,
      scrolledUnderElevation: 0,
      centerTitle: false,
      pinned: pinned,
      title: (title != null)
          ? Text(title!, style: design.kAppBarTitleStyle)
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
