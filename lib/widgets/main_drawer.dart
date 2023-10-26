import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key, required this.onSelectScreen});

  final Function(String identifier) onSelectScreen;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.fastfood,
                  size: 48,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 18),
                Text(
                  'Cooking up!',
                  style:
                      Theme.of(context).primaryTextTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                ),
              ],
            ),
          ),
          buildListTile(
            context,
            Icons.restaurant,
            'Meals',
            'meals',
          ),
          buildListTile(
            context,
            Icons.settings,
            'Settings',
            'filters',
          ),
          buildListTile(
            context,
            Icons.check_box,
            'Reviewed',
            'Reviewed',
          ),
        ],
      ),
    );
  }

  ListTile buildListTile(
      BuildContext context, IconData icon, String title, String screenId) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
        color: Theme.of(context).colorScheme.onBackground,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 24,
            ),
      ),
      onTap: () {
        onSelectScreen(screenId);
      },
    );
  }
}
