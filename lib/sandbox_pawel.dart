import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

void main() {
  return runApp(MapsApp());
}

/// This widget will be the root of application.
class MapsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Maps Demo',
      home: MyHomePage22(),
    );
  }
}

/// This widget is the home page of the application.
class MyHomePage22 extends StatefulWidget {
  /// Initialize the instance of the [MyHomePage22] class.
  const MyHomePage22({Key? key}) : super(key: key);

  @override
  State<MyHomePage22> createState() => _MyHomePage22State();
}

class _MyHomePage22State extends State<MyHomePage22> {
  _MyHomePage22State();

  late List<Model> _data;
  late MapShapeSource _mapSource;
  late int indeksik = 0;
  late MapZoomPanBehavior _zoomPanBehavior;

  late Color myBlue = Color.fromRGBO(120, 120, 200, 1.0);
  late Color myGreen = Color.fromRGBO(120, 200, 120, 1.0);
  late Color myYellow = Color.fromRGBO(120, 200, 200, 1.0);


  @override
  void initState() {
    _data = const <Model>[
      Model("Afghanistan", Color.fromRGBO(120, 200, 120, 1.0), "Afghanistan", "Asia" ),
      Model("Angola", Color.fromRGBO(120, 200, 120, 1.0), "Angola", "Africa" ),
      Model("Albania", Color.fromRGBO(120, 200, 120, 1.0), "Albania", "Europe" ),
      Model("United Arab Emirates", Color.fromRGBO(120, 200, 120, 1.0), "United Arab Emirates", "Asia" ),
      Model("Argentina", Color.fromRGBO(120, 200, 120, 1.0), "Argentina", "South America" ),
      Model("Armenia", Color.fromRGBO(120, 200, 120, 1.0), "Armenia", "Asia" ),
      Model("Australia", Color.fromRGBO(120, 200, 120, 1.0), "Australia", "Australia" ),
      Model("Austria", Color.fromRGBO(120, 200, 120, 1.0), "Austria", "Europe" ),
      Model("Azerbaijan", Color.fromRGBO(120, 200, 120, 1.0), "Azerbaijan", "Asia" ),
      Model("Burundi", Color.fromRGBO(120, 200, 120, 1.0), "Burundi", "Africa" ),
      Model("Belgium", Color.fromRGBO(120, 200, 120, 1.0), "Belgium", "Europe" ),
      Model("Benin", Color.fromRGBO(120, 200, 120, 1.0), "Benin", "Africa" ),
      Model("Burkina Faso", Color.fromRGBO(120, 200, 120, 1.0), "Burkina Faso", "Africa" ),
      Model("Bangladesh", Color.fromRGBO(120, 200, 120, 1.0), "Bangladesh", "Asia" ),
      Model("Bulgaria", Color.fromRGBO(120, 200, 120, 1.0), "Bulgaria", "Europe" ),
      Model("The Bahamas", Color.fromRGBO(120, 200, 120, 1.0), "Bahamas", "North America" ),
      Model("Bosnia and Herzegovina", Color.fromRGBO(120, 200, 120, 1.0), "Bosnia and Herz.", "Europe" ),
      Model("Belarus", Color.fromRGBO(120, 200, 120, 1.0), "Belarus", "Europe" ),
      Model("Belize", Color.fromRGBO(120, 200, 120, 1.0), "Belize", "North America" ),
      Model("Bolivia", Color.fromRGBO(120, 200, 120, 1.0), "Bolivia", "South America" ),
      Model("Brazil", Color.fromRGBO(120, 200, 120, 1.0), "Brazil", "South America" ),
      Model("Brunei", Color.fromRGBO(120, 200, 120, 1.0), "Brunei", "Asia" ),
      Model("Bhutan", Color.fromRGBO(120, 200, 120, 1.0), "Bhutan", "Asia" ),
      Model("Botswana", Color.fromRGBO(120, 200, 120, 1.0), "Botswana", "Africa" ),
      Model("Central African Republic", Color.fromRGBO(120, 200, 120, 1.0), "Central African Rep.", "Africa" ),
      Model("Canada", Color.fromRGBO(120, 200, 120, 1.0), "Canada", "North America" ),
      Model("Switzerland", Color.fromRGBO(120, 200, 120, 1.0), "Switzerland", "Europe" ),
      Model("Chile", Color.fromRGBO(120, 200, 120, 1.0), "Chile", "South America" ),
      Model("China", Color.fromRGBO(120, 200, 120, 1.0), "China", "Asia" ),
      Model("Ivory Coast", Color.fromRGBO(120, 200, 120, 1.0), "Côte d'Ivoire", "Africa" ),
      Model("Cameroon", Color.fromRGBO(120, 200, 120, 1.0), "Cameroon", "Africa" ),
      Model("Democratic Republic of the Congo", Color.fromRGBO(120, 200, 120, 1.0), "Dem. Rep. Congo", "Africa" ),
      Model("Republic of Congo", Color.fromRGBO(120, 200, 120, 1.0), "Congo", "Africa" ),
      Model("Colombia", Color.fromRGBO(120, 200, 120, 1.0), "Colombia", "South America" ),
      Model("Costa Rica", Color.fromRGBO(120, 200, 120, 1.0), "Costa Rica", "North America" ),
      Model("Cuba", Color.fromRGBO(120, 200, 120, 1.0), "Cuba", "North America" ),
      Model("Northern Cyprus", Color.fromRGBO(120, 200, 120, 1.0), "N. Cyprus", "Asia" ),
      Model("Cyprus", Color.fromRGBO(120, 200, 120, 1.0), "Cyprus", "Asia" ),
      Model("Czech Republic", Color.fromRGBO(120, 200, 120, 1.0), "Czech Rep.", "Europe" ),
      Model("Germany", Color.fromRGBO(120, 200, 120, 1.0), "Germany", "Europe" ),
      Model("Djibouti", Color.fromRGBO(120, 200, 120, 1.0), "Djibouti", "Africa" ),
      Model("Denmark", Color.fromRGBO(120, 200, 120, 1.0), "Denmark", "Europe" ),
      Model("Dominican Republic", Color.fromRGBO(120, 200, 120, 1.0), "Dominican Rep.", "North America" ),
      Model("Algeria", Color.fromRGBO(120, 200, 120, 1.0), "Algeria", "Africa" ),
      Model("Ecuador", Color.fromRGBO(120, 200, 120, 1.0), "Ecuador", "South America" ),
      Model("Egypt", Color.fromRGBO(120, 200, 120, 1.0), "Egypt", "Africa" ),
      Model("Eritrea", Color.fromRGBO(120, 200, 120, 1.0), "Eritrea", "Africa" ),
      Model("Spain", Color.fromRGBO(120, 200, 120, 1.0), "Spain", "Europe" ),
      Model("Estonia", Color.fromRGBO(120, 200, 120, 1.0), "Estonia", "Europe" ),
      Model("Ethiopia", Color.fromRGBO(120, 200, 120, 1.0), "Ethiopia", "Africa" ),
      Model("Finland", Color.fromRGBO(120, 200, 120, 1.0), "Finland", "Europe" ),
      Model("Fiji", Color.fromRGBO(120, 200, 120, 1.0), "Fiji", "Australia" ),
      Model("Falkland Islands", Color.fromRGBO(120, 200, 120, 1.0), "Falkland Is.", "South America" ),
      Model("France", Color.fromRGBO(120, 200, 120, 1.0), "France", "Europe" ),
      Model("Gabon", Color.fromRGBO(120, 200, 120, 1.0), "Gabon", "Africa" ),
      Model("United Kingdom", Color.fromRGBO(120, 200, 120, 1.0), "United Kingdom", "Europe" ),
      Model("Georgia", Color.fromRGBO(120, 200, 120, 1.0), "Georgia", "Asia" ),
      Model("Ghana", Color.fromRGBO(120, 200, 120, 1.0), "Ghana", "Africa" ),
      Model("Guinea", Color.fromRGBO(120, 200, 120, 1.0), "Guinea", "Africa" ),
      Model("Gambia", Color.fromRGBO(120, 200, 120, 1.0), "Gambia", "Africa" ),
      Model("Guinea Bissau", Color.fromRGBO(120, 200, 120, 1.0), "Guinea-Bissau", "Africa" ),
      Model("Equatorial Guinea", Color.fromRGBO(120, 200, 120, 1.0), "Eq. Guinea", "Africa" ),
      Model("Greece", Color.fromRGBO(120, 200, 120, 1.0), "Greece", "Europe" ),
      Model("Greenland", Color.fromRGBO(120, 200, 120, 1.0), "Greenland", "North America" ),
      Model("Guatemala", Color.fromRGBO(120, 200, 120, 1.0), "Guatemala", "North America" ),
      Model("Guyana", Color.fromRGBO(120, 200, 120, 1.0), "Guyana", "South America" ),
      Model("Honduras", Color.fromRGBO(120, 200, 120, 1.0), "Honduras", "North America" ),
      Model("Croatia", Color.fromRGBO(120, 200, 120, 1.0), "Croatia", "Europe" ),
      Model("Haiti", Color.fromRGBO(120, 200, 120, 1.0), "Haiti", "North America" ),
      Model("Hungary", Color.fromRGBO(120, 200, 120, 1.0), "Hungary", "Europe" ),
      Model("Indonesia", Color.fromRGBO(120, 200, 120, 1.0), "Indonesia", "Asia" ),
      Model("India", Color.fromRGBO(120, 200, 120, 1.0), "India", "Asia" ),
      Model("Ireland", Color.fromRGBO(120, 200, 120, 1.0), "Ireland", "Europe" ),
      Model("Iran", Color.fromRGBO(120, 200, 120, 1.0), "Iran", "Asia" ),
      Model("Iraq", Color.fromRGBO(120, 200, 120, 1.0), "Iraq", "Asia" ),
      Model("Iceland", Color.fromRGBO(120, 200, 120, 1.0), "Iceland", "Europe" ),
      Model("Israel", Color.fromRGBO(120, 200, 120, 1.0), "Israel", "Asia" ),
      Model("Italy", Color.fromRGBO(120, 200, 120, 1.0), "Italy", "Europe" ),
      Model("Jamaica", Color.fromRGBO(120, 200, 120, 1.0), "Jamaica", "North America" ),
      Model("Jordan", Color.fromRGBO(120, 200, 120, 1.0), "Jordan", "Asia" ),
      Model("Japan", Color.fromRGBO(120, 200, 120, 1.0), "Japan", "Asia" ),
      Model("Kazakhstan", Color.fromRGBO(120, 200, 120, 1.0), "Kazakhstan", "Asia" ),
      Model("Kenya", Color.fromRGBO(120, 200, 120, 1.0), "Kenya", "Africa" ),
      Model("Kyrgyzstan", Color.fromRGBO(120, 200, 120, 1.0), "Kyrgyzstan", "Asia" ),
      Model("Cambodia", Color.fromRGBO(120, 200, 120, 1.0), "Cambodia", "Asia" ),
      Model("South Korea", Color.fromRGBO(120, 200, 120, 1.0), "Korea", "Asia" ),
      Model("Kosovo", Color.fromRGBO(120, 200, 120, 1.0), "Kosovo", "Europe" ),
      Model("Kuwait", Color.fromRGBO(120, 200, 120, 1.0), "Kuwait", "Asia" ),
      Model("Laos", Color.fromRGBO(120, 200, 120, 1.0), "Lao PDR", "Asia" ),
      Model("Lebanon", Color.fromRGBO(120, 200, 120, 1.0), "Lebanon", "Asia" ),
      Model("Liberia", Color.fromRGBO(120, 200, 120, 1.0), "Liberia", "Africa" ),
      Model("Libya", Color.fromRGBO(120, 200, 120, 1.0), "Libya", "Africa" ),
      Model("Sri Lanka", Color.fromRGBO(120, 200, 120, 1.0), "Sri Lanka", "Asia" ),
      Model("Lesotho", Color.fromRGBO(120, 200, 120, 1.0), "Lesotho", "Africa" ),
      Model("Lithuania", Color.fromRGBO(120, 200, 120, 1.0), "Lithuania", "Europe" ),
      Model("Luxembourg", Color.fromRGBO(120, 200, 120, 1.0), "Luxembourg", "Europe" ),
      Model("Latvia", Color.fromRGBO(120, 200, 120, 1.0), "Latvia", "Europe" ),
      Model("Morocco", Color.fromRGBO(120, 200, 120, 1.0), "Morocco", "Africa" ),
      Model("Moldova", Color.fromRGBO(120, 200, 120, 1.0), "Moldova", "Europe" ),
      Model("Madagascar", Color.fromRGBO(120, 200, 120, 1.0), "Madagascar", "Africa" ),
      Model("Mexico", Color.fromRGBO(120, 200, 120, 1.0), "Mexico", "North America" ),
      Model("Macedonia", Color.fromRGBO(120, 200, 120, 1.0), "Macedonia", "Europe" ),
      Model("Mali", Color.fromRGBO(120, 200, 120, 1.0), "Mali", "Africa" ),
      Model("Myanmar", Color.fromRGBO(120, 200, 120, 1.0), "Myanmar", "Asia" ),
      Model("Montenegro", Color.fromRGBO(120, 200, 120, 1.0), "Montenegro", "Europe" ),
      Model("Mongolia", Color.fromRGBO(120, 200, 120, 1.0), "Mongolia", "Asia" ),
      Model("Mozambique", Color.fromRGBO(120, 200, 120, 1.0), "Mozambique", "Africa" ),
      Model("Mauritania", Color.fromRGBO(120, 200, 120, 1.0), "Mauritania", "Africa" ),
      Model("Malawi", Color.fromRGBO(120, 200, 120, 1.0), "Malawi", "Africa" ),
      Model("Malaysia", Color.fromRGBO(120, 200, 120, 1.0), "Malaysia", "Asia" ),
      Model("Namibia", Color.fromRGBO(120, 200, 120, 1.0), "Namibia", "Africa" ),
      Model("New Caledonia", Color.fromRGBO(120, 200, 120, 1.0), "New Caledonia", "Australia" ),
      Model("Niger", Color.fromRGBO(120, 200, 120, 1.0), "Niger", "Africa" ),
      Model("Nigeria", Color.fromRGBO(120, 200, 120, 1.0), "Nigeria", "Africa" ),
      Model("Nicaragua", Color.fromRGBO(120, 200, 120, 1.0), "Nicaragua", "North America" ),
      Model("Netherlands", Color.fromRGBO(120, 200, 120, 1.0), "Netherlands", "Europe" ),
      Model("Norway", Color.fromRGBO(120, 200, 120, 1.0), "Norway", "Europe" ),
      Model("Nepal", Color.fromRGBO(120, 200, 120, 1.0), "Nepal", "Asia" ),
      Model("New Zealand", Color.fromRGBO(120, 200, 120, 1.0), "New Zealand", "Australia" ),
      Model("Oman", Color.fromRGBO(120, 200, 120, 1.0), "Oman", "Asia" ),
      Model("Pakistan", Color.fromRGBO(120, 200, 120, 1.0), "Pakistan", "Asia" ),
      Model("Panama", Color.fromRGBO(120, 200, 120, 1.0), "Panama", "North America" ),
      Model("Peru", Color.fromRGBO(120, 200, 120, 1.0), "Peru", "South America" ),
      Model("Philippines", Color.fromRGBO(120, 200, 120, 1.0), "Philippines", "Asia" ),
      Model("Papua New Guinea", Color.fromRGBO(120, 200, 120, 1.0), "Papua New Guinea", "Australia" ),
      Model("Poland", Color.fromRGBO(120, 200, 120, 1.0), "Poland", "Europe" ),
      Model("Puerto Rico", Color.fromRGBO(120, 200, 120, 1.0), "Puerto Rico", "North America" ),
      Model("North Korea", Color.fromRGBO(120, 200, 120, 1.0), "Dem. Rep. Korea", "Asia" ),
      Model("Portugal", Color.fromRGBO(120, 200, 120, 1.0), "Portugal", "Europe" ),
      Model("Paraguay", Color.fromRGBO(120, 200, 120, 1.0), "Paraguay", "South America" ),
      Model("Palestine", Color.fromRGBO(120, 200, 120, 1.0), "Palestine", "Asia" ),
      Model("Qatar", Color.fromRGBO(120, 200, 120, 1.0), "Qatar", "Asia" ),
      Model("Romania", Color.fromRGBO(120, 200, 120, 1.0), "Romania", "Europe" ),
      Model("Russia", Color.fromRGBO(120, 200, 120, 1.0), "Russia", "Asia" ),
      Model("Rwanda", Color.fromRGBO(120, 200, 120, 1.0), "Rwanda", "Africa" ),
      Model("Western Sahara", Color.fromRGBO(120, 200, 120, 1.0), "W. Sahara", "Africa" ),
      Model("Saudi Arabia", Color.fromRGBO(120, 200, 120, 1.0), "Saudi Arabia", "Asia" ),
      Model("Sudan", Color.fromRGBO(120, 200, 120, 1.0), "Sudan", "Africa" ),
      Model("South Sudan", Color.fromRGBO(120, 200, 120, 1.0), "S. Sudan", "Africa" ),
      Model("Senegal", Color.fromRGBO(120, 200, 120, 1.0), "Senegal", "Africa" ),
      Model("Solomon Islands", Color.fromRGBO(120, 200, 120, 1.0), "Solomon Is.", "Australia" ),
      Model("Sierra Leone", Color.fromRGBO(120, 200, 120, 1.0), "Sierra Leone", "Africa" ),
      Model("El Salvador", Color.fromRGBO(120, 200, 120, 1.0), "El Salvador", "North America" ),
      Model("Somaliland", Color.fromRGBO(120, 200, 120, 1.0), "Somaliland", "Africa" ),
      Model("Somalia", Color.fromRGBO(120, 200, 120, 1.0), "Somalia", "Africa" ),
      Model("Republic of Serbia", Color.fromRGBO(120, 200, 120, 1.0), "Serbia", "Europe" ),
      Model("Suriname", Color.fromRGBO(120, 200, 120, 1.0), "Suriname", "South America" ),
      Model("Slovakia", Color.fromRGBO(120, 200, 120, 1.0), "Slovakia", "Europe" ),
      Model("Slovenia", Color.fromRGBO(120, 200, 120, 1.0), "Slovenia", "Europe" ),
      Model("Sweden", Color.fromRGBO(120, 200, 120, 1.0), "Sweden", "Europe" ),
      Model("Swaziland", Color.fromRGBO(120, 200, 120, 1.0), "Swaziland", "Africa" ),
      Model("Syria", Color.fromRGBO(120, 200, 120, 1.0), "Syria", "Asia" ),
      Model("Chad", Color.fromRGBO(120, 200, 120, 1.0), "Chad", "Africa" ),
      Model("Togo", Color.fromRGBO(120, 200, 120, 1.0), "Togo", "Africa" ),
      Model("Thailand", Color.fromRGBO(120, 200, 120, 1.0), "Thailand", "Asia" ),
      Model("Tajikistan", Color.fromRGBO(120, 200, 120, 1.0), "Tajikistan", "Asia" ),
      Model("Turkmenistan", Color.fromRGBO(120, 200, 120, 1.0), "Turkmenistan", "Asia" ),
      Model("East Timor", Color.fromRGBO(120, 200, 120, 1.0), "Timor-Leste", "Asia" ),
      Model("Trinidad and Tobago", Color.fromRGBO(120, 200, 120, 1.0), "Trinidad and Tobago", "North America" ),
      Model("Tunisia", Color.fromRGBO(120, 200, 120, 1.0), "Tunisia", "Africa" ),
      Model("Turkey", Color.fromRGBO(120, 200, 120, 1.0), "Turkey", "Asia" ),
      Model("Taiwan", Color.fromRGBO(120, 200, 120, 1.0), "Taiwan", "Asia" ),
      Model("United Republic of Tanzania", Color.fromRGBO(120, 200, 120, 1.0), "Tanzania", "Africa" ),
      Model("Uganda", Color.fromRGBO(120, 200, 120, 1.0), "Uganda", "Africa" ),
      Model("Ukraine", Color.fromRGBO(120, 200, 120, 1.0), "Ukraine", "Europe" ),
      Model("Uruguay", Color.fromRGBO(120, 200, 120, 1.0), "Uruguay", "South America" ),
      Model("United States of America", Color.fromRGBO(120, 200, 120, 1.0), "United States of America", "North America" ),
      Model("Uzbekistan", Color.fromRGBO(120, 200, 120, 1.0), "Uzbekistan", "Asia" ),
      Model("Venezuela", Color.fromRGBO(120, 200, 120, 1.0), "Venezuela", "South America" ),
      Model("Vietnam", Color.fromRGBO(120, 200, 120, 1.0), "Vietnam", "Asia" ),
      Model("Vanuatu", Color.fromRGBO(120, 200, 120, 1.0), "Vanuatu", "Australia" ),
      Model("Yemen", Color.fromRGBO(120, 200, 120, 1.0), "Yemen", "Asia" ),
      Model("South Africa", Color.fromRGBO(120, 200, 120, 1.0), "South Africa", "Africa" ),
      Model("Zambia", Color.fromRGBO(120, 200, 120, 1.0), "Zambia", "Africa" ),
      Model("Zimbabwe", Color.fromRGBO(120, 200, 120, 1.0), "Zimbabwe", "Africa" ),
    ];

    _mapSource = MapShapeSource.asset(
      'assets/world_map.json',
      shapeDataField: 'name',
      //shapeDataField: 'continent',
      dataCount: _data.length,
      primaryValueMapper: (int index) => _data[index].name,
      dataLabelMapper: (int index) => _data[index].blank,
      shapeColorValueMapper: (int index) => _data[index].color,
      //shapeColorValueMapper: (int index) => myBlue,
    );

    _zoomPanBehavior = MapZoomPanBehavior()
      ..zoomLevel = 4
      ..focalLatLng = MapLatLng(19.0759837, 72.8776559)
      ..toolbarSettings = MapToolbarSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(indeksik.toString()),
      ),
      body: SizedBox(
        height: 520,
        child: Center(
          child: SfMaps(
            layers: <MapShapeLayer>[
              MapShapeLayer(
                source: _mapSource,
                zoomPanBehavior: _zoomPanBehavior,
                showDataLabels: true,
                //legend: const MapLegend(MapElement.shape),
                tooltipSettings: MapTooltipSettings(
                    color: Colors.grey[700],
                    strokeColor: Colors.white,
                    strokeWidth: 2),
                strokeColor: Colors.white,
                strokeWidth: 0.5,
                shapeTooltipBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _data[index].admin,
                      style: const TextStyle(color: Colors.orange),
                    ),
                  );
                },
                onSelectionChanged: (int index) {
                  setState(() {
                    indeksik = (indeksik == index) ?
                    -1 : index;
                  });
                  print(indeksik);
                },
                /*dataLabelSettings: MapDataLabelSettings(
                  textStyle: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize:
                      Theme.of(context).textTheme.bodySmall!.fontSize),
                ),*/
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Collection of Australia state code data.
class Model {
  /// Initialize the instance of the [Model] class.
  const Model(this.admin, this.color, this.name, this.continent);

  /// Represents the country admin.
  final String admin;

  /// Represents the country colour.
  final Color color;

  /// Represents the country name.
  final String name;

  /// Represents the country code.
  final String continent;

  final String blank = "";
}