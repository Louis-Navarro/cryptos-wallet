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

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import 'package:cryptowallet/api/api.dart';
import 'package:cryptowallet/widgets/address_tile_widget.dart';
import 'package:cryptowallet/static/languages.dart';
import 'package:cryptowallet/static/currencies.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  final ApiClient _api = ApiClient();
  late List addresses; // List<Map<String, String>>
  late List oldAddresses; // List<Map<String, String>>
  List<Map<String, dynamic>> data = [];
  late String currency;

  // late NumberFormat cryptoFormatter = NumberFormat.currency(
  //   locale: languageFormats['Français'],
  //   name: '',
  // );
  // late NumberFormat currencyFormatter = NumberFormat.currency(
  //   locale: languageFormats['Français'],
  //   symbol: currencySymbols['USD'],
  // );
  late NumberFormat cryptoFormatter;
  late NumberFormat currencyFormatter;

  String error = "";

  double total = 0;

  @override
  void initState() {
    super.initState();
    addresses = Hive.box('settings').get('addresses', defaultValue: []);
    oldAddresses = List.from(addresses);
    currency = Hive.box('settings').get('currency', defaultValue: 'USD');
    _refresh(addresses, currency);
  }

  Future<void> _refresh(List addr, String curr, {doSetState = true}) async {
    // try {
    _refreshIndicatorKey.currentState?.show(
      atTop: true,
    );

    final List newData = [];
    data.clear();

    double newTotal = 0;

    final rates = await _api.convertPairs(addr, curr);
    for (Map address in addr) {
      final double balance =
          await _api.getBalance(address['currency'], address['address']);

      // // Take a random balance and rate in a map
      // final Map<String, double> balance = {
      //   'balance': Random().nextDouble() * 1000
      // };
      // final Map<String, double> rate = {'rate': Random().nextDouble() * 10};
      final double rate = rates[symbolNames[address['currency']]!
          .toLowerCase()]![curr.toLowerCase()]!;
      newData.add(<String, dynamic>{
        'currency': address['currency'],
        'balance': balance,
        'rate': rate,
        'value': balance * rate,
      });
      newTotal += balance * rate;
    }

    if (doSetState) {
      setState(() {
        data = List.from(newData);
        total = newTotal;
        error = "";
      });
    }
    // } catch (e) {
    //   if (doSetState) {
    //     setState(() {
    //       error = e.toString();
    //     });
    //   }
    //   return;
    // }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async {
        await _refresh(addresses, currency);
      },
      key: _refreshIndicatorKey,
      child: ValueListenableBuilder(
        valueListenable: Hive.box('settings').listenable(),
        builder: (BuildContext context, Box<dynamic> box, Widget? child) {
          final List newAddresses = box.get('addresses', defaultValue: []);
          final String newCurrency = box.get('currency', defaultValue: 'USD');
          if (!listEquals(newAddresses, oldAddresses) ||
              newCurrency != currency) {
            addresses = List.from(newAddresses);
            oldAddresses = List.from(newAddresses);
            currency = newCurrency;
            _refresh(addresses, newCurrency, doSetState: false);
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          cryptoFormatter = NumberFormat.currency(
            locale: languageFormats[
                box.get('language', defaultValue: 'English (US)')],
            name: '',
          );
          currencyFormatter = NumberFormat.currency(
            locale: languageFormats[
                box.get('language', defaultValue: 'English (US)')],
            symbol: currencySymbols[box.get('currency', defaultValue: 'USD')],
          );

          if (error.isNotEmpty) {
            return Center(
              child: Text(error,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Theme.of(context).errorColor)),
            );
          }

          return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: ListView.separated(
                // separatorBuilder: (context, index) => index == data.length - 1
                //     ? const Divider(thickness: 0.5)
                //     : const SizedBox(height: 8),
                separatorBuilder: (context, index) => index == data.length - 1
                    ? const SizedBox(height: 12)
                    : const SizedBox(height: 6),
                shrinkWrap: true,
                itemCount: data.length + 1,
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                // physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  if (index == data.length) {
                    // return ListTile(
                    //   title: Text(
                    //     'Total',
                    //     style: Theme.of(context).textTheme.headline6!.copyWith(
                    //           color:
                    //               Theme.of(context).colorScheme.inverseSurface,
                    //         ),
                    //   ),
                    //   trailing: Text(
                    //     currencyFormatter.format(total),
                    //     style: Theme.of(context).textTheme.headline6!.copyWith(
                    //           color:
                    //               Theme.of(context).colorScheme.inverseSurface,
                    //         ),
                    //   ),
                    // );
                    return Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: ListTile(
                        title: Text(
                          'Total',
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inverseSurface,
                                  ),
                        ),
                        trailing: Text(
                          currencyFormatter.format(total),
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inverseSurface,
                                  ),
                        ),
                      ),
                    );
                  }
                  final Map<String, dynamic> item = data[index];
                  return Card(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: AddressTile(
                      cryptoCurrency: item['currency'],
                      address: addresses[index]['address'],
                      currency: currency,
                      balance: cryptoFormatter.format(item['balance']),
                      rate: currencyFormatter.format(item['rate']),
                      value: currencyFormatter.format(item['value']),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
