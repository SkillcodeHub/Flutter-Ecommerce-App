import 'package:ecommerce/Res/colors.dart';
import 'package:ecommerce/Res/images.dart';
import 'package:ecommerce/Utils/Extensions/string_extensions.dart';
import 'package:ecommerce/View/Bag/BagScreen/bagScreen.dart';
import 'package:ecommerce/View/Favorites/FavoritesScreen/favoritesScreen.dart';
import 'package:ecommerce/View/Home/HomeScreen/homeScreen.dart';
import 'package:ecommerce/View/Profile/ProfileScreen/profileScreen.dart';
import 'package:ecommerce/View/Shop/ShopScreen/shopScreen.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class MyNavigationBar extends StatefulWidget {
  final int indexNumber;

  const MyNavigationBar({Key? key, required this.indexNumber})
      : super(key: key);

  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  double iconSize = 24;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ValueNotifier<int>>(
      create: (_) => ValueNotifier<int>(widget.indexNumber),
      child: Consumer<ValueNotifier<int>>(
        builder: (context, selectedIndexProvider, _) {
          final selectedIndex = selectedIndexProvider.value;

          final List<Widget> user = [
            HomeScreen(),
            ShopScreen(),
            BagScreen(),
            FavoritesScreen(),
            ProfileScreen(),
          ];

          void _onItemTapped(int index) {
            selectedIndexProvider.value = index;
          }

          return Scaffold(
              body: user[selectedIndex],
              bottomNavigationBar:
                  // SizerUtil.deviceType == DeviceType.mobile
                  //     ?
                  BottomNavigationBar(
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: ic_dashboard.iconImage(
                        size: iconSize, color: disableButtonColor),
                    activeIcon: Image.asset(ic_dashboardFill,
                        height: iconSize, width: iconSize),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: ic_Shop.iconImage(
                        size: iconSize, color: disableButtonColor),
                    activeIcon: Image.asset(ic_ShopFill,
                        height: iconSize, width: iconSize),
                    label: 'Shop',
                  ),
                  BottomNavigationBarItem(
                    icon: ic_Bag.iconImage(
                        size: iconSize, color: disableButtonColor),
                    activeIcon: Image.asset(ic_BagFill,
                        height: iconSize, width: iconSize),
                    label: 'Bag',
                  ),
                  BottomNavigationBarItem(
                    icon: ic_Favorite.iconImage(
                        size: iconSize, color: disableButtonColor),
                    activeIcon: Image.asset(ic_FavoriteFill,
                        height: iconSize, width: iconSize),
                    label: 'Favorite',
                  ),
                  BottomNavigationBarItem(
                    icon: ic_Profile.iconImage(
                        size: iconSize, color: disableButtonColor),
                    activeIcon: Image.asset(ic_ProfileFill,
                        height: iconSize, width: iconSize),
                    label: 'Profile',
                  ),
                ],
                // showSelectedLabels: false,
                // showUnselectedLabels: false,
                selectedLabelStyle: TextStyle(color: Colors.red),
                unselectedLabelStyle: TextStyle(color: Colors.grey),
                selectedItemColor: Theme.of(context).iconTheme.color,
                backgroundColor: context.cardColor,
                mouseCursor: MouseCursor.uncontrolled,
                currentIndex: selectedIndex,
                onTap: _onItemTapped,
                type: BottomNavigationBarType.fixed,
                elevation: 12,
                unselectedItemColor: Colors.grey.shade600,
              )
              // : BottomNavigationBar(
              //     items: <BottomNavigationBarItem>[
              //       BottomNavigationBarItem(
              //         icon: ic_dashboard.iconImage(
              //             size: 4.h, color: secondaryTxtColor),
              //         activeIcon: Image.asset(ic_dashboardFill,
              //             height: 4.h, width: 4.h),
              //         label: 'Home',
              //       ),
              //       BottomNavigationBarItem(
              //         icon: ic_calendar.iconImage(
              //             size: 4.h, color: secondaryTxtColor),
              //         activeIcon: Image.asset(ic_calendarFill,
              //             height: 4.h, width: 4.h),
              //         label: 'Bill History',
              //       ),
              //       BottomNavigationBarItem(
              //         icon: ic_patient.iconImage(
              //             size: 4.h, color: secondaryTxtColor),
              //         activeIcon: Image.asset(ic_patientFill,
              //             height: 4.h, width: 4.h),
              //         label: 'My Account',
              //       ),
              //     ],
              //     // showSelectedLabels: false,
              //     // showUnselectedLabels: false,
              //     selectedLabelStyle:
              //         TextStyle(fontSize: 20), // Adjust the font size
              //     unselectedLabelStyle: TextStyle(fontSize: 20),
              //     selectedItemColor: Theme.of(context).iconTheme.color,
              //     backgroundColor: context.cardColor,
              //     mouseCursor: MouseCursor.uncontrolled,
              //     currentIndex: selectedIndex,
              //     onTap: _onItemTapped,
              //     type: BottomNavigationBarType.fixed,
              //     elevation: 12,
              //     unselectedItemColor: Colors.grey.shade600,
              //   ),

              );
        },
      ),
    );
  }
}
