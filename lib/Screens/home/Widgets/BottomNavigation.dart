import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:money_manager/Screens/home/Screen_home.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MoneymangerBottomNavigationbar extends StatelessWidget {
  const MoneymangerBottomNavigationbar({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Screen_Home.Notifier_index,
        builder: (BuildContext ctx, newValue, Widget? _) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: CustomNavigationBar(
              unSelectedColor: Colors.white70,
              selectedColor: Colors.teal,
              onTap: (value) {
                Screen_Home.Notifier_index.value = value;
              },
              currentIndex: newValue,
              backgroundColor: Colors.teal,
              borderRadius: const Radius.circular(10),
              items: [
                CustomNavigationBarItem(
                    icon: SvgPicture.asset(
                  'assets/icons/Home.svg',
                  height: 35,
                  width: 35,
                  colorFilter: ColorFilter.mode(
                      newValue == 0 ? Colors.white : Colors.white70,
                      BlendMode.srcIn),
                )),
                CustomNavigationBarItem(
                    icon: SvgPicture.asset(
                  'assets/icons/Category.svg',
                  height: 35,
                  width: 35,
                  colorFilter: ColorFilter.mode(
                      newValue == 1 ? Colors.white : Colors.white70,
                      BlendMode.srcIn),
                ))
              ],
            ),
          );
        });
  }
}
