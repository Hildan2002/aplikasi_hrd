import 'package:flutter/material.dart';

import 'responsive_desktop/desktop_body.dart';
import 'responsive_desktop/mobile_body.dart';
import 'responsive_desktop/responsive layout.dart';
import 'responsive_desktop/tablet_body.dart';

class DashboardFilter extends StatelessWidget {
  const DashboardFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: ResponsiveLayout(
        mobileBody: const MobileScaffold(),
        tabletBody: const TabletScaffold(),
        desktopBody: const DesktopScaffold(),
      ),
    );
  }
}
