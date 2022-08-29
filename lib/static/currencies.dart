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

const List<String> currencies = [
  'Cardano ADA',
  'Polkadot DOT',
  'Algorand ALGO',
  'Mina MINA',
  'Bitcoin BTC',
  'Ethereum ETH',
];

const List<Map<String, String>> currenciesChoices = [
  {'name': 'Cardano', 'ticker': 'ADA'},
  {'name': 'Algorand', 'ticker': 'ALGO'},
  {'name': 'Mina', 'ticker': 'MINA'},
  {'name': 'Polkadot', 'ticker': 'DOT'},
  {'name': 'Bitcoin', 'ticker': 'BTC'},
  {'name': 'Ethereum', 'ticker': 'ETH'},
];

const Map<String, String> symbolNames = {
  'ADA': 'Cardano',
  'DOT': 'Polkadot',
  'ALGO': 'Algorand',
  'MINA': 'Mina-Protocol',
  'BTC': 'Bitcoin',
  'ETH': 'Ethereum',
};

const Map<String, String> currencySymbols = {
  'USD': '\$',
  'EUR': '€',
  'GBP': '£',
  'JPY': '¥',
  'RUB': '₽',
};

const Map<String, String> balanceApis = {
  'ADA': 'https://adastat.net/rest/v0/account/{{addr}}.json',
  'DOT': 'https://api.dotscanner.com/accounts/{{addr}}?chain=Polkadot',
  'ALGO': 'https://node.algoexplorerapi.io/v2/accounts/{{addr}}',
  'MINA': 'https://api.minaexplorer.com/accounts/{{addr}}',
  'BTC': 'https://blockstream.info/api/address/{{addr}}',
  'ETH': 'https://api.blockcypher.com/v1/eth/main/addrs/{{addr}}/balance',
};
