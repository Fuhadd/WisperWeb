import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.desktopScaffold,
    required this.mobileScaffold,
    required this.tabletScaffold,
  });
  final Widget mobileScaffold;
  final Widget tabletScaffold;
  final Widget desktopScaffold;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 550) {
        return mobileScaffold;
      } else if (constraints.maxWidth < 850) {
        return tabletScaffold;
      } else {
        return desktopScaffold;
      }
    });
  }
}
