import 'package:country_state_city/models/country.dart';
import 'package:albatrus/api_routes.dart';
import 'package:albatrus/custom_colors.dart';
import 'package:albatrus/models/user_short.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:country_state_city/country_state_city.dart' as city;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:albatrus/database_service.dart';
import 'package:albatrus/custom_routes.dart';
import 'package:albatrus/api_routes.dart';
import 'package:albatrus/dowolnie.dart';

import 'dowolnie.dart';
import 'models/trip.dart';
import 'package:albatrus/database_service.dart';

import 'models/trip.dart';

/// This widget is the home page of the application.
class MapScreen extends StatefulWidget {
  /// Initialize the instance of the [MapScreen] class.
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  _MapScreenState();

  late List<MyModel> _data;
  late MapShapeSource _mapSource;
  late int _oldCountryClickedIndex = -1;
  late int _newCountryClickedIndex = -1;
  late MapZoomPanBehavior _zoomPanBehavior;
  late bool _snackTime = false;
  late SnackBar _snackBar;
  late List<String> _countriesFromMap;
  late List<Trip> _trips;
  late int temp = 0;

  final Color _backgroundCountryColor = const Color.fromRGBO(0, 0, 0, 1.0);
  final Color _selectedCountryColor = const Color.fromRGBO(20, 50, 80, 1.0);

  final Color _friendsVisitedCountryColor =
      const Color.fromRGBO(10, 60, 60, 1.0);
  final Color _myVisitedCountryColor = const Color.fromRGBO(80, 20, 50, 1.0);
  final Color _defaultCountryColor = const Color.fromRGBO(15, 25, 45, 1.0);

  final Color _selectedStrokeColor = const Color.fromRGBO(30, 50, 70, 1.0);
  late List<String> _countriesFromMapReal;
  late String _searchedCountry;
  late MapLatLng focal = MapLatLng(0, 0);

