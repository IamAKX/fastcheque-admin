import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
    required this.navigateMenu,
  }) : super(key: key);

  final Function(int index) navigateMenu;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DrawerHeader(
              child: Container(
                width: double.infinity,
                child: Image.asset(
                  'assets/images/logo_64.png',
                  width: 50,
                  height: 50,
                ),
              ),
            ),
            DrawerMenu(
              title: 'Dashboard',
              svgSrc: 'assets/svg/dashboard.png',
              press: () {
                navigateMenu(0);
                if (Scaffold.of(context).isDrawerOpen) {
                  Navigator.of(context).pop();
                }
              },
            ),
            DrawerMenu(
              title: 'Transactions',
              svgSrc: 'assets/svg/transfer.png',
              press: () {
                navigateMenu(1);
                if (Scaffold.of(context).isDrawerOpen) {
                  Navigator.of(context).pop();
                }
              },
            ),
            DrawerMenu(
              title: 'Staff',
              svgSrc: 'assets/svg/user.png',
              press: () {
                navigateMenu(2);
                if (Scaffold.of(context).isDrawerOpen) {
                  Navigator.of(context).pop();
                }
              },
            ),
            DrawerMenu(
              title: 'Managers',
              svgSrc: 'assets/svg/manager.png',
              press: () {
                navigateMenu(3);
                if (Scaffold.of(context).isDrawerOpen) {
                  Navigator.of(context).pop();
                }
              },
            ),
            DrawerMenu(
              title: 'Stores',
              svgSrc: 'assets/svg/store.png',
              press: () {
                navigateMenu(4);
                if (Scaffold.of(context).isDrawerOpen) {
                  Navigator.of(context).pop();
                }
              },
            ),
            // DrawerMenu(
            //   title: 'Settings',
            //   svgSrc: 'assets/svg/settings.png',
            //   press: () {
            //     navigateMenu(0);
            //     if (Scaffold.of(context).isDrawerOpen) {
            //       Navigator.of(context).pop();
            //     }
            //   },
            // )
          ],
        ),
      ),
    );
  }
}

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 0,
      leading: Image.asset(
        svgSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
      onTap: press,
    );
  }
}
