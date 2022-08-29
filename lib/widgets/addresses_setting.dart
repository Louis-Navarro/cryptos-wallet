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

import 'package:cryptowallet/widgets/dropdown_widget.dart';
import 'package:cryptowallet/static/currencies.dart';
import 'package:cryptowallet/static/languages.dart';

class AddressesSetting extends StatelessWidget {
  final String name;

  const AddressesSetting({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable:
          Hive.box('settings').listenable(keys: [name, 'language']),
      builder: (BuildContext context, Box<dynamic> box, Widget? child) {
        final List addresses =
            box.get(name, defaultValue: <Map<String, String>>[]);
        final Language lang =
            languages[box.get('language', defaultValue: 'English (US)')]!;
        return Column(
          children: [
            ListView.separated(
              itemCount: addresses.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (context, _) =>
                  const Divider(thickness: 1, indent: 32, endIndent: 32),
              itemBuilder: (BuildContext context, int index) {
                final Map<String, String> address =
                    Map<String, String>.from(addresses[index]);
                return ListTile(
                  title: Text(address['currency']!),
                  subtitle: Text(address['address']!),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          final TextEditingController _controller =
                              TextEditingController(text: address['address']!);
                          String currency = address['currency']!;
                          return AlertDialog(
                            title: Text(lang.labelEditAddressSetting),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(16),
                              ),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Dropdown field to select currency
                                DropdownWidget(
                                  choices: currenciesChoices,
                                  defaultValue: address['currency']!,
                                  onChanged: (value) {
                                    currency = value;
                                  },
                                ),
                                TextField(
                                  decoration: const InputDecoration(
                                    hintText: 'Address',
                                  ),
                                  controller: _controller,
                                ),
                                TextButton(
                                  child: Text(lang.labelEditAddressSetting),
                                  onPressed: () async {
                                    final List addresses = box.get(name,
                                        defaultValue: <Map<String, String>>[]);

                                    if (_controller.text.isEmpty) {
                                      addresses.removeAt(index);
                                    } else {
                                      addresses[index] = <String, String>{
                                        'currency': currency,
                                        'address': _controller.text
                                      };
                                    }

                                    box.put(name, addresses);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              },
              // ListTile(
            ),
            const SizedBox(height: 8),
            TextButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.add),
                  const SizedBox(width: 8),
                  Text(lang.labelAddAddressSetting),
                ],
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    String currency = 'ADA';
                    final TextEditingController _controller =
                        TextEditingController(text: '');

                    return AlertDialog(
                      title: Text(lang.labelAddAddressSetting),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Dropdown field to select currency
                          DropdownWidget(
                            choices: currenciesChoices,
                            defaultValue: 'ADA',
                            onChanged: (value) {
                              currency = value;
                            },
                          ),
                          TextField(
                            decoration: const InputDecoration(
                              hintText: 'Address',
                            ),
                            controller: _controller,
                          ),
                          TextButton(
                            child: Text(lang.labelAddAddressSetting),
                            onPressed: () {
                              if (_controller.text.isEmpty) {
                                return;
                              }

                              final List addresses = box.get(name,
                                  defaultValue: <Map<String, String>>[]);
                              addresses.add(<String, String>{
                                'currency': currency,
                                'address': _controller.text
                              });
                              box.put(name, addresses);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}
