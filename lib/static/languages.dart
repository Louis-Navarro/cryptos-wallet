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

const Map<String, String> languageFormats = {
  'English (US)': 'en-US',
  'English (UK)': 'en-GB',
  'Français': 'fr-FR',
  'Español': 'es-ES',
  'Italiano': 'it-IT',
  'Русский': 'ru-RU',
};

// General class for languages
abstract class Language {
  String get appName;

  String get labelHome;

  String get labelSettings;

  String get labelTotal;

  String get labelLanguageSetting;

  String get labelThemeSetting;

  String get labelCurrencySetting;

  String get labelAddAddressSetting;

  String get labelEditAddressSetting;
}

// English language values
class EnglishLanguage extends Language {
  @override
  String get appName => 'Crypto Wallet';

  @override
  String get labelHome => 'Home';

  @override
  String get labelSettings => 'Settings';

  @override
  String get labelTotal => 'Total';

  @override
  String get labelLanguageSetting => 'Language';

  @override
  String get labelThemeSetting => 'Theme';

  @override
  String get labelCurrencySetting => 'Currency';

  @override
  String get labelAddAddressSetting => 'Add Address';

  @override
  String get labelEditAddressSetting => 'Edit Address';
}

// French language values
class FrenchLanguage extends Language {
  @override
  String get appName => 'Portefeuille Crypto';

  @override
  String get labelHome => 'Accueil';

  @override
  String get labelSettings => 'Paramètres';

  @override
  String get labelTotal => 'Total';

  @override
  String get labelLanguageSetting => 'Langue';

  @override
  String get labelThemeSetting => 'Thème';

  @override
  String get labelCurrencySetting => 'Devise';

  @override
  String get labelAddAddressSetting => 'Ajouter une adresse';

  @override
  String get labelEditAddressSetting => 'Modifier l\'adresse';
}

// Spanish language values
class SpanishLanguage extends Language {
  @override
  String get appName => 'Monedero de Crypto';

  @override
  String get labelHome => 'Casa';

  @override
  String get labelSettings => 'Configuración';

  @override
  String get labelTotal => 'Total';

  @override
  String get labelLanguageSetting => 'Idioma';

  @override
  String get labelThemeSetting => 'Tema';

  @override
  String get labelCurrencySetting => 'Moneda';

  @override
  String get labelAddAddressSetting => 'Agregar dirección';

  @override
  String get labelEditAddressSetting => 'Editar dirección';
}

// Italian language values
class ItalianLanguage extends Language {
  @override
  String get appName => 'Portafoglio Crypto';

  @override
  String get labelHome => 'Casa';

  @override
  String get labelSettings => 'Impostazioni';

  @override
  String get labelTotal => 'Totale';

  @override
  String get labelLanguageSetting => 'Lingua';

  @override
  String get labelThemeSetting => 'Tema';

  @override
  String get labelCurrencySetting => 'Valuta';

  @override
  String get labelAddAddressSetting => 'Aggiungi indirizzo';

  @override
  String get labelEditAddressSetting => 'Modifica indirizzo';
}

// Russian language values
class RussianLanguage extends Language {
  @override
  String get appName => 'Криптовалютный кошелек';

  @override
  String get labelHome => 'Домой';

  @override
  String get labelSettings => 'Настройки';

  @override
  String get labelTotal => 'Итого';

  @override
  String get labelLanguageSetting => 'Язык';

  @override
  String get labelThemeSetting => 'Тема';

  @override
  String get labelCurrencySetting => 'Валюта';

  @override
  String get labelAddAddressSetting => 'Добавить адрес';

  @override
  String get labelEditAddressSetting => 'Изменить адрес';
}

Map<String, Language> languages = {
  'English (US)': EnglishLanguage(),
  'English (UK)': EnglishLanguage(),
  'Français': FrenchLanguage(),
  'Italiano': ItalianLanguage(),
  'Español': SpanishLanguage(),
  'Русский': RussianLanguage(),
};
