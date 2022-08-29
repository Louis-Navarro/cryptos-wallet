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

class MultiChoiceSetting extends StatelessWidget {
  final String title;
  final String name;
  final String defaultValue;
  final List<String> choices;

  const MultiChoiceSetting({
    Key? key,
    required this.title,
    required this.name,
    required this.choices,
    required this.defaultValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box('settings').listenable(keys: [name]),
      builder: (BuildContext context, Box<dynamic> box, Widget? child) {
        String? value = box.get(name);
        if (value == null) {
          value = defaultValue;
          box.put(name, defaultValue);
        }
        return ListTile(
          title: Text(title),
          trailing: DropdownButton<String>(
            value: value,
            onChanged: (String? value) {
              box.put(name, value ?? '');
            },
            items: choices.map((String choice) {
              return DropdownMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

// class MultiChoiceSetting extends StatefulWidget {
//   final String title;
//   final String name;
//   final String defaultValue;
//   final List<String> choices;

//   const MultiChoiceSetting({
//     Key? key,
//     required this.title,
//     required this.name,
//     required this.choices,
//     required this.defaultValue,
//   }) : super(key: key);

//   @override
//   State<MultiChoiceSetting> createState() => _MultiChoiceSettingState();
// }

// class _MultiChoiceSettingState extends State<MultiChoiceSetting> {
//   late final String title;
//   late final String name;
//   late final List<String> choices;
//   late final String defaultValue;

//   @override
//   void initState() {
//     super.initState();
//     title = widget.title;
//     name = widget.name;
//     choices = widget.choices;
//     defaultValue = widget.defaultValue;
//     print(name);

//     assert(choices.contains(defaultValue));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder(
//       valueListenable: Hive.box('settings').listenable(keys: [name]),
//       builder: (BuildContext context, Box<dynamic> box, Widget? child) {
//         String? value = box.get(name);
//         if (value == null) {
//           value = defaultValue;
//           box.put(name, defaultValue);
//         }
//         return ListTile(
//           title: Text(title),
//           trailing: DropdownButton<String>(
//             value: value,
//             onChanged: (String? value) {
//               box.put(name, value ?? '');
//             },
//             items: choices.map((String choice) {
//               return DropdownMenuItem<String>(
//                 value: choice,
//                 child: Text(choice),
//               );
//             }).toList(),
//           ),
//         );
//       },
//     );
//   }
// }
