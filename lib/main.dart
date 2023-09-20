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

import 'package:cryptowallet/pages/about_page.dart';
import 'package:flutter/material.dart';

// import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:cryptowallet/pages/home_page.dart';
import 'package:cryptowallet/pages/settings_page.dart';
import 'package:cryptowallet/static/languages.dart';

void main() async {
  await Hive.initFlutter();
  // Hive.deleteBoxFromDisk('settings');
  await Hive.openBox('settings');
  // Hive.box('settings').put('addresses', [
  // {
  //   'currency': 'DOT',
  //   'address': '15hMSzHfJNZ3mSiti2K68cNFjx8H74MLU9DqHYbuZwPwL2s8',
  // },
  // {
  //   'currency': 'DOT',
  //   'address': '15hMSzHfJNZ3mSiti2K68cNFjx8H74MLU9DqHYbuZwPwL2s8',
  // },
  // {
  //   'currency': 'DOT',
  //   'address': '15hMSzHfJNZ3mSiti2K68cNFjx8H74MLU9DqHYbuZwPwL2s8',
  // },
  // {
  //   'currency': 'DOT',
  //   'address': '15hMSzHfJNZ3mSiti2K68cNFjx8H74MLU9DqHYbuZwPwL2s8',
  // },
  // {
  //   'currency': 'DOT',
  //   'address': '15hMSzHfJNZ3mSiti2K68cNFjx8H74MLU9DqHYbuZwPwL2s8',
  // },
  // {
  //   'currency': 'DOT',
  //   'address': '15hMSzHfJNZ3mSiti2K68cNFjx8H74MLU9DqHYbuZwPwL2s8',
  // },
  // {
  //   'currency': 'DOT',
  //   'address': '15hMSzHfJNZ3mSiti2K68cNFjx8H74MLU9DqHYbuZwPwL2s8',
  // },
  // {
  //   'currency': 'DOT',
  //   'address': '15hMSzHfJNZ3mSiti2K68cNFjx8H74MLU9DqHYbuZwPwL2s8',
  // },
  // {
  //   'currency': 'DOT',
  //   'address': '15hMSzHfJNZ3mSiti2K68cNFjx8H74MLU9DqHYbuZwPwL2s8',
  // },
  // {
  //   'currency': 'DOT',
  //   'address': '15hMSzHfJNZ3mSiti2K68cNFjx8H74MLU9DqHYbuZwPwL2s8',
  // },
  // ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable:
          Hive.box('settings').listenable(keys: ['theme', 'language']),
      builder: (BuildContext context, Box<dynamic> box, Widget? child) {
        final String theme = box.get('theme', defaultValue: 'System');
        final Language lang =
            languages[box.get('language', defaultValue: 'English (US)')]!;
        return MaterialApp(
          title: lang.appName,
          debugShowCheckedModeBanner: false,
          themeMode: theme == 'System'
              ? ThemeMode.system
              : theme == 'Dark'
                  ? ThemeMode.dark
                  : ThemeMode.light,
          darkTheme: ThemeData.dark(),
          theme: ThemeData(
            primaryColor: const Color(0xFF2C2C2C),
          ),
          home: const MainPage(),
        );
      },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ValueListenableBuilder(
          valueListenable: Hive.box('settings').listenable(keys: ['language']),
          builder: (BuildContext context, Box<dynamic> box, Widget? child) {
            final Language lang =
                languages[box.get('language', defaultValue: 'English (US)')]!;
            return DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: AppBar(
                  title: Text('${lang.appName} - ' +
                      (_tabController.index == 0
                          ? lang.labelHome
                          : lang.labelSettings)),
                  centerTitle: true,
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.question_mark_rounded),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const AboutPage()));
                      },
                    ),
                  ],
                  // backgroundColor: const Color(0xFF2C2C2C),
                  // bottom: TabBar(
                  //   controller: _tabController,
                  //   tabs: const [
                  //     Tab(text: 'Home'),
                  //     Tab(text: 'Settings'),
                  //   ],
                  // ),
                ),
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: _tabController.index,
                  items: [
                    BottomNavigationBarItem(
                      label: lang.labelHome,
                      icon: const Icon(Icons.home),
                    ),
                    BottomNavigationBarItem(
                      label: lang.labelSettings,
                      icon: const Icon(Icons.settings),
                    ),
                  ],
                  onTap: (int index) {
                    setState(() {
                      _tabController.index = index;
                    });
                  },
                ),
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TabBarView(
                    children: const <Widget>[
                      HomePage(),
                      SingleChildScrollView(child: SettingsPage()),
                    ],
                    controller: _tabController,
                    physics: const NeverScrollableScrollPhysics(),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
