import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/components/ht_text.dart';
import '../../core/constants/vertical_space.dart';
import '../../product/theme/styles.dart';

class HelpView extends StatefulWidget {
  final String title;
  const HelpView({super.key, required this.title});

  @override
  State<HelpView> createState() => _HelpViewState();
}

class _HelpViewState extends State<HelpView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
        ),
        backgroundColor: const Color(0xff2D9CDB),
        elevation: 0,
        centerTitle: true,
        title: HTText(
          label: widget.title,
          style: htToolBarLabel,
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("data")
          ],
        ),
      )
    );
  }
}
