import 'package:fastcheque_admin/screen/dashboard/dashboard_screen.dart';
import 'package:fastcheque_admin/screen/main/side_menu.dart';
import 'package:fastcheque_admin/screen/managers/managers_screen.dart';
import 'package:fastcheque_admin/screen/store/store_screen.dart';
import 'package:fastcheque_admin/screen/transactions/transactions_screen.dart';
import 'package:fastcheque_admin/screen/users/users_screen.dart';
import 'package:fastcheque_admin/utils/constants.dart';
import 'package:fastcheque_admin/widgets/responsive.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentMenuIndex = 0;

  Widget getMenuFromIndex() {
    switch (_currentMenuIndex) {
      case 0:
        return DashboardScreen();
      case 1:
        return TransactionsScreen();
      case 2:
        return UsersScreen();
      case 3:
        return ManagersScreen();
      case 4:
        return StoreScreen();
      default:
        return StoreScreen();
    }
  }

  navigateMenu(int index) {
    setState(() {
      _currentMenuIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(
        navigateMenu: (int index) {
          navigateMenu(index);
        },
      ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                child: SideMenu(
                  navigateMenu: (int index) {
                    navigateMenu(index);
                  },
                ),
              ),
            Expanded(
              flex: 5,
              child: getMenuFromIndex(),
            ),
          ],
        ),
      ),
    );
  }
}
