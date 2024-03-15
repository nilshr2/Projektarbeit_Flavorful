import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flavorful/shared/constants/design.dart' as design;

class CustomScaffold extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const CustomScaffold({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        backgroundColor: design.kWhite,
        indicatorColor: design.kWhite,
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) => navigationShell.goBranch(index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: ""),
          NavigationDestination(
            icon: Icon(Icons.book),
            label: "",
          ),
        ],
      ),
    );
  }
}
