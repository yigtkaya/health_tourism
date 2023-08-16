import 'package:flutter/material.dart';
import 'package:health_tourism/core/components/ht_icon.dart';
import 'package:health_tourism/core/constants/asset.dart';

class CustomBottomNavBar extends StatefulWidget {
  final int defaultSelectedIndex;
  final Function(int) onChange;

  const CustomBottomNavBar({
    super.key,
    this.defaultSelectedIndex = 0,
    required this.onChange,
  });

  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(3), topRight: Radius.circular(3))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    widget.onChange(0);
                    setState(() {
                      _selectedIndex = 0;
                    });
                  },
                  child: _selectedIndex == 0
                      ? HTIcon(iconName: AssetConstants.icons.homeSelected, width: 24, height: 24,)
                      : HTIcon(iconName: AssetConstants.icons.homeUnSelected, width: 24, height: 24,),
                ),
                GestureDetector(
                  onTap: () {
                    widget.onChange(1);
                    setState(() {
                      _selectedIndex = 1;
                    });
                  },
                  child: _selectedIndex == 1
                      ? HTIcon(iconName: AssetConstants.icons.messageSelected, width: 24, height: 24,)
                      : HTIcon(iconName: AssetConstants.icons.messageUnSelected, width: 24, height: 24,),
                ),
                GestureDetector(
                  onTap: () {
                    widget.onChange(2);
                    setState(() {
                      _selectedIndex = 2;
                    });
                  },
                  child: _selectedIndex == 2
                      ? HTIcon(iconName: AssetConstants.icons.profileSelected, width: 24, height: 24,)
                      : HTIcon(iconName: AssetConstants.icons.profileUnSelected, width: 24, height: 24,),
                ),
              ],
            ),

          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.0),
                color: const Color(0xFF123258),
              ),
              height: size.height * 0.006,
              width: size.width * 0.4,
            ),
          ),
        ],
      ),
    );
  }
}
