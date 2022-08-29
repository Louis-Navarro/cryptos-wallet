// Copyright (C) 2022 Louis-Navarro
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';

// import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:cryptowallet/widgets/multi_choices_setting.dart';
// import 'package:cryptowallet/widgets/toggle_setting.dart';
import 'package:cryptowallet/widgets/addresses_setting.dart';
import 'package:cryptowallet/static/languages.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with AutomaticKeepAliveClientMixin<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ValueListenableBuilder(
        valueListenable: Hive.box('settings').listenable(keys: ['language']),
        builder: (BuildContext context, Box box, Widget? child) {
          final Language lang =
              languages[box.get('language', defaultValue: 'English (US)')]!;
          return Column(
            children: [
              MultiChoiceSetting(
                title: lang.labelLanguageSetting,
                name: 'language',
                choices: const [
                  'English (US)',
                  'English (UK)',
                  'Français',
                  'Español',
                  'Italiano',
                  'Русский',
                ],
                defaultValue: 'English (US)',
              ),
              const Divider(thickness: 1, indent: 32, endIndent: 32),
              MultiChoiceSetting(
                title: lang.labelThemeSetting,
                name: 'theme',
                choices: const ['System', 'Dark', 'Light'],
                defaultValue: 'System',
              ),
              const Divider(thickness: 2),
              MultiChoiceSetting(
                title: lang.labelCurrencySetting,
                name: 'currency',
                // choices: ['USD', 'EUR', 'GBP', 'JPY', 'CAD', 'AUD', 'CHF', 'NZD'],
                choices: const ['USD', 'EUR', 'GBP', 'JPY', 'RUB'],
                defaultValue: 'USD',
              ),
              const Divider(thickness: 2),
              const AddressesSetting(
                name: 'addresses',
              ),
            ],
          );
        });
  }

  @override
  bool get wantKeepAlive => true;
}
