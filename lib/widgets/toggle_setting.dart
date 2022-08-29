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

class ToggleSetting extends StatefulWidget {
  final String title;
  final String name;
  final bool defaultValue;

  const ToggleSetting(
      {required this.title,
      required this.name,
      required this.defaultValue,
      Key? key})
      : super(key: key);

  @override
  State<ToggleSetting> createState() => _ToggleSettingState();
}

class _ToggleSettingState extends State<ToggleSetting> {
  late final String title;
  late final String name;
  late final bool defaultValue;

  @override
  void initState() {
    super.initState();
    title = widget.title;
    name = widget.name;
    defaultValue = widget.defaultValue;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box('settings').listenable(keys: [name]),
      builder: (BuildContext context, Box<dynamic> box, Widget? child) {
        bool? value = box.get(name);
        if (value == null) {
          value = defaultValue;
          box.put(name, defaultValue);
        }
        return SwitchListTile(
          title: Text(title),
          value: value,
          onChanged: (bool value) {
            box.put(name, value);
          },
        );
      },
    );
  }
}
