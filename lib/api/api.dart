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

// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:cryptowallet/static/currencies.dart';

class ApiClient {
  static const String _baseUrl = 'https://8x6lsw.deta.dev';
  late final Map<String, Future<double> Function(String)> _getBalanceInfo;

  ApiClient() {
    _getBalanceInfo = {
      'ADA': _getADA,
      'DOT': _getDOT,
      'ALGO': _getALGO,
      'MINA': _getMINA,
      'BTC': _getBTC,
      'ETH': _getETH,
    };
  }

  final _httpClient = HttpClient();

  Future<dynamic> _get(String path, {String baseUrl = _baseUrl}) async {
    final uri = Uri.parse('$baseUrl$path');
    final request = await _httpClient.getUrl(uri);
    final response = await request.close();
    final responseBody = await response.transform(utf8.decoder).join();
    return json.decode(responseBody);
  }

  // Future<Map<String, String>> get supportedCurrencies async {
  //   return Map<String, String>.from((await _get('/supported')));
  // }

  Future<double> _getADA(String address) async {
    final String url = balanceApis['ADA']!.replaceAll('{{addr}}', address);
    final resp = await _get('', baseUrl: url);
    return resp['info'][2] / 1e6;
  }

  Future<double> _getDOT(String address) async {
    final String url = balanceApis['DOT']!.replaceAll('{{addr}}', address);
    final resp = await _get('', baseUrl: url);
    return int.parse(resp['data']['balances']['freeBalance'].substring(2),
            radix: 16) /
        1e6;
  }

  Future<double> _getALGO(String address) async {
    final String url = balanceApis['ALGO']!.replaceAll('{{addr}}', address);
    final resp = await _get('', baseUrl: url);
    return resp['amount'] / 1e6;
  }

  Future<double> _getMINA(String address) async {
    final String url = balanceApis['MINA']!.replaceAll('{{addr}}', address);
    final resp = await _get('', baseUrl: url);
    return double.parse(resp['account']['balance']['total']);
  }

  Future<double> _getBTC(String address) async {
    final String url = balanceApis['BTC']!.replaceAll('{{addr}}', address);
    final resp = await _get('', baseUrl: url);
    return (resp['chain_stats']['funded_txo_sum'] -
            resp['chain_stats']['spent_txo_sum']) /
        1e8;
  }

  Future<double> _getETH(String address) async {
    final String url = balanceApis['ETH']!.replaceAll('{{addr}}', address);
    final resp = await _get('', baseUrl: url);
    return resp['final_balance'] / 1e18;
  }

  Future<double> getBalance(String currency, String address) async {
    return await _getBalanceInfo[currency]!(address);
  }

  Future<Map<String, dynamic>> convertPairs(List addrs, String to) async {
    String from = "";
    for (Map addr in addrs) {
      from += symbolNames[addr['currency']]!.toLowerCase() + ",";
    }
    if (from.isNotEmpty) {
      from = from.substring(0, from.length - 1);
      final rate = await _get(
        '/simple/price?ids=$from&vs_currencies=$to',
        baseUrl: 'https://api.coingecko.com/api/v3',
      );

      return rate;
    }
    return {};
  }
}

void main() async {
  final client = ApiClient();
  print(await client.getBalance(
      'ADA', '1864b4a573db4f91936316642c48133716ca6d284689a82742ed6ea9'));
  print(await client.getBalance(
      'DOT', '15hMSzHfJNZ3mSiti2K68cNFjx8H74MLU9DqHYbuZwPwL2s8'));
  print(await client.getBalance(
      'ALGO', 'F7PFK3NQNKHRJ32ENQQO2ZTHMAD4FRCDNNOZTDNRBFZDCOLYEAOP6TL4GI'));
  print(await client.getBalance(
      'MINA', 'B62qpgfKg8WFCmUw1R7WXwFFjx2PwzRbmHVV1cHESx5PrsRJXR65Dip'));
  exit(0);
}
