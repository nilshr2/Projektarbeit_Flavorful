import 'package:flutter/material.dart';

import 'package:flavorful/shared/constants/design.dart' as design;

class BottomSheetHandle extends StatelessWidget {
  const BottomSheetHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.transparent,
      height: 16,
      child: Center(
        child: Container(
          height: 4,
          width: 32,
          decoration: const BoxDecoration(
              color: design.kWhite, borderRadius: design.kNormalBorderRad),
        ),
      ),
    );
  }
}
