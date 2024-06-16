import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/theme/theme_bloc.dart';
import '../utils/app_router.dart';
import '../utils/theme/themes.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return DrawerHeader(
                decoration: BoxDecoration(
                    gradient: Themes.getTheme().linearGradient,
                    image: DecorationImage(
                        image: AssetImage('assets/images/drawer.jpg'),
                        fit: BoxFit.fill)),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                          tag: 'logo',
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 50,
                            child: Image.asset(
                              'assets/images/icon1.png',
                            ),
                          )),
                      const Text(
                        'DartMusic',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_circle_sharp),
            title: const Text('Account'),
            onTap: () {
              Navigator.of(context).pushNamed(AppRouter.settingsRoute);
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Credits'),
            onTap: () {
              Navigator.of(context).pushNamed(AppRouter.aboutRoute);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Theme'),
            onTap: () {
              Navigator.of(context).pushNamed(AppRouter.settingsRoute);
            },
          ),
        ],
      ),
    );
  }
}
