import 'package:flutter/material.dart';

import 'create_qr_view.dart';
import 'scan_qr_view.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentIndex = 0;

  static const List<Widget> screenPages = [
    CreateQRView(),
    ScanQRView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenPages.elementAt(currentIndex),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (int index) => setState(() {
          currentIndex = index;
        }),
        destinations: [
          NavigationDestination(
              selectedIcon: Icon(Icons.create),
              icon: Icon(Icons.create_outlined),
              label: 'create'),
          NavigationDestination(
              selectedIcon: Icon(Icons.qr_code_2),
              icon: Icon(Icons.qr_code_2_outlined),
              label: 'scan'),
        ],
      ),
    );
  }
}