  final List<String> _countriesMineSynch = [
    "Afghanistan",
    "Albania",
    "Algeria",
    "Angola",
    "Argentina",
    "Armenia",
    "Australia",
    "Austria",
    "Azerbaijan",
    "Bahamas",
    "Bangladesh",
    "Belarus",
    "Belgium",
    "Belize",
    "Benin",
    "Bhutan",
    "Bolivia",
    "Bosnia and Herz.",
    "Botswana",
    "Brazil",
    "Brunei",
    "Bulgaria",
    "Burkina Faso",
    "Burundi",
    "Cambodia",
    "Cameroon",
    "Canada",
    "Central African Rep.",
    "Chad",
    "Chile",
    "China",
    "Colombia",
    "Congo",
    "Costa Rica",
    "Croatia",
    "Cuba",
    "Cyprus",
    "Czech Rep.",
    "Dem. Rep. Korea",
    "Denmark",
    "Djibouti",
    "Dominican Rep.",
    "Ecuador",
    "Egypt",
    "El Salvador",
    "Eq. Guinea",
    "Eritrea",
    "Estonia",
    "Ethiopia",
    "Falkland Is.",
    "Fiji",
    "Finland",
    "France",
    "Gabon",
    "Gambia",
    "Georgia",
    "Germany",
    "Ghana",
    "Greece",
    "Greenland",
    "Guatemala",
    "Guinea",
    "Guinea-Bissau",
    "Guyana",
    "Haiti",
    "Honduras",
    "Hungary",
    "Iceland",
    "India",
    "Indonesia",
    "Iran",
    "Iraq",
    "Ireland",
    "Israel",
    "Italy",
    "Jamaica",
    "Japan",
    "Jordan",
    "Kazakhstan",
    "Kenya",
    "Korea",
    "Kosovo",
    "Kuwait",
    "Kyrgyzstan",
    "Lao PDR",
    "Latvia",
    "Lebanon",
    "Lesotho",
    "Liberia",
    "Libya",
    "Lithuania",
    "Luxembourg",
    "Macedonia",
    "Madagascar",
    "Malawi",
    "Malaysia",
    "Mali",
    "Mauritania",
    "Mexico",
    "Moldova",
    "Mongolia",
    "Montenegro",
    "Morocco",
    "Mozambique",
    "Myanmar",
    "Namibia",
    "Nepal",
    "Netherlands",
    "New Caledonia",
    "New Zealand",
    "Nicaragua",
    "Niger",
    "Nigeria",
    "Norway",
    "Oman",
    "Pakistan",
    "Palestine",
    "Panama",
    "Papua New Guinea",
    "Paraguay",
    "Peru",
    "Philippines",
    "Poland",
    "Portugal",
    "Puerto Rico",
    "Qatar",
    "Romania",
    "Russia",
    "Rwanda",
    "S. Sudan",
    "Saudi Arabia",
    "Senegal",
    "Serbia",
    "Sierra Leone",
    "Slovakia",
    "Slovenia",
    "Solomon Is.",
    "Somalia",
    "South Africa",
    "Spain",
    "Sri Lanka",
    "Sudan",
    "Suriname",
    "Swaziland",
    "Sweden",
    "Switzerland",
    "Syria",
    "Taiwan",
    "Tajikistan",
    "Tanzania",
    "Thailand",
    "Togo",
    "Trinidad and Tobago",
    "Tunisia",
    "Turkey",
    "Turkmenistan",
    "Uganda",
    "Ukraine",
    "United Arab Emirates",
    "United Kingdom",
    "United States of America",
    "Uruguay",
    "Uzbekistan",
    "Vanuatu",
    "Venezuela",
    "Vietnam",
    "W. Sahara",
    "Yemen",
    "Zambia",
    "Zimbabwe"
  ];
  final List<String> _countriesKiviSynch = [
    "Afghanistan",
    "Albania",
    "Algeria",
    "Angola",
    "Argentina",
    "Armenia",
    "Australia",
    "Austria",
    "Azerbaijan",
    "Bahamas The",
    "Bangladesh",
    "Belarus",
    "Belgium",
    "Belize",
    "Benin",
    "Bhutan",
    "Bolivia",
    "Bosnia and Herzegovina",
    "Botswana",
    "Brazil",
    "Brunei",
    "Bulgaria",
    "Burkina Faso",
    "Burundi",
    "Cambodia",
    "Cameroon",
    "Canada",
    "Central African Republic",
    "Chad",
    "Chile",
    "China",
    "Colombia",
    "Congo",
    "Costa Rica",
    "Croatia (Hrvatska)",
    "Cuba",
    "Cyprus",
    "Czech Republic",
    "Korea North",
    "Denmark",
    "Djibouti",
    "Dominican Republic",
    "Ecuador",
    "Egypt",
    "El Salvador",
    "Equatorial Guinea",
    "Eritrea",
    "Estonia",
    "Ethiopia",
    "Falkland Islands",
    "Fiji Islands",
    "Finland",
    "France",
    "Gabon",
    "Gambia The",
    "Georgia",
    "Germany",
    "Ghana",
    "Greece",
    "Greenland",
    "Guatemala",
    "Guinea",
    "Guinea-Bissau",
    "Guyana",
    "Haiti",
    "Honduras",
    "Hungary",
    "Iceland",
    "India",
    "Indonesia",
    "Iran",
    "Iraq",
    "Ireland",
    "Israel",
    "Italy",
    "Jamaica",
    "Japan",
    "Jordan",
    "Kazakhstan",
    "Kenya",
    "Korea South",
    "Kosovo",
    "Kuwait",
    "Kyrgyzstan",
    "Laos",
    "Latvia",
    "Lebanon",
    "Lesotho",
    "Liberia",
    "Libya",
    "Lithuania",
    "Luxembourg",
    "Macedonia",
    "Madagascar",
    "Malawi",
    "Malaysia",
    "Mali",
    "Mauritania",
    "Mexico",
    "Moldova",
    "Mongolia",
    "Montenegro",
    "Morocco",
    "Mozambique",
    "Myanmar",
    "Namibia",
    "Nepal",
    "Netherlands The",
    "New Caledonia",
    "New Zealand",
    "Nicaragua",
    "Niger",
    "Nigeria",
    "Norway",
    "Oman",
    "Pakistan",
    "Palestinian Territory Occupied",
    "Panama",
    "Papua new Guinea",
    "Paraguay",
    "Peru",
    "Philippines",
    "Poland",
    "Portugal",
    "Puerto Rico",
    "Qatar",
    "Romania",
    "Russia",
    "Rwanda",
    "South Sudan",
    "Saudi Arabia",
    "Senegal",
    "Serbia",
    "Sierra Leone",
    "Slovakia",
    "Slovenia",
    "Solomon Islands",
    "Somalia",
    "South Africa",
    "Spain",
    "Sri Lanka",
    "Sudan",
    "Suriname",
    "Swaziland",
    "Sweden",
    "Switzerland",
    "Syria",
    "Taiwan",
    "Tajikistan",
    "Tanzania",
    "Thailand",
    "Togo",
    "Trinidad And Tobago",
    "Tunisia",
    "Turkey",
    "Turkmenistan",
    "Uganda",
    "Ukraine",
    "United Arab Emirates",
    "United Kingdom",
    "United States",
    "Uruguay",
    "Uzbekistan",
    "Vanuatu",
    "Venezuela",
    "Vietnam",
    "Western Sahara",
    "Yemen",
    "Zambia",
    "Zimbabwe"
  ];
  final List<int> _countriesMineSynchIndex = [
    0,
    3,
    1,
    158,
    4,
    5,
    6,
    7,
    8,
    23,
    12,
    14,
    22,
    10,
    21,
    9,
    17,
    11,
    13,
    16,
    19,
    20,
    15,
    18,
    27,
    26,
    145,
    29,
    30,
    25,
    32,
    31,
    33,
    35,
    36,
    37,
    56,
    40,
    39,
    41,
    2,
    42,
    43,
    46,
    139,
    47,
    48,
    51,
    50,
    49,
    52,
    53,
    159,
    55,
    57,
    61,
    54,
    62,
    45,
    58,
    59,
    60,
    63,
    65,
    34,
    64,
    66,
    69,
    68,
    72,
    70,
    71,
    67,
    73,
    74,
    75,
    77,
    76,
    78,
    79,
    83,
    24,
    80,
    81,
    82,
    84,
    86,
    88,
    89,
    140,
    87,
    90,
    91,
    85,
    102,
    99,
    93,
    98,
    92,
    96,
    104,
    101,
    100,
    103,
    97,
    94,
    95,
    105,
    108,
    111,
    112,
    110,
    107,
    113,
    106,
    109,
    114,
    115,
    117,
    120,
    121,
    118,
    122,
    124,
    38,
    123,
    119,
    116,
    125,
    126,
    127,
    128,
    166,
    130,
    141,
    129,
    131,
    136,
    133,
    44,
    137,
    132,
    142,
    134,
    135,
    144,
    143,
    146,
    28,
    151,
    150,
    148,
    155,
    152,
    153,
    154,
    147,
    149,
    156,
    157,
    161,
    160,
    162,
    164,
    165,
    163,
    167,
    138,
    168,
    169
  ];
  final List<int> _countriesKiviSynchIndex = [
    0,
    2,
    3,
    6,
    10,
    11,
    13,
    14,
    15,
    16,
    18,
    20,
    21,
    22,
    23,
    25,
    26,
    27,
    28,
    30,
    32,
    33,
    34,
    35,
    36,
    37,
    38,
    41,
    42,
    43,
    44,
    47,
    49,
    52,
    54,
    55,
    56,
    57,
    114,
    58,
    59,
    61,
    63,
    64,
    65,
    66,
    67,
    68,
    69,
    70,
    72,
    73,
    74,
    78,
    79,
    80,
    81,
    82,
    84,
    85,
    89,
    91,
    92,
    93,
    94,
    96,
    98,
    99,
    100,
    101,
    102,
    103,
    104,
    105,
    106,
    107,
    108,
    110,
    111,
    112,
    115,
    247,
    116,
    117,
    118,
    119,
    120,
    121,
    122,
    123,
    125,
    126,
    128,
    129,
    130,
    131,
    133,
    138,
    141,
    143,
    145,
    146,
    148,
    149,
    150,
    151,
    153,
    155,
    156,
    157,
    158,
    159,
    160,
    164,
    165,
    166,
    168,
    169,
    170,
    171,
    172,
    173,
    175,
    176,
    177,
    178,
    180,
    181,
    182,
    205,
    193,
    194,
    195,
    197,
    199,
    200,
    201,
    202,
    203,
    206,
    207,
    208,
    209,
    211,
    212,
    213,
    214,
    215,
    216,
    217,
    218,
    219,
    222,
    223,
    224,
    225,
    228,
    229,
    230,
    231,
    232,
    234,
    235,
    236,
    238,
    239,
    243,
    244,
    245,
    246
  ];
  final Color _defaultStrokeColor = const Color.fromRGBO(50, 90, 130, 1.0);

