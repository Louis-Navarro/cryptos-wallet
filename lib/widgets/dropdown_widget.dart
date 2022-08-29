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

class DropdownWidget extends StatefulWidget {
  final List<Map<String, String>> choices;
  final String defaultValue;
  final void Function(String) onChanged;

  const DropdownWidget({
    Key? key,
    required this.choices,
    required this.defaultValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  late final List<Map<String, String>> choices;
  late String value;
  late final void Function(String) onChanged;

  @override
  void initState() {
    super.initState();
    choices = widget.choices;
    value = widget.defaultValue;
    onChanged = widget.onChanged;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: value,
      onChanged: (String? newValue) {
        setState(() {
          value = newValue ?? value;
          onChanged(value);
        });
      },
      items: choices
          .map((item) => DropdownMenuItem<String>(
                value: item['ticker'],
                child: Text(item['name']! + ' ' + item['ticker']!),
              ))
          .toList(),
      //   items: const [
      //     DropdownMenuItem<String>(
      //       value: 'ADA',
      //       child: Text('Cardano ADA'),
      //     ),
      //     DropdownMenuItem<String>(
      //       value: 'ALGO',
      //       child: Text('Algorand ALGO'),
      //     ),
      //     DropdownMenuItem<String>(
      //       value: 'DOT',
      //       child: Text('Polkadot DOT'),
      //     ),
      //     DropdownMenuItem<String>(
      //       value: 'MINA',
      //       child: Text('Mina MINA'),
      //     ),
      //   ],
    );
  }
}
