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

class AddressTile extends StatelessWidget {
  final String cryptoCurrency, address, balance, rate, value, currency;
  const AddressTile({
    Key? key,
    required this.cryptoCurrency,
    required this.address,
    required this.balance,
    required this.rate,
    required this.value,
    required this.currency,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        cryptoCurrency,
        style: Theme.of(context).textTheme.titleLarge!,
      ),
      subtitle: RichText(
        // '1 $cryptoCurrency = $rate',
        text: TextSpan(
          children: [
            TextSpan(
              text: rate + '\n',
              style: Theme.of(context).textTheme.titleSmall!,
            ),
            TextSpan(
              text: address,
              style:
                  Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 10),
            ),
          ],
        ),
      ),
      isThreeLine: true,
      trailing: Text(
        '$balance $cryptoCurrency\n$value',
        style: Theme.of(context).textTheme.titleLarge!,
      ),
    );
  }
}

// class AddressTile extends StatefulWidget {
//   final String cryptoCurrency, address, balance, rate, value, currency;
//   const AddressTile({
//     Key? key,
//     required this.cryptoCurrency,
//     required this.address,
//     required this.balance,
//     required this.rate,
//     required this.value,
//     required this.currency,
//   }) : super(key: key);

//   @override
//   State<AddressTile> createState() => _AddressTileState();
// }

// class _AddressTileState extends State<AddressTile> {
//   late final String cryptoCurrency, address, balance, rate, value, currency;

//   @override
//   void initState() {
//     super.initState();
//     cryptoCurrency = widget.cryptoCurrency;
//     address = widget.address;
//     balance = widget.balance;
//     rate = widget.rate;
//     value = widget.value;
//     currency = widget.currency;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Text(
//         cryptoCurrency,
//         style: Theme.of(context).textTheme.titleLarge!,
//       ),
//       subtitle: Text(
//         // '1 $cryptoCurrency = $rate',
//         rate,
//         style: Theme.of(context).textTheme.subtitle2!,
//       ),
//       trailing: Text(
//         '$balance $cryptoCurrency\n$value',
//         style: Theme.of(context).textTheme.titleLarge!,
//       ),
//     );
//   }
// }
