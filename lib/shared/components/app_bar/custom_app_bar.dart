import 'package:flutter/material.dart';

import 'package:flavorful/shared/constants/design.dart' as design;

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const CustomAppBar(
      {super.key,
      this.title,
      this.backgroundColor = design.kWhite,
      this.foregroundColor = design.kBlack});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      titleSpacing: design.kNormalInset,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      title: (title != null)
          ? Text(title!, style: design.kAppBarTitleStyle)
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
