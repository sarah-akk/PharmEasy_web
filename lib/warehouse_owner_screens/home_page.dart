import 'package:flutter/material.dart';

import 'Dashboard.dart';

class HomePage extends StatelessWidget {

  static const routeName = '/HomePageDesktop';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 1200),
        child: HomePageDesktop(),
      ),
    );
  }
}