  late List<Country> _countriesFromDifferentSource;
  late List<Set<String>> _countryFriendsListSet;
  late List<CountryPlusFriend> _countryPlusFriend;
  late Set<String> _countrySet;
  late List<String> _countryList;
  Map<String, List<Trip>> map = {};

  String _dropdownSearchSelectedItem = "";

  @override
  void initState() {
    _data = <MyModel>[
      MyModel("AlbatrUS", _backgroundCountryColor, "AlbatrUS", "AlbatrUS"),
      MyModel("Afghanistan", _defaultCountryColor, "Afghanistan", "Asia"),
      MyModel("Angola", _defaultCountryColor, "Angola", "Africa"),
      MyModel("Albania", _defaultCountryColor, "Albania", "Europe"),
      MyModel("United Arab Emirates", _defaultCountryColor,
          "United Arab Emirates", "Asia"),
      MyModel("Argentina", _defaultCountryColor, "Argentina", "South America"),
      MyModel("Armenia", _defaultCountryColor, "Armenia", "Asia"),
      MyModel("Australia", _defaultCountryColor, "Australia", "Australia"),
      MyModel("Austria", _defaultCountryColor, "Austria", "Europe"),
      MyModel("Azerbaijan", _defaultCountryColor, "Azerbaijan", "Asia"),
      MyModel("Burundi", _defaultCountryColor, "Burundi", "Africa"),
      MyModel("Belgium", _defaultCountryColor, "Belgium", "Europe"),
      MyModel("Benin", _defaultCountryColor, "Benin", "Africa"),
      MyModel("Burkina Faso", _defaultCountryColor, "Burkina Faso", "Africa"),
      MyModel("Bangladesh", _defaultCountryColor, "Bangladesh", "Asia"),
      MyModel("Bulgaria", _defaultCountryColor, "Bulgaria", "Europe"),
      MyModel("The Bahamas", _defaultCountryColor, "Bahamas", "North America"),
      MyModel("Bosnia and Herzegovina", _defaultCountryColor,
          "Bosnia and Herz.", "Europe"),
      MyModel("Belarus", _defaultCountryColor, "Belarus", "Europe"),
      MyModel("Belize", _defaultCountryColor, "Belize", "North America"),
      MyModel("Bolivia", _defaultCountryColor, "Bolivia", "South America"),
      MyModel("Brazil", _defaultCountryColor, "Brazil", "South America"),
      MyModel("Brunei", _defaultCountryColor, "Brunei", "Asia"),
      MyModel("Bhutan", _defaultCountryColor, "Bhutan", "Asia"),
      MyModel("Botswana", _defaultCountryColor, "Botswana", "Africa"),
      MyModel("Central African Republic", _defaultCountryColor,
          "Central African Rep.", "Africa"),
      MyModel("Canada", _defaultCountryColor, "Canada", "North America"),
      MyModel("Switzerland", _defaultCountryColor, "Switzerland", "Europe"),
      MyModel("Chile", _defaultCountryColor, "Chile", "South America"),
      MyModel("China", _defaultCountryColor, "China", "Asia"),
      MyModel("Ivory Coast", _defaultCountryColor, "Côte d'Ivoire", "Africa"),
      MyModel("Cameroon", _defaultCountryColor, "Cameroon", "Africa"),
      MyModel("Democratic Republic of the Congo", _defaultCountryColor,
          "Dem. Rep. Congo", "Africa"),
      MyModel("Republic of Congo", _defaultCountryColor, "Congo", "Africa"),
      MyModel("Colombia", _defaultCountryColor, "Colombia", "South America"),
      MyModel(
          "Costa Rica", _defaultCountryColor, "Costa Rica", "North America"),
      MyModel("Cuba", _defaultCountryColor, "Cuba", "North America"),
      MyModel("Northern Cyprus", _defaultCountryColor, "N. Cyprus", "Asia"),
      MyModel("Cyprus", _defaultCountryColor, "Cyprus", "Asia"),
      MyModel("Czech Republic", _defaultCountryColor, "Czech Rep.", "Europe"),
      MyModel("Germany", _defaultCountryColor, "Germany", "Europe"),
      MyModel("Djibouti", _defaultCountryColor, "Djibouti", "Africa"),
      MyModel("Denmark", _defaultCountryColor, "Denmark", "Europe"),
      MyModel("Dominican Republic", _defaultCountryColor, "Dominican Rep.",
          "North America"),
      MyModel("Algeria", _defaultCountryColor, "Algeria", "Africa"),
      MyModel("Ecuador", _defaultCountryColor, "Ecuador", "South America"),
      MyModel("Egypt", _defaultCountryColor, "Egypt", "Africa"),
      MyModel("Eritrea", _defaultCountryColor, "Eritrea", "Africa"),
      MyModel("Spain", _defaultCountryColor, "Spain", "Europe"),
      MyModel("Estonia", _defaultCountryColor, "Estonia", "Europe"),
      MyModel("Ethiopia", _defaultCountryColor, "Ethiopia", "Africa"),
      MyModel("Finland", _defaultCountryColor, "Finland", "Europe"),
      MyModel("Fiji", _defaultCountryColor, "Fiji", "Australia"),
      MyModel("Falkland Islands", _defaultCountryColor, "Falkland Is.",
          "South America"),
      MyModel("France", _defaultCountryColor, "France", "Europe"),
      MyModel("Gabon", _defaultCountryColor, "Gabon", "Africa"),
      MyModel(
          "United Kingdom", _defaultCountryColor, "United Kingdom", "Europe"),
      MyModel("Georgia", _defaultCountryColor, "Georgia", "Asia"),
      MyModel("Ghana", _defaultCountryColor, "Ghana", "Africa"),
      MyModel("Guinea", _defaultCountryColor, "Guinea", "Africa"),
      MyModel("Gambia", _defaultCountryColor, "Gambia", "Africa"),
      MyModel("Guinea Bissau", _defaultCountryColor, "Guinea-Bissau", "Africa"),
      MyModel(
          "Equatorial Guinea", _defaultCountryColor, "Eq. Guinea", "Africa"),
      MyModel("Greece", _defaultCountryColor, "Greece", "Europe"),
      MyModel("Greenland", _defaultCountryColor, "Greenland", "North America"),
      MyModel("Guatemala", _defaultCountryColor, "Guatemala", "North America"),
      MyModel("Guyana", _defaultCountryColor, "Guyana", "South America"),
      MyModel("Honduras", _defaultCountryColor, "Honduras", "North America"),
      MyModel("Croatia", _defaultCountryColor, "Croatia", "Europe"),
      MyModel("Haiti", _defaultCountryColor, "Haiti", "North America"),
      MyModel("Hungary", _defaultCountryColor, "Hungary", "Europe"),
      MyModel("Indonesia", _defaultCountryColor, "Indonesia", "Asia"),
      MyModel("India", _defaultCountryColor, "India", "Asia"),
      MyModel("Ireland", _defaultCountryColor, "Ireland", "Europe"),
      MyModel("Iran", _defaultCountryColor, "Iran", "Asia"),
      MyModel("Iraq", _defaultCountryColor, "Iraq", "Asia"),
      MyModel("Iceland", _defaultCountryColor, "Iceland", "Europe"),
      MyModel("Israel", _defaultCountryColor, "Israel", "Asia"),
      MyModel("Italy", _defaultCountryColor, "Italy", "Europe"),
      MyModel("Jamaica", _defaultCountryColor, "Jamaica", "North America"),
      MyModel("Jordan", _defaultCountryColor, "Jordan", "Asia"),
      MyModel("Japan", _defaultCountryColor, "Japan", "Asia"),
      MyModel("Kazakhstan", _defaultCountryColor, "Kazakhstan", "Asia"),
      MyModel("Kenya", _defaultCountryColor, "Kenya", "Africa"),
      MyModel("Kyrgyzstan", _defaultCountryColor, "Kyrgyzstan", "Asia"),
      MyModel("Cambodia", _defaultCountryColor, "Cambodia", "Asia"),
      MyModel("South Korea", _defaultCountryColor, "Korea", "Asia"),
      MyModel("Kosovo", _defaultCountryColor, "Kosovo", "Europe"),
      MyModel("Kuwait", _defaultCountryColor, "Kuwait", "Asia"),
      MyModel("Laos", _defaultCountryColor, "Lao PDR", "Asia"),
      MyModel("Lebanon", _defaultCountryColor, "Lebanon", "Asia"),
      MyModel("Liberia", _defaultCountryColor, "Liberia", "Africa"),
      MyModel("Libya", _defaultCountryColor, "Libya", "Africa"),
      MyModel("Sri Lanka", _defaultCountryColor, "Sri Lanka", "Asia"),
      MyModel("Lesotho", _defaultCountryColor, "Lesotho", "Africa"),
      MyModel("Lithuania", _defaultCountryColor, "Lithuania", "Europe"),
      MyModel("Luxembourg", _defaultCountryColor, "Luxembourg", "Europe"),
      MyModel("Latvia", _defaultCountryColor, "Latvia", "Europe"),
      MyModel("Morocco", _defaultCountryColor, "Morocco", "Africa"),
      MyModel("Moldova", _defaultCountryColor, "Moldova", "Europe"),
      MyModel("Madagascar", _defaultCountryColor, "Madagascar", "Africa"),
      MyModel("Mexico", _defaultCountryColor, "Mexico", "North America"),
      MyModel("Macedonia", _defaultCountryColor, "Macedonia", "Europe"),
      MyModel("Mali", _defaultCountryColor, "Mali", "Africa"),
      MyModel("Myanmar", _defaultCountryColor, "Myanmar", "Asia"),
      MyModel("Montenegro", _defaultCountryColor, "Montenegro", "Europe"),
      MyModel("Mongolia", _defaultCountryColor, "Mongolia", "Asia"),
      MyModel("Mozambique", _defaultCountryColor, "Mozambique", "Africa"),
      MyModel("Mauritania", _defaultCountryColor, "Mauritania", "Africa"),
      MyModel("Malawi", _defaultCountryColor, "Malawi", "Africa"),
      MyModel("Malaysia", _defaultCountryColor, "Malaysia", "Asia"),
      MyModel("Namibia", _defaultCountryColor, "Namibia", "Africa"),
      MyModel(
          "New Caledonia", _defaultCountryColor, "New Caledonia", "Australia"),
      MyModel("Niger", _defaultCountryColor, "Niger", "Africa"),
      MyModel("Nigeria", _defaultCountryColor, "Nigeria", "Africa"),
      MyModel("Nicaragua", _defaultCountryColor, "Nicaragua", "North America"),
      MyModel("Netherlands", _defaultCountryColor, "Netherlands", "Europe"),
      MyModel("Norway", _defaultCountryColor, "Norway", "Europe"),
      MyModel("Nepal", _defaultCountryColor, "Nepal", "Asia"),
      MyModel("New Zealand", _defaultCountryColor, "New Zealand", "Australia"),
      MyModel("Oman", _defaultCountryColor, "Oman", "Asia"),
      MyModel("Pakistan", _defaultCountryColor, "Pakistan", "Asia"),
      MyModel("Panama", _defaultCountryColor, "Panama", "North America"),
      MyModel("Peru", _defaultCountryColor, "Peru", "South America"),
      MyModel("Philippines", _defaultCountryColor, "Philippines", "Asia"),
      MyModel("Papua New Guinea", _defaultCountryColor, "Papua New Guinea",
          "Australia"),
      MyModel("Poland", _defaultCountryColor, "Poland", "Europe"),
      MyModel(
          "Puerto Rico", _defaultCountryColor, "Puerto Rico", "North America"),
      MyModel("North Korea", _defaultCountryColor, "Dem. Rep. Korea", "Asia"),
      MyModel("Portugal", _defaultCountryColor, "Portugal", "Europe"),
      MyModel("Paraguay", _defaultCountryColor, "Paraguay", "South America"),
      MyModel("Palestine", _defaultCountryColor, "Palestine", "Asia"),
      MyModel("Qatar", _defaultCountryColor, "Qatar", "Asia"),
      MyModel("Romania", _defaultCountryColor, "Romania", "Europe"),
      MyModel("Russia", _defaultCountryColor, "Russia", "Asia"),
      MyModel("Rwanda", _defaultCountryColor, "Rwanda", "Africa"),
      MyModel("Western Sahara", _defaultCountryColor, "W. Sahara", "Africa"),
      MyModel("Saudi Arabia", _defaultCountryColor, "Saudi Arabia", "Asia"),
      MyModel("Sudan", _defaultCountryColor, "Sudan", "Africa"),
      MyModel("South Sudan", _defaultCountryColor, "S. Sudan", "Africa"),
      MyModel("Senegal", _defaultCountryColor, "Senegal", "Africa"),
      MyModel(
          "Solomon Islands", _defaultCountryColor, "Solomon Is.", "Australia"),
      MyModel("Sierra Leone", _defaultCountryColor, "Sierra Leone", "Africa"),
      MyModel(
          "El Salvador", _defaultCountryColor, "El Salvador", "North America"),
      MyModel("Somaliland", _defaultCountryColor, "Somaliland", "Africa"),
      MyModel("Somalia", _defaultCountryColor, "Somalia", "Africa"),
      MyModel("Republic of Serbia", _defaultCountryColor, "Serbia", "Europe"),
      MyModel("Suriname", _defaultCountryColor, "Suriname", "South America"),
      MyModel("Slovakia", _defaultCountryColor, "Slovakia", "Europe"),
      MyModel("Slovenia", _defaultCountryColor, "Slovenia", "Europe"),
      MyModel("Sweden", _defaultCountryColor, "Sweden", "Europe"),
      MyModel("Swaziland", _defaultCountryColor, "Swaziland", "Africa"),
      MyModel("Syria", _defaultCountryColor, "Syria", "Asia"),
      MyModel("Chad", _defaultCountryColor, "Chad", "Africa"),
      MyModel("Togo", _defaultCountryColor, "Togo", "Africa"),
      MyModel("Thailand", _defaultCountryColor, "Thailand", "Asia"),
      MyModel("Tajikistan", _defaultCountryColor, "Tajikistan", "Asia"),
      MyModel("Turkmenistan", _defaultCountryColor, "Turkmenistan", "Asia"),
      MyModel("East Timor", _defaultCountryColor, "Timor-Leste", "Asia"),
      MyModel("Trinidad and Tobago", _defaultCountryColor,
          "Trinidad and Tobago", "North America"),
      MyModel("Tunisia", _defaultCountryColor, "Tunisia", "Africa"),
      MyModel("Turkey", _defaultCountryColor, "Turkey", "Asia"),
      MyModel("Taiwan", _defaultCountryColor, "Taiwan", "Asia"),
      MyModel("United Republic of Tanzania", _defaultCountryColor, "Tanzania",
          "Africa"),
      MyModel("Uganda", _defaultCountryColor, "Uganda", "Africa"),
      MyModel("Ukraine", _defaultCountryColor, "Ukraine", "Europe"),
      MyModel("Uruguay", _defaultCountryColor, "Uruguay", "South America"),
      MyModel("United States of America", _defaultCountryColor,
          "United States of America", "North America"),
      MyModel("Uzbekistan", _defaultCountryColor, "Uzbekistan", "Asia"),
      MyModel("Venezuela", _defaultCountryColor, "Venezuela", "South America"),
      MyModel("Vietnam", _defaultCountryColor, "Vietnam", "Asia"),
      MyModel("Vanuatu", _defaultCountryColor, "Vanuatu", "Australia"),
      MyModel("Yemen", _defaultCountryColor, "Yemen", "Asia"),
      MyModel("South Africa", _defaultCountryColor, "South Africa", "Africa"),
      MyModel("Zambia", _defaultCountryColor, "Zambia", "Africa"),
      MyModel("Zimbabwe", _defaultCountryColor, "Zimbabwe", "Africa"),
    ];

    _countriesFromMap = [
      "AlbatrUS",
      "Afghanistan",
      "Angola",
      "Albania",
      "United Arab Emirates",
      "Argentina",
      "Armenia",
      "Australia",
      "Austria",
      "Azerbaijan",
      "Burundi",
      "Belgium",
      "Benin",
      "Burkina Faso",
      "Bangladesh",
      "Bulgaria",
      "Bahamas",
      "Bosnia and Herz.",
      "Belarus",
      "Belize",
      "Bolivia",
      "Brazil",
      "Brunei",
      "Bhutan",
      "Botswana",
      "Central African Rep.",
      "Canada",
      "Switzerland",
      "Chile",
      "China",
      "Côte d'Ivoire",
      "Cameroon",
      "Dem. Rep. Congo",
      "Congo",
      "Colombia",
      "Costa Rica",
      "Cuba",
      "N. Cyprus",
      "Cyprus",
      "Czech Rep.",
      "Germany",
      "Djibouti",
      "Denmark",
      "Dominican Rep.",
      "Algeria",
      "Ecuador",
      "Egypt",
      "Eritrea",
      "Spain",
      "Estonia",
      "Ethiopia",
      "Finland",
      "Fiji",
      "Falkland Is.",
      "France",
      "Gabon",
      "United Kingdom",
      "Georgia",
      "Ghana",
      "Guinea",
      "Gambia",
      "Guinea-Bissau",
      "Eq. Guinea",
      "Greece",
      "Greenland",
      "Guatemala",
      "Guyana",
      "Honduras",
      "Croatia",
      "Haiti",
      "Hungary",
      "Indonesia",
      "India",
      "Ireland",
      "Iran",
      "Iraq",
      "Iceland",
      "Israel",
      "Italy",
      "Jamaica",
      "Jordan",
      "Japan",
      "Kazakhstan",
      "Kenya",
      "Kyrgyzstan",
      "Cambodia",
      "Korea",
      "Kosovo",
      "Kuwait",
      "Lao PDR",
      "Lebanon",
      "Liberia",
      "Libya",
      "Sri Lanka",
      "Lesotho",
      "Lithuania",
      "Luxembourg",
      "Latvia",
      "Morocco",
      "Moldova",
      "Madagascar",
      "Mexico",
      "Macedonia",
      "Mali",
      "Myanmar",
      "Montenegro",
      "Mongolia",
      "Mozambique",
      "Mauritania",
      "Malawi",
      "Malaysia",
      "Namibia",
      "New Caledonia",
      "Niger",
      "Nigeria",
      "Nicaragua",
      "Netherlands",
      "Norway",
      "Nepal",
      "New Zealand",
      "Oman",
      "Pakistan",
      "Panama",
      "Peru",
      "Philippines",
      "Papua New Guinea",
      "Poland",
      "Puerto Rico",
      "Dem. Rep. Korea",
      "Portugal",
      "Paraguay",
      "Palestine",
      "Qatar",
      "Romania",
      "Russia",
      "Rwanda",
      "W. Sahara",
      "Saudi Arabia",
      "Sudan",
      "S. Sudan",
      "Senegal",
      "Solomon Is.",
      "Sierra Leone",
      "El Salvador",
      "Somaliland",
      "Somalia",
      "Serbia",
      "Suriname",
      "Slovakia",
      "Slovenia",
      "Sweden",
      "Swaziland",
      "Syria",
      "Chad",
      "Togo",
      "Thailand",
      "Tajikistan",
      "Turkmenistan",
      "Timor-Leste",
      "Trinidad and Tobago",
      "Tunisia",
      "Turkey",
      "Taiwan",
      "Tanzania",
      "Uganda",
      "Ukraine",
      "Uruguay",
      "United States of America",
      "Uzbekistan",
      "Venezuela",
      "Vietnam",
      "Vanuatu",
      "Yemen",
      "South Africa",
      "Zambia",
      "Zimbabwe"
    ];

    _countriesFromMapReal = [
      "Afghanistan",
      "Angola",
      "Albania",
      "United Arab Emirates",
      "Argentina",
      "Armenia",
      "Australia",
      "Austria",
      "Azerbaijan",
      "Burundi",
      "Belgium",
      "Benin",
      "Burkina Faso",
      "Bangladesh",
      "Bulgaria",
      "Bahamas",
      "Bosnia and Herz.",
      "Belarus",
      "Belize",
      "Bolivia",
      "Brazil",
      "Brunei",
      "Bhutan",
      "Botswana",
      "Central African Rep.",
      "Canada",
      "Switzerland",
      "Chile",
      "China",
      "Côte d'Ivoire",
      "Cameroon",
      "Dem. Rep. Congo",
      "Congo",
      "Colombia",
      "Costa Rica",
      "Cuba",
      "N. Cyprus",
      "Cyprus",
      "Czech Rep.",
      "Germany",
      "Djibouti",
      "Denmark",
      "Dominican Rep.",
      "Algeria",
      "Ecuador",
      "Egypt",
      "Eritrea",
      "Spain",
      "Estonia",
      "Ethiopia",
      "Finland",
      "Fiji",
      "Falkland Is.",
      "France",
      "Gabon",
      "United Kingdom",
      "Georgia",
      "Ghana",
      "Guinea",
      "Gambia",
      "Guinea-Bissau",
      "Eq. Guinea",
      "Greece",
      "Greenland",
      "Guatemala",
      "Guyana",
      "Honduras",
      "Croatia",
      "Haiti",
      "Hungary",
      "Indonesia",
      "India",
      "Ireland",
      "Iran",
      "Iraq",
      "Iceland",
      "Israel",
      "Italy",
      "Jamaica",
      "Jordan",
      "Japan",
      "Kazakhstan",
      "Kenya",
      "Kyrgyzstan",
      "Cambodia",
      "Korea",
      "Kosovo",
      "Kuwait",
      "Lao PDR",
      "Lebanon",
      "Liberia",
      "Libya",
      "Sri Lanka",
      "Lesotho",
      "Lithuania",
      "Luxembourg",
      "Latvia",
      "Morocco",
      "Moldova",
      "Madagascar",
      "Mexico",
      "Macedonia",
      "Mali",
      "Myanmar",
      "Montenegro",
      "Mongolia",
      "Mozambique",
      "Mauritania",
      "Malawi",
      "Malaysia",
      "Namibia",
      "New Caledonia",
      "Niger",
      "Nigeria",
      "Nicaragua",
      "Netherlands",
      "Norway",
      "Nepal",
      "New Zealand",
      "Oman",
      "Pakistan",
      "Panama",
      "Peru",
      "Philippines",
      "Papua New Guinea",
      "Poland",
      "Puerto Rico",
      "Dem. Rep. Korea",
      "Portugal",
      "Paraguay",
      "Palestine",
      "Qatar",
      "Romania",
      "Russia",
      "Rwanda",
      "W. Sahara",
      "Saudi Arabia",
      "Sudan",
      "S. Sudan",
      "Senegal",
      "Solomon Is.",
      "Sierra Leone",
      "El Salvador",
      "Somaliland",
      "Somalia",
      "Serbia",
      "Suriname",
      "Slovakia",
      "Slovenia",
      "Sweden",
      "Swaziland",
      "Syria",
      "Chad",
      "Togo",
      "Thailand",
      "Tajikistan",
      "Turkmenistan",
      "Timor-Leste",
      "Trinidad and Tobago",
      "Tunisia",
      "Turkey",
      "Taiwan",
      "Tanzania",
      "Uganda",
      "Ukraine",
      "Uruguay",
      "United States of America",
      "Uzbekistan",
      "Venezuela",
      "Vietnam",
      "Vanuatu",
      "Yemen",
      "South Africa",
      "Zambia",
      "Zimbabwe"
    ];

    prepareMap();

    getTrips();

    //_showDialog(context);

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _showInitialDialog(context);
    });

    super.initState();
  }

  late int fidget = -1;
  late int tempFidget = -1;

  double printingOne() {
    print("i'm printing ONE YOLO2137");
    refreshMap();
    return 0;
  }

  String printingName() {
    print("i'm printing name YOLO2137");
    return "name";
  }

  Future<void> _showInitialDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Witaj!'),
          content:
              Text('To jest okienko, które wyskakuje na początku aplikacji.'),
          actions: [
            TextButton(
              onPressed: () {
                refreshMap();
                Navigator.of(context, rootNavigator: true).pop();
              },
              child: Text('Zamknij'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: //Scaffold(
          /*body:*/ Stack(
        children: [
          Container(
            color: _backgroundCountryColor,
          ),
          Center(
            child: SfMaps(
              layers: <MapShapeLayer>[
                MapShapeLayer(
                  source: _mapSource,
                  zoomPanBehavior: _zoomPanBehavior,
                  strokeColor: _defaultStrokeColor,
                  strokeWidth: 0.6,
                  //TO DO
                  showDataLabels: true,
                  onSelectionChanged: (int index) {
                    _newCountryClickedIndex = index;
                    print("you clicked on country: $_newCountryClickedIndex");
                    tempFidget = funWithSelectedCountries();
                    setState(() {
                      fidget = tempFidget;
                    });
                    _oldCountryClickedIndex = _newCountryClickedIndex;
                  },
                  selectedIndex: fidget,
                  selectionSettings: MapSelectionSettings(
                    color: _selectedCountryColor,
                    strokeColor: _selectedStrokeColor,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              top: 0,
              right: 0,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 100, right: 10),
                    child: Container(
                      width: 50,
                      height: 100,
                      child: DropdownSearch(
                        enabled: true,
                        items: _countriesFromMapReal,
                        selectedItem: _dropdownSearchSelectedItem,
                        onChanged: (value) {
                          int tempp = indexInKivis(value);
                          if (tempp == -1) {
                            print("Problem");
                          } else {
                            setState(() {
                              fidget = _countriesFromMapReal.indexOf(value) + 1;
                              _newCountryClickedIndex =
                                  _countriesFromMapReal.indexOf(value) + 1;
                            });
                            _zoomPanBehavior.focalLatLng = MapLatLng(
                                double.parse(
                                    _countriesFromDifferentSource[tempp]
                                        .latitude),
                                double.parse(
                                    _countriesFromDifferentSource[tempp]
                                        .longitude));
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            _snackBar = createSnackBar();
                            ScaffoldMessenger.of(context)
                                .showSnackBar(_snackBar);
                            _snackTime = true;
                          }
                        },
                        compareFn: (i, s) => i == s,
                        popupProps: PopupPropsMultiSelection.dialog(
                          //TODO dodać wyszarzenie tła
                          searchDelay: const Duration(milliseconds: 300),
                          searchFieldProps: TextFieldProps(
                            decoration: InputDecoration(
                              labelText: "Search",
                              labelStyle: TextStyle(
                                  color: CustomColors().secondaryTextColor),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                          ),
                          showSelectedItems: true,
                          // onItemAdded:
                          showSearchBox: true,
                          dialogProps: DialogProps(
                            barrierColor: Colors.black,
                            shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  25.0), // Zaokrąglenie narożników
                            ),
                            backgroundColor: Colors.grey,
                          ),
                        ),
                        dropdownButtonProps: const DropdownButtonProps(
                          icon: Icon(Icons.search, size: 24),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, right: 10),
                    child: IconButton(
                        color: CustomColors().secondaryTextColor,
                        icon: Icon(Icons.pedal_bike), // to jest pedalarz
                        onPressed: () {
                          getTrips();
                          refreshMap();
                        }),
                  )
                ],
              )),
        ],
      ),
      //),
    );
  }

  void prepareMap() {
    _mapSource = MapShapeSource.asset(
      'assets/world_map.json',
      shapeDataField: printingName(),
      dataCount: _data.length,
      primaryValueMapper: (int index) => _data[index].name,
      //this is needed to connect models to places on map - DONT CHANGE!
      dataLabelMapper: (int index) => _data[index].blank,
      //this is shown as a name of country
      shapeColorValueMapper: (int index) => _data[index].color,
      //shapeColorValueMapper: (int index) => myYellow,
    );

    _zoomPanBehavior = MapZoomPanBehavior(
        enableDoubleTapZooming: false, minZoomLevel: 1, maxZoomLevel: 50)
      ..zoomLevel = 4
      ..focalLatLng = focal
      ..toolbarSettings = MapToolbarSettings();
  }

  void refreshMap() {
    setState(() {
      _mapSource = MapShapeSource.asset(
        'assets/world_map.json',
        shapeDataField: 'name',
        dataCount: _data.length,
        primaryValueMapper: (int index) => _data[index].name,
        //this is needed to connect models to places on map - DONT CHANGE!
        dataLabelMapper: (int index) => _data[index].blank,
        //this is shown as a name of country
        shapeColorValueMapper: (int index) => _data[index].color,
        //shapeColorValueMapper: (int index) => myBlue,
      );
    });
  }

  int indexInKivis(String value) {
    int temp = _countriesMineSynch.indexOf(value);
    if (temp == -1) {
      return -1;
    }
    int ret = _countriesKiviSynchIndex[temp];
    return ret;
  }

  int indexInMines(String value) {
    //int index = _countriesKiviSynchIndex[_countriesMineSynch.indexOf(value)];
    return 0;
  }

  Future<void> getTrips() async {
    _trips = await DatabaseService.fetchTrips();

    print("jestem 0");

    _countryPlusFriend = _trips
        .map((trip) => CountryPlusFriend(trip.country, trip.user.username))
        .toList();
    _countryList = _trips.map((trip) => trip.country).toList();
    Set<String> pom = _countryList.toSet();
    print(_countryList);

    print("jestem 1");

    pom.forEach((element) {
      map[element] = [];
    });

    _trips.forEach((element) {
      map[element.country]!.add(element);
    });

    print("jestem 2");

    _countryFriendsListSet = List<Set<String>>.filled(_countryList.length, {});

    for (int i = 0; i < _countryList.length; i++) {
      for (int j = 0; j < _countryPlusFriend.length; j++) {
        if (_countryList[i] == _countryPlusFriend[j].country) {
          _countryFriendsListSet[i].add(_countryPlusFriend[j].friend);
        }
      }
    }

    print("jestem 3");

    _countrySet = _countryList.toSet();

    for (int i = 0; i < _countriesFromMap.length; i++) {
      if (_countrySet.contains(_countriesFromMap[i])) {
        _data[i].color = _friendsVisitedCountryColor;
        print("Koloruje na czerwono: ${i}");
      }
    }

    _countriesFromDifferentSource = await city.getAllCountries();

    refreshMap();
  }

  int funWithSelectedCountries() {
    print("i'm in funWithSelectedCountries");
    int ret = 0;
    if (_newCountryClickedIndex == 0) {
      _snackTime = false;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ret = -1;
    } else {
      if (_snackTime == false) {
        _snackTime = true;
        _snackBar = createSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(_snackBar);
        ret = _newCountryClickedIndex;
      } else {
        if (_newCountryClickedIndex != _oldCountryClickedIndex) {
          _snackBar = createSnackBar();
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(_snackBar);
          ret = _newCountryClickedIndex;
        } else {
          _snackTime = false;
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ret = -1;
        }
      }
    }
    print("clicked country ${_newCountryClickedIndex}");

    print("you clicked on country: $ret");
    return ret;
  }

  //==============================================================================

  SnackBar createSnackBar() {
    SnackBar _tempSnackBar = SnackBar(
      content: Column(
        children: [
          Text(_data[_newCountryClickedIndex].name),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      Navigator.of(context).pushNamed(AppRoutes.newTripForm,
                          arguments: Trip(
                              country: _data[_newCountryClickedIndex].name,
                              city: "",
                              dateFrom: DateTime.now(),
                              dateTo: DateTime.now(),
                              description: "",
                              rate: 3,
                              user: UserShort(userId: "id", username: "user")));
                    },
                    child: const Text(
                      "Add trip",
                      style: TextStyle(
                        color: Colors.green,
                      ),
                    )),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      if (_countryList.contains(
                          _countriesFromMap[_newCountryClickedIndex])) {
                        print(_countryFriendsListSet[_countryList.indexOf(
                            _countriesFromMap[_newCountryClickedIndex])]);
                        Navigator.of(context).pushNamed(
                            AppRoutes.countrySiteScreen,
                            arguments: DowolnyPakiet(
                                friends: map[_countriesFromMap[
                                    _newCountryClickedIndex]]!,
                                country: _countriesFromMap[
                                    _newCountryClickedIndex]));
                      } else {
                        Navigator.of(context).pushNamed(
                            AppRoutes.countrySiteScreen,
                            arguments: DowolnyPakiet(
                                friends: [],
                                country: _countriesFromMap[
                                    _newCountryClickedIndex]));
                      }
                    },
                    child: const Text(
                      "Visitors",
                    )),
              ),
            ],
          )
        ],
      ),
      duration: Duration(days: 1),
      dismissDirection: DismissDirection.none,
    );
    return _tempSnackBar;
  }
}

/// Collection of Australia state code data.
class MyModel {
  /// Initialize the instance of the [MyModel] class.
  MyModel(this.admin, this.color, this.name, this.continent);

  /// Represents the country admin.
  String admin;

  /// Represents the country colour.
  Color color;

  /// Represents the country name.
  String name;

  /// Represents the country code.
  String continent;

  String blank = "";
}

class CountryPlusFriend {
  CountryPlusFriend(this.country, this.friend);

  String country;

  String friend;
}
