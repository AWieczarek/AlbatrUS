import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:country_state_city/country_state_city.dart' as city;
import 'package:dropdown_search/dropdown_search.dart';

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
  late int countryClickedIndex = -1;
  late MapZoomPanBehavior _zoomPanBehavior;
  late bool _snackTime = false;
  late SnackBar _snackBar;
  late List<String> _countriesFromMap;

  final Color myBlue = Color.fromRGBO(60, 90, 200, 1.0);
  final Color myGreen = Color.fromRGBO(60, 200, 30, 1.0);
  final Color myYellow = Color.fromRGBO(200, 200, 30, 1.0);

  @override
  void initState() {

    _data = <MyModel>[
      MyModel("Afghanistan", Color.fromRGBO(120, 200, 120, 1.0), "Afghanistan", "Asia" ),
      MyModel("Angola", Color.fromRGBO(120, 200, 120, 1.0), "Angola", "Africa" ),
      MyModel("Albania", Color.fromRGBO(120, 200, 120, 1.0), "Albania", "Europe" ),
      MyModel("United Arab Emirates", Color.fromRGBO(120, 200, 120, 1.0), "United Arab Emirates", "Asia" ),
      MyModel("Argentina", Color.fromRGBO(120, 200, 120, 1.0), "Argentina", "South America" ),
      MyModel("Armenia", Color.fromRGBO(120, 200, 120, 1.0), "Armenia", "Asia" ),
      MyModel("Australia", Color.fromRGBO(120, 200, 120, 1.0), "Australia", "Australia" ),
      MyModel("Austria", Color.fromRGBO(120, 200, 120, 1.0), "Austria", "Europe" ),
      MyModel("Azerbaijan", Color.fromRGBO(120, 200, 120, 1.0), "Azerbaijan", "Asia" ),
      MyModel("Burundi", Color.fromRGBO(120, 200, 120, 1.0), "Burundi", "Africa" ),
      MyModel("Belgium", Color.fromRGBO(120, 200, 120, 1.0), "Belgium", "Europe" ),
      MyModel("Benin", Color.fromRGBO(120, 200, 120, 1.0), "Benin", "Africa" ),
      MyModel("Burkina Faso", Color.fromRGBO(120, 200, 120, 1.0), "Burkina Faso", "Africa" ),
      MyModel("Bangladesh", Color.fromRGBO(120, 200, 120, 1.0), "Bangladesh", "Asia" ),
      MyModel("Bulgaria", Color.fromRGBO(120, 200, 120, 1.0), "Bulgaria", "Europe" ),
      MyModel("The Bahamas", Color.fromRGBO(120, 200, 120, 1.0), "Bahamas", "North America" ),
      MyModel("Bosnia and Herzegovina", Color.fromRGBO(120, 200, 120, 1.0), "Bosnia and Herz.", "Europe" ),
      MyModel("Belarus", Color.fromRGBO(120, 200, 120, 1.0), "Belarus", "Europe" ),
      MyModel("Belize", Color.fromRGBO(120, 200, 120, 1.0), "Belize", "North America" ),
      MyModel("Bolivia", Color.fromRGBO(120, 200, 120, 1.0), "Bolivia", "South America" ),
      MyModel("Brazil", Color.fromRGBO(120, 200, 120, 1.0), "Brazil", "South America" ),
      MyModel("Brunei", Color.fromRGBO(120, 200, 120, 1.0), "Brunei", "Asia" ),
      MyModel("Bhutan", Color.fromRGBO(120, 200, 120, 1.0), "Bhutan", "Asia" ),
      MyModel("Botswana", Color.fromRGBO(120, 200, 120, 1.0), "Botswana", "Africa" ),
      MyModel("Central African Republic", Color.fromRGBO(120, 200, 120, 1.0), "Central African Rep.", "Africa" ),
      MyModel("Canada", Color.fromRGBO(120, 200, 120, 1.0), "Canada", "North America" ),
      MyModel("Switzerland", Color.fromRGBO(120, 200, 120, 1.0), "Switzerland", "Europe" ),
      MyModel("Chile", Color.fromRGBO(120, 200, 120, 1.0), "Chile", "South America" ),
      MyModel("China", Color.fromRGBO(120, 200, 120, 1.0), "China", "Asia" ),
      MyModel("Ivory Coast", Color.fromRGBO(120, 200, 120, 1.0), "Côte d'Ivoire", "Africa" ),
      MyModel("Cameroon", Color.fromRGBO(120, 200, 120, 1.0), "Cameroon", "Africa" ),
      MyModel("Democratic Republic of the Congo", Color.fromRGBO(120, 200, 120, 1.0), "Dem. Rep. Congo", "Africa" ),
      MyModel("Republic of Congo", Color.fromRGBO(120, 200, 120, 1.0), "Congo", "Africa" ),
      MyModel("Colombia", Color.fromRGBO(120, 200, 120, 1.0), "Colombia", "South America" ),
      MyModel("Costa Rica", Color.fromRGBO(120, 200, 120, 1.0), "Costa Rica", "North America" ),
      MyModel("Cuba", Color.fromRGBO(120, 200, 120, 1.0), "Cuba", "North America" ),
      MyModel("Northern Cyprus", Color.fromRGBO(120, 200, 120, 1.0), "N. Cyprus", "Asia" ),
      MyModel("Cyprus", Color.fromRGBO(120, 200, 120, 1.0), "Cyprus", "Asia" ),
      MyModel("Czech Republic", Color.fromRGBO(120, 200, 120, 1.0), "Czech Rep.", "Europe" ),
      MyModel("Germany", Color.fromRGBO(120, 200, 120, 1.0), "Germany", "Europe" ),
      MyModel("Djibouti", Color.fromRGBO(120, 200, 120, 1.0), "Djibouti", "Africa" ),
      MyModel("Denmark", Color.fromRGBO(120, 200, 120, 1.0), "Denmark", "Europe" ),
      MyModel("Dominican Republic", Color.fromRGBO(120, 200, 120, 1.0), "Dominican Rep.", "North America" ),
      MyModel("Algeria", Color.fromRGBO(120, 200, 120, 1.0), "Algeria", "Africa" ),
      MyModel("Ecuador", Color.fromRGBO(120, 200, 120, 1.0), "Ecuador", "South America" ),
      MyModel("Egypt", Color.fromRGBO(120, 200, 120, 1.0), "Egypt", "Africa" ),
      MyModel("Eritrea", Color.fromRGBO(120, 200, 120, 1.0), "Eritrea", "Africa" ),
      MyModel("Spain", Color.fromRGBO(120, 200, 120, 1.0), "Spain", "Europe" ),
      MyModel("Estonia", Color.fromRGBO(120, 200, 120, 1.0), "Estonia", "Europe" ),
      MyModel("Ethiopia", Color.fromRGBO(120, 200, 120, 1.0), "Ethiopia", "Africa" ),
      MyModel("Finland", Color.fromRGBO(120, 200, 120, 1.0), "Finland", "Europe" ),
      MyModel("Fiji", Color.fromRGBO(120, 200, 120, 1.0), "Fiji", "Australia" ),
      MyModel("Falkland Islands", Color.fromRGBO(120, 200, 120, 1.0), "Falkland Is.", "South America" ),
      MyModel("France", Color.fromRGBO(120, 200, 120, 1.0), "France", "Europe" ),
      MyModel("Gabon", Color.fromRGBO(120, 200, 120, 1.0), "Gabon", "Africa" ),
      MyModel("United Kingdom", Color.fromRGBO(120, 200, 120, 1.0), "United Kingdom", "Europe" ),
      MyModel("Georgia", Color.fromRGBO(120, 200, 120, 1.0), "Georgia", "Asia" ),
      MyModel("Ghana", Color.fromRGBO(120, 200, 120, 1.0), "Ghana", "Africa" ),
      MyModel("Guinea", Color.fromRGBO(120, 200, 120, 1.0), "Guinea", "Africa" ),
      MyModel("Gambia", Color.fromRGBO(120, 200, 120, 1.0), "Gambia", "Africa" ),
      MyModel("Guinea Bissau", Color.fromRGBO(120, 200, 120, 1.0), "Guinea-Bissau", "Africa" ),
      MyModel("Equatorial Guinea", Color.fromRGBO(120, 200, 120, 1.0), "Eq. Guinea", "Africa" ),
      MyModel("Greece", Color.fromRGBO(120, 200, 120, 1.0), "Greece", "Europe" ),
      MyModel("Greenland", Color.fromRGBO(120, 200, 120, 1.0), "Greenland", "North America" ),
      MyModel("Guatemala", Color.fromRGBO(120, 200, 120, 1.0), "Guatemala", "North America" ),
      MyModel("Guyana", Color.fromRGBO(120, 200, 120, 1.0), "Guyana", "South America" ),
      MyModel("Honduras", Color.fromRGBO(120, 200, 120, 1.0), "Honduras", "North America" ),
      MyModel("Croatia", Color.fromRGBO(120, 200, 120, 1.0), "Croatia", "Europe" ),
      MyModel("Haiti", Color.fromRGBO(120, 200, 120, 1.0), "Haiti", "North America" ),
      MyModel("Hungary", Color.fromRGBO(120, 200, 120, 1.0), "Hungary", "Europe" ),
      MyModel("Indonesia", Color.fromRGBO(120, 200, 120, 1.0), "Indonesia", "Asia" ),
      MyModel("India", Color.fromRGBO(120, 200, 120, 1.0), "India", "Asia" ),
      MyModel("Ireland", Color.fromRGBO(120, 200, 120, 1.0), "Ireland", "Europe" ),
      MyModel("Iran", Color.fromRGBO(120, 200, 120, 1.0), "Iran", "Asia" ),
      MyModel("Iraq", Color.fromRGBO(120, 200, 120, 1.0), "Iraq", "Asia" ),
      MyModel("Iceland", Color.fromRGBO(120, 200, 120, 1.0), "Iceland", "Europe" ),
      MyModel("Israel", Color.fromRGBO(120, 200, 120, 1.0), "Israel", "Asia" ),
      MyModel("Italy", Color.fromRGBO(120, 200, 120, 1.0), "Italy", "Europe" ),
      MyModel("Jamaica", Color.fromRGBO(120, 200, 120, 1.0), "Jamaica", "North America" ),
      MyModel("Jordan", Color.fromRGBO(120, 200, 120, 1.0), "Jordan", "Asia" ),
      MyModel("Japan", Color.fromRGBO(120, 200, 120, 1.0), "Japan", "Asia" ),
      MyModel("Kazakhstan", Color.fromRGBO(120, 200, 120, 1.0), "Kazakhstan", "Asia" ),
      MyModel("Kenya", Color.fromRGBO(120, 200, 120, 1.0), "Kenya", "Africa" ),
      MyModel("Kyrgyzstan", Color.fromRGBO(120, 200, 120, 1.0), "Kyrgyzstan", "Asia" ),
      MyModel("Cambodia", Color.fromRGBO(120, 200, 120, 1.0), "Cambodia", "Asia" ),
      MyModel("South Korea", Color.fromRGBO(120, 200, 120, 1.0), "Korea", "Asia" ),
      MyModel("Kosovo", Color.fromRGBO(120, 200, 120, 1.0), "Kosovo", "Europe" ),
      MyModel("Kuwait", Color.fromRGBO(120, 200, 120, 1.0), "Kuwait", "Asia" ),
      MyModel("Laos", Color.fromRGBO(120, 200, 120, 1.0), "Lao PDR", "Asia" ),
      MyModel("Lebanon", Color.fromRGBO(120, 200, 120, 1.0), "Lebanon", "Asia" ),
      MyModel("Liberia", Color.fromRGBO(120, 200, 120, 1.0), "Liberia", "Africa" ),
      MyModel("Libya", Color.fromRGBO(120, 200, 120, 1.0), "Libya", "Africa" ),
      MyModel("Sri Lanka", Color.fromRGBO(120, 200, 120, 1.0), "Sri Lanka", "Asia" ),
      MyModel("Lesotho", Color.fromRGBO(120, 200, 120, 1.0), "Lesotho", "Africa" ),
      MyModel("Lithuania", Color.fromRGBO(120, 200, 120, 1.0), "Lithuania", "Europe" ),
      MyModel("Luxembourg", Color.fromRGBO(120, 200, 120, 1.0), "Luxembourg", "Europe" ),
      MyModel("Latvia", Color.fromRGBO(120, 200, 120, 1.0), "Latvia", "Europe" ),
      MyModel("Morocco", Color.fromRGBO(120, 200, 120, 1.0), "Morocco", "Africa" ),
      MyModel("Moldova", Color.fromRGBO(120, 200, 120, 1.0), "Moldova", "Europe" ),
      MyModel("Madagascar", Color.fromRGBO(120, 200, 120, 1.0), "Madagascar", "Africa" ),
      MyModel("Mexico", Color.fromRGBO(120, 200, 120, 1.0), "Mexico", "North America" ),
      MyModel("Macedonia", Color.fromRGBO(120, 200, 120, 1.0), "Macedonia", "Europe" ),
      MyModel("Mali", Color.fromRGBO(120, 200, 120, 1.0), "Mali", "Africa" ),
      MyModel("Myanmar", Color.fromRGBO(120, 200, 120, 1.0), "Myanmar", "Asia" ),
      MyModel("Montenegro", Color.fromRGBO(120, 200, 120, 1.0), "Montenegro", "Europe" ),
      MyModel("Mongolia", Color.fromRGBO(120, 200, 120, 1.0), "Mongolia", "Asia" ),
      MyModel("Mozambique", Color.fromRGBO(120, 200, 120, 1.0), "Mozambique", "Africa" ),
      MyModel("Mauritania", Color.fromRGBO(120, 200, 120, 1.0), "Mauritania", "Africa" ),
      MyModel("Malawi", Color.fromRGBO(120, 200, 120, 1.0), "Malawi", "Africa" ),
      MyModel("Malaysia", Color.fromRGBO(120, 200, 120, 1.0), "Malaysia", "Asia" ),
      MyModel("Namibia", Color.fromRGBO(120, 200, 120, 1.0), "Namibia", "Africa" ),
      MyModel("New Caledonia", Color.fromRGBO(120, 200, 120, 1.0), "New Caledonia", "Australia" ),
      MyModel("Niger", Color.fromRGBO(120, 200, 120, 1.0), "Niger", "Africa" ),
      MyModel("Nigeria", Color.fromRGBO(120, 200, 120, 1.0), "Nigeria", "Africa" ),
      MyModel("Nicaragua", Color.fromRGBO(120, 200, 120, 1.0), "Nicaragua", "North America" ),
      MyModel("Netherlands", Color.fromRGBO(120, 200, 120, 1.0), "Netherlands", "Europe" ),
      MyModel("Norway", Color.fromRGBO(120, 200, 120, 1.0), "Norway", "Europe" ),
      MyModel("Nepal", Color.fromRGBO(120, 200, 120, 1.0), "Nepal", "Asia" ),
      MyModel("New Zealand", Color.fromRGBO(120, 200, 120, 1.0), "New Zealand", "Australia" ),
      MyModel("Oman", Color.fromRGBO(120, 200, 120, 1.0), "Oman", "Asia" ),
      MyModel("Pakistan", Color.fromRGBO(120, 200, 120, 1.0), "Pakistan", "Asia" ),
      MyModel("Panama", Color.fromRGBO(120, 200, 120, 1.0), "Panama", "North America" ),
      MyModel("Peru", Color.fromRGBO(120, 200, 120, 1.0), "Peru", "South America" ),
      MyModel("Philippines", Color.fromRGBO(120, 200, 120, 1.0), "Philippines", "Asia" ),
      MyModel("Papua New Guinea", Color.fromRGBO(120, 200, 120, 1.0), "Papua New Guinea", "Australia" ),
      MyModel("Poland", Color.fromRGBO(120, 200, 120, 1.0), "Poland", "Europe" ),
      MyModel("Puerto Rico", Color.fromRGBO(120, 200, 120, 1.0), "Puerto Rico", "North America" ),
      MyModel("North Korea", Color.fromRGBO(120, 200, 120, 1.0), "Dem. Rep. Korea", "Asia" ),
      MyModel("Portugal", Color.fromRGBO(120, 200, 120, 1.0), "Portugal", "Europe" ),
      MyModel("Paraguay", Color.fromRGBO(120, 200, 120, 1.0), "Paraguay", "South America" ),
      MyModel("Palestine", Color.fromRGBO(120, 200, 120, 1.0), "Palestine", "Asia" ),
      MyModel("Qatar", Color.fromRGBO(120, 200, 120, 1.0), "Qatar", "Asia" ),
      MyModel("Romania", Color.fromRGBO(120, 200, 120, 1.0), "Romania", "Europe" ),
      MyModel("Russia", Color.fromRGBO(120, 200, 120, 1.0), "Russia", "Asia" ),
      MyModel("Rwanda", Color.fromRGBO(120, 200, 120, 1.0), "Rwanda", "Africa" ),
      MyModel("Western Sahara", Color.fromRGBO(120, 200, 120, 1.0), "W. Sahara", "Africa" ),
      MyModel("Saudi Arabia", Color.fromRGBO(120, 200, 120, 1.0), "Saudi Arabia", "Asia" ),
      MyModel("Sudan", Color.fromRGBO(120, 200, 120, 1.0), "Sudan", "Africa" ),
      MyModel("South Sudan", Color.fromRGBO(120, 200, 120, 1.0), "S. Sudan", "Africa" ),
      MyModel("Senegal", Color.fromRGBO(120, 200, 120, 1.0), "Senegal", "Africa" ),
      MyModel("Solomon Islands", Color.fromRGBO(120, 200, 120, 1.0), "Solomon Is.", "Australia" ),
      MyModel("Sierra Leone", Color.fromRGBO(120, 200, 120, 1.0), "Sierra Leone", "Africa" ),
      MyModel("El Salvador", Color.fromRGBO(120, 200, 120, 1.0), "El Salvador", "North America" ),
      MyModel("Somaliland", Color.fromRGBO(120, 200, 120, 1.0), "Somaliland", "Africa" ),
      MyModel("Somalia", Color.fromRGBO(120, 200, 120, 1.0), "Somalia", "Africa" ),
      MyModel("Republic of Serbia", Color.fromRGBO(120, 200, 120, 1.0), "Serbia", "Europe" ),
      MyModel("Suriname", Color.fromRGBO(120, 200, 120, 1.0), "Suriname", "South America" ),
      MyModel("Slovakia", Color.fromRGBO(120, 200, 120, 1.0), "Slovakia", "Europe" ),
      MyModel("Slovenia", Color.fromRGBO(120, 200, 120, 1.0), "Slovenia", "Europe" ),
      MyModel("Sweden", Color.fromRGBO(120, 200, 120, 1.0), "Sweden", "Europe" ),
      MyModel("Swaziland", Color.fromRGBO(120, 200, 120, 1.0), "Swaziland", "Africa" ),
      MyModel("Syria", Color.fromRGBO(120, 200, 120, 1.0), "Syria", "Asia" ),
      MyModel("Chad", Color.fromRGBO(120, 200, 120, 1.0), "Chad", "Africa" ),
      MyModel("Togo", Color.fromRGBO(120, 200, 120, 1.0), "Togo", "Africa" ),
      MyModel("Thailand", Color.fromRGBO(120, 200, 120, 1.0), "Thailand", "Asia" ),
      MyModel("Tajikistan", Color.fromRGBO(120, 200, 120, 1.0), "Tajikistan", "Asia" ),
      MyModel("Turkmenistan", Color.fromRGBO(120, 200, 120, 1.0), "Turkmenistan", "Asia" ),
      MyModel("East Timor", Color.fromRGBO(120, 200, 120, 1.0), "Timor-Leste", "Asia" ),
      MyModel("Trinidad and Tobago", Color.fromRGBO(120, 200, 120, 1.0), "Trinidad and Tobago", "North America" ),
      MyModel("Tunisia", Color.fromRGBO(120, 200, 120, 1.0), "Tunisia", "Africa" ),
      MyModel("Turkey", Color.fromRGBO(120, 200, 120, 1.0), "Turkey", "Asia" ),
      MyModel("Taiwan", Color.fromRGBO(120, 200, 120, 1.0), "Taiwan", "Asia" ),
      MyModel("United Republic of Tanzania", Color.fromRGBO(120, 200, 120, 1.0), "Tanzania", "Africa" ),
      MyModel("Uganda", Color.fromRGBO(120, 200, 120, 1.0), "Uganda", "Africa" ),
      MyModel("Ukraine", Color.fromRGBO(120, 200, 120, 1.0), "Ukraine", "Europe" ),
      MyModel("Uruguay", Color.fromRGBO(120, 200, 120, 1.0), "Uruguay", "South America" ),
      MyModel("United States of America", Color.fromRGBO(120, 200, 120, 1.0), "United States of America", "North America" ),
      MyModel("Uzbekistan", Color.fromRGBO(120, 200, 120, 1.0), "Uzbekistan", "Asia" ),
      MyModel("Venezuela", Color.fromRGBO(120, 200, 120, 1.0), "Venezuela", "South America" ),
      MyModel("Vietnam", Color.fromRGBO(120, 200, 120, 1.0), "Vietnam", "Asia" ),
      MyModel("Vanuatu", Color.fromRGBO(120, 200, 120, 1.0), "Vanuatu", "Australia" ),
      MyModel("Yemen", Color.fromRGBO(120, 200, 120, 1.0), "Yemen", "Asia" ),
      MyModel("South Africa", Color.fromRGBO(120, 200, 120, 1.0), "South Africa", "Africa" ),
      MyModel("Zambia", Color.fromRGBO(120, 200, 120, 1.0), "Zambia", "Africa" ),
      MyModel("Zimbabwe", Color.fromRGBO(120, 200, 120, 1.0), "Zimbabwe", "Africa" ),
    ];

    _countriesFromMap = ["Afghanistan", "Angola", "Albania", "United Arab Emirates", "Argentina", "Armenia", "Australia", "Austria", "Azerbaijan", "Burundi", "Belgium", "Benin", "Burkina Faso", "Bangladesh", "Bulgaria", "Bahamas", "Bosnia and Herz.", "Belarus", "Belize", "Bolivia", "Brazil", "Brunei", "Bhutan", "Botswana", "Central African Rep.", "Canada", "Switzerland", "Chile", "China", "Côte d'Ivoire", "Cameroon", "Dem. Rep. Congo", "Congo", "Colombia", "Costa Rica", "Cuba", "N. Cyprus", "Cyprus", "Czech Rep.", "Germany", "Djibouti", "Denmark", "Dominican Rep.", "Algeria", "Ecuador", "Egypt", "Eritrea", "Spain", "Estonia", "Ethiopia", "Finland", "Fiji", "Falkland Is.", "France", "Gabon", "United Kingdom", "Georgia", "Ghana", "Guinea", "Gambia", "Guinea-Bissau", "Eq. Guinea", "Greece", "Greenland", "Guatemala", "Guyana", "Honduras", "Croatia", "Haiti", "Hungary", "Indonesia", "India", "Ireland", "Iran", "Iraq", "Iceland", "Israel", "Italy", "Jamaica", "Jordan", "Japan", "Kazakhstan", "Kenya", "Kyrgyzstan", "Cambodia", "Korea", "Kosovo", "Kuwait", "Lao PDR", "Lebanon", "Liberia", "Libya", "Sri Lanka", "Lesotho", "Lithuania", "Luxembourg", "Latvia", "Morocco", "Moldova", "Madagascar", "Mexico", "Macedonia", "Mali", "Myanmar", "Montenegro", "Mongolia", "Mozambique", "Mauritania", "Malawi", "Malaysia", "Namibia", "New Caledonia", "Niger", "Nigeria", "Nicaragua", "Netherlands", "Norway", "Nepal", "New Zealand", "Oman", "Pakistan", "Panama", "Peru", "Philippines", "Papua New Guinea", "Poland", "Puerto Rico", "Dem. Rep. Korea", "Portugal", "Paraguay", "Palestine", "Qatar", "Romania", "Russia", "Rwanda", "W. Sahara", "Saudi Arabia", "Sudan", "S. Sudan", "Senegal", "Solomon Is.", "Sierra Leone", "El Salvador", "Somaliland", "Somalia", "Serbia", "Suriname", "Slovakia", "Slovenia", "Sweden", "Swaziland", "Syria", "Chad", "Togo", "Thailand", "Tajikistan", "Turkmenistan", "Timor-Leste", "Trinidad and Tobago", "Tunisia", "Turkey", "Taiwan", "Tanzania", "Uganda", "Ukraine", "Uruguay", "United States of America", "Uzbekistan", "Venezuela", "Vietnam", "Vanuatu", "Yemen", "South Africa", "Zambia", "Zimbabwe"];

    _mapSource = MapShapeSource.asset(
      'assets/world_map.json',
      shapeDataField: 'name',
      dataCount: _data.length,
      primaryValueMapper: (int index) => _data[index].name, //this is needed to connect models to places on map - DONT CHANGE!
      dataLabelMapper: (int index) => _data[index].blank, //this is shown as a name of country
      shapeColorValueMapper: (int index) => _data[index].color,
      //shapeColorValueMapper: (int index) => myBlue,
    );

    _zoomPanBehavior = MapZoomPanBehavior(enableDoubleTapZooming: false, minZoomLevel: 1, maxZoomLevel: 50)
      ..zoomLevel = 4
      ..focalLatLng = MapLatLng(19.0759837, 72.8776559)
      ..toolbarSettings = MapToolbarSettings();

    super.initState();
  }

  late int fidget=0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              color: Colors.lightBlue[300],
            ),
            Center(
              child: Container(
                child: SfMaps(
                  layers: <MapShapeLayer>[
                    MapShapeLayer(
                      source: _mapSource,
                      zoomPanBehavior: _zoomPanBehavior,
                      strokeColor: Colors.white,
                      strokeWidth: 1,
                      showDataLabels: true,
                      selectedIndex: countryClickedIndex,
                      selectionSettings: MapSelectionSettings(
                        color: Color.fromRGBO(200, 200, 50, 1),
                        strokeColor: Colors.black,
                      ),
                      //legend: const MapLegend(MapElement.shape),
                      tooltipSettings: MapTooltipSettings(
                          color: Colors.grey[400],
                          strokeColor: Colors.grey[700],
                          strokeWidth: 2),
                      onSelectionChanged: (int index) {
                        if (_snackTime == false) {
                          _snackTime = true;
                          _snackBar = SnackBar(
                            content: Column(
                              children: [
                                Text(_data[index].name),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: (){
                                          print("open site of country ${index}");
                                        },
                                        child: Text("open",style: const TextStyle(
                                          color: Colors.green,
                                        ),)
                                      ),
                                    ),
                                    Expanded(
                                      child: ElevatedButton(
                                          onPressed: (){
                                            print("blue ${index}");
                                            _data[index].color = Colors.black;
                                            setState(() {
                                              _mapSource = MapShapeSource.asset(
                                                'assets/world_map.json',
                                                shapeDataField: 'name',
                                                dataCount: _data.length,
                                                primaryValueMapper: (int index) => _data[index].name, //this is needed to connect models to places on map - DONT CHANGE!
                                                dataLabelMapper: (int index) => _data[index].blank, //this is shown as a name of country
                                                shapeColorValueMapper: (int index) => _data[index].color,
                                                //shapeColorValueMapper: (int index) => myBlue,
                                              );
                                            });
                                          },
                                          child: Text("blue",style: const TextStyle(
                                            color: Colors.blue,
                                          ),)
                                      ),
                                    ),
                                    Expanded(

                                      
                                      child: ElevatedButton(
                                          onPressed: (){
                                            print("yellow ${index}");
                                            if(_data[index].color == Colors.black) {print("tak");}
                                          },
                                          child: Text("yellow",style: const TextStyle(
                                            color: Colors.yellow,
                                          ),)
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            duration: Duration(days: 1),
                            dismissDirection: DismissDirection.none,
                          );

                          ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                        }
                        else{
                          if(index != countryClickedIndex){
                            _snackBar = SnackBar(
                              content: Column(
                                children: [
                                  Text(_data[index].name),
                                  Row(
                                    children: [
                                      ElevatedButton(
                                          onPressed: (){
                                            print("open site of country ${index}");
                                          },
                                          child: Text("open",style: const TextStyle(
                                            color: Colors.green,
                                          ),)
                                      ),
                                      ElevatedButton(
                                          onPressed: (){
                                            print("blue ${index}");
                                            _data[index].color = Colors.black;
                                            setState(() {
                                              _mapSource = MapShapeSource.asset(
                                                'assets/world_map.json',
                                                shapeDataField: 'name',
                                                dataCount: _data.length,
                                                primaryValueMapper: (int index) => _data[index].name, //this is needed to connect models to places on map - DONT CHANGE!
                                                dataLabelMapper: (int index) => _data[index].blank, //this is shown as a name of country
                                                shapeColorValueMapper: (int index) => _data[index].color,
                                                //shapeColorValueMapper: (int index) => myBlue,
                                              );
                                            });
                                          },
                                          child: Text("blue",style: const TextStyle(
                                            color: Colors.blue,
                                          ),)
                                      ),ElevatedButton(
                                          onPressed: (){
                                            print("yellow ${index}");
                                            if(_data[index].color == Colors.black) {print("tak");}
                                          },
                                          child: Text("yellow",style: const TextStyle(
                                            color: Colors.yellow,
                                          ),)
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              duration: Duration(days: 1),
                              dismissDirection: DismissDirection.none,
                            );
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                          }
                          else{
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            _snackTime = false;
                          }
                        }

                        setState(() {
                          countryClickedIndex = index;
                        });

                        print("clicked country ${countryClickedIndex}");
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
            Positioned(
              top: 0,
              right: 0,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 100, right: 10),
                    child: IconButton(
                      color: Colors.black,
                      icon: Icon(Icons.search), //to jest wyszukiwarka
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('tu będą filtry'),
                              content: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    TextField(
                                      decoration: InputDecoration(
                                        hintText: 'Enter Country Name...',
                                      ),
                                    ),
                                    SizedBox(height: 16),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        // Tutaj możesz dodać akcję wyszukiwania
                                      },
                                      child: Text('Szukaj'),
                                    ),
                                  ]
                                )
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20, right: 10),
                    child: IconButton(
                      color: Colors.black,
                      icon: Icon(Icons.pedal_bike), // to jest pedalarz
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('tu będą filtry'),
                              content: Text('To jest treść okienka.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Zamknij'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    ),
                  )
                ],
              )
            )
          ],
        ),
      ),
    );
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