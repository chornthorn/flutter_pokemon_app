import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/application/change_language/change_language_bloc.dart';
import '../../app/application/change_theme/change_theme_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  static const String routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Settings",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: Column(
                  children: [
                    BlocSelector<ChangeThemeBloc, ChangeThemeState, ThemeMode>(
                      selector: (state) {
                        return state.themeMode;
                      },
                      builder: (context, state) {
                        return SettingsCardItem(
                          title: "Dark Mode",
                          subtitle: "Enable dark mode",
                          icon: Icons.dark_mode,
                          isSwitch: true,
                          value: state == ThemeMode.dark,
                          onSwitchChanged: (value) {
                            BlocProvider.of<ChangeThemeBloc>(context).add(
                                ChangeTheme(
                                    value ? ThemeMode.dark : ThemeMode.light));
                          },
                        );
                      },
                    ),
                    const SizedBox(width: 12),
                    SettingsCardItem(
                      title: "Language",
                      subtitle: "Change language",
                      icon: Icons.language,
                      onTap: () {
                        showBottomSheet(context);
                      },
                    ),
                    const SizedBox(width: 12),
                    SettingsCardItem(
                      title: "About",
                      subtitle: "About this app",
                      icon: Icons.info,
                      onTap: () {
                        showSimpleAboutDialog(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // show about dialog
  void showSimpleAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Flutter Demo',
      applicationVersion: '1.0.0',
      applicationIcon: const FlutterLogo(),
      applicationLegalese: '© 2021 Flutter Demo',
      children: [
        const SizedBox(height: 16),
        const Text('Flutter Demo is a demo app for Flutter learning purpose.'),
      ],
    );
  }

// show bottom sheet for switch language with container shadow and radius
  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                spreadRadius: 0,
                blurRadius: 4,
                offset: const Offset(0, -4), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              Container(
                width: 40,
                child: Divider(
                  color: Theme.of(context).dividerColor,
                  thickness: 3,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 8),
                    child: const Text(
                      "Please select your language",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: BlocSelector<ChangeLanguageBloc, ChangeLanguageState,
                    Locale>(
                  selector: (state) {
                    return state.locale;
                  },
                  builder: (context, state) {
                    print(state);
                    return Column(
                      children: [
                        LanguageCardItem(
                          title: "Khmer",
                          subtitle: "ភាសាខ្មែរ",
                          icon: Icons.language,
                          isSelected: state.languageCode == "km",
                          onTap: () {
                            BlocProvider.of<ChangeLanguageBloc>(context).add(
                              ChangeLanguage(
                                Locale("km", "KH"),
                              ),
                            );
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(width: 12),
                        LanguageCardItem(
                          title: "English",
                          subtitle: "English",
                          icon: Icons.language,
                          isSelected: state.languageCode == "en",
                          onTap: () {
                            // change language
                            BlocProvider.of<ChangeLanguageBloc>(context).add(
                              ChangeLanguage(
                                Locale("en", "US"),
                              ),
                            );
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        );
      },
    );
  }
}

//LanguageCardItem
class LanguageCardItem extends StatelessWidget {
  const LanguageCardItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    this.isSelected = false,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                icon,
                color: Theme.of(context).iconTheme.color,
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
              const Spacer(),
              // selected icon for current language
              if (isSelected)
                Icon(
                  Icons.check,
                  color: Theme.of(context).iconTheme.color,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

//SettingsCardItem
class SettingsCardItem extends StatelessWidget {
  const SettingsCardItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.isSwitch = false,
    this.value = false,
    this.onTap,
    this.onSwitchChanged,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final IconData icon;
  final bool isSwitch;
  final VoidCallback? onTap;
  final ValueChanged<bool>? onSwitchChanged;
  final bool? value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, 10), // changes position of shadow
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 12),
        constraints: const BoxConstraints(minHeight: 80),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.subtitle1),
                Text(subtitle, style: Theme.of(context).textTheme.caption),
              ],
            ),
            const Spacer(),
            if (isSwitch)
              Switch.adaptive(
                value: value ?? false,
                onChanged: onSwitchChanged,
              ),
          ],
        ),
      ),
    );
  }
}
