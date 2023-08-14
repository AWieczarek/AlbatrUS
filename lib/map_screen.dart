import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:country_state_city/country_state_city.dart' as city;
import 'package:dropdown_search/dropdown_search.dart';
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
  late Color _temporaryColor;

  final Color _backgroundCountryColor = Color.fromRGBO(0, 0, 0, 1.0);
  final Color _selectedCountryColor = Color.fromRGBO(54, 93, 163, 1.0);
  //final Color _friendsVisitedCountryColor = Color.fromRGBO(84, 184, 133, 0.2);
  final Color _friendsVisitedCountryColor = Color.fromRGBO(28, 59, 41, 1.0);
  final Color _myVisitedCountryColor = Color.fromRGBO(184, 67, 75, 1.0);
  final Color _defaultCountryColor = Color.fromRGBO(40, 40, 40, 1.0);
  //final Color _selectedStrokeColor = Color.fromRGBO(54, 93, 163, 1.0);
  final Color _selectedStrokeColor = Color.fromRGBO(40, 50, 70, 1.0);
  final Color _defaultStrokeColor = Color.fromRGBO(40, 50, 70, 1.0);

  /*
  final Color _backgroundCountryColor = Color.fromRGBO(0, 0, 0, 1.0);
  final Color _selectedCountryColor = Color.fromRGBO(54, 93, 163, 1.0);
  final Color _friendsVisitedCountryColor = Color.fromRGBO(84, 184, 133, 1.0);
  final Color _myVisitedCountryColor = Color.fromRGBO(184, 67, 75, 1.0);
  final Color _defaultCountryColor = Color.fromRGBO(40, 40, 40, 1.0);
  final Color _selectedStrokeColor = Color.fromRGBO(54, 93, 163, 1.0);
  final Color _defaultStrokeColor = Color.fromRGBO(40, 50, 70, 1.0);
   */

  @override
  void initState() {

    //{ "type": "Feature", "properties": { "admin": "AlbatrUS", "name": "AlbatrUS", "continent": "AlbatrUS" }, "geometry": { "type": "Polygon", "coordinates": [[[-90, 90], [90, 90], [90, -90], [-90, -90]]] }},

    _data = <MyModel>[
      MyModel("AlbatrUS", _backgroundCountryColor, "AlbatrUS", "AlbatrUS" ),
      MyModel("Afghanistan", _defaultCountryColor, "Afghanistan", "Asia" ),
      MyModel("Angola", _defaultCountryColor, "Angola", "Africa" ),
      MyModel("Albania", _defaultCountryColor, "Albania", "Europe" ),
      MyModel("United Arab Emirates", _defaultCountryColor, "United Arab Emirates", "Asia" ),
      MyModel("Argentina", _defaultCountryColor, "Argentina", "South America" ),
      MyModel("Armenia", _defaultCountryColor, "Armenia", "Asia" ),
      MyModel("Australia", _defaultCountryColor, "Australia", "Australia" ),
      MyModel("Austria", _defaultCountryColor, "Austria", "Europe" ),
      MyModel("Azerbaijan", _defaultCountryColor, "Azerbaijan", "Asia" ),
      MyModel("Burundi", _defaultCountryColor, "Burundi", "Africa" ),
      MyModel("Belgium", _defaultCountryColor, "Belgium", "Europe" ),
      MyModel("Benin", _defaultCountryColor, "Benin", "Africa" ),
      MyModel("Burkina Faso", _defaultCountryColor, "Burkina Faso", "Africa" ),
      MyModel("Bangladesh", _defaultCountryColor, "Bangladesh", "Asia" ),
      MyModel("Bulgaria", _defaultCountryColor, "Bulgaria", "Europe" ),
      MyModel("The Bahamas", _defaultCountryColor, "Bahamas", "North America" ),
      MyModel("Bosnia and Herzegovina", _defaultCountryColor, "Bosnia and Herz.", "Europe" ),
      MyModel("Belarus", _defaultCountryColor, "Belarus", "Europe" ),
      MyModel("Belize", _defaultCountryColor, "Belize", "North America" ),
      MyModel("Bolivia", _defaultCountryColor, "Bolivia", "South America" ),
      MyModel("Brazil", _defaultCountryColor, "Brazil", "South America" ),
      MyModel("Brunei", _defaultCountryColor, "Brunei", "Asia" ),
      MyModel("Bhutan", _defaultCountryColor, "Bhutan", "Asia" ),
      MyModel("Botswana", _defaultCountryColor, "Botswana", "Africa" ),
      MyModel("Central African Republic", _defaultCountryColor, "Central African Rep.", "Africa" ),
      MyModel("Canada", _defaultCountryColor, "Canada", "North America" ),
      MyModel("Switzerland", _defaultCountryColor, "Switzerland", "Europe" ),
      MyModel("Chile", _defaultCountryColor, "Chile", "South America" ),
      MyModel("China", _defaultCountryColor, "China", "Asia" ),
      MyModel("Ivory Coast", _defaultCountryColor, "Côte d'Ivoire", "Africa" ),
      MyModel("Cameroon", _defaultCountryColor, "Cameroon", "Africa" ),
      MyModel("Democratic Republic of the Congo", _defaultCountryColor, "Dem. Rep. Congo", "Africa" ),
      MyModel("Republic of Congo", _defaultCountryColor, "Congo", "Africa" ),
      MyModel("Colombia", _defaultCountryColor, "Colombia", "South America" ),
      MyModel("Costa Rica", _defaultCountryColor, "Costa Rica", "North America" ),
      MyModel("Cuba", _defaultCountryColor, "Cuba", "North America" ),
      MyModel("Northern Cyprus", _defaultCountryColor, "N. Cyprus", "Asia" ),
      MyModel("Cyprus", _defaultCountryColor, "Cyprus", "Asia" ),
      MyModel("Czech Republic", _defaultCountryColor, "Czech Rep.", "Europe" ),
      MyModel("Germany", _defaultCountryColor, "Germany", "Europe" ),
      MyModel("Djibouti", _defaultCountryColor, "Djibouti", "Africa" ),
      MyModel("Denmark", _defaultCountryColor, "Denmark", "Europe" ),
      MyModel("Dominican Republic", _defaultCountryColor, "Dominican Rep.", "North America" ),
      MyModel("Algeria", _defaultCountryColor, "Algeria", "Africa" ),
      MyModel("Ecuador", _defaultCountryColor, "Ecuador", "South America" ),
      MyModel("Egypt", _defaultCountryColor, "Egypt", "Africa" ),
      MyModel("Eritrea", _defaultCountryColor, "Eritrea", "Africa" ),
      MyModel("Spain", _defaultCountryColor, "Spain", "Europe" ),
      MyModel("Estonia", _defaultCountryColor, "Estonia", "Europe" ),
      MyModel("Ethiopia", _defaultCountryColor, "Ethiopia", "Africa" ),
      MyModel("Finland", _defaultCountryColor, "Finland", "Europe" ),
      MyModel("Fiji", _defaultCountryColor, "Fiji", "Australia" ),
      MyModel("Falkland Islands", _defaultCountryColor, "Falkland Is.", "South America" ),
      MyModel("France", _defaultCountryColor, "France", "Europe" ),
      MyModel("Gabon", _defaultCountryColor, "Gabon", "Africa" ),
      MyModel("United Kingdom", _defaultCountryColor, "United Kingdom", "Europe" ),
      MyModel("Georgia", _defaultCountryColor, "Georgia", "Asia" ),
      MyModel("Ghana", _defaultCountryColor, "Ghana", "Africa" ),
      MyModel("Guinea", _defaultCountryColor, "Guinea", "Africa" ),
      MyModel("Gambia", _defaultCountryColor, "Gambia", "Africa" ),
      MyModel("Guinea Bissau", _defaultCountryColor, "Guinea-Bissau", "Africa" ),
      MyModel("Equatorial Guinea", _defaultCountryColor, "Eq. Guinea", "Africa" ),
      MyModel("Greece", _defaultCountryColor, "Greece", "Europe" ),
      MyModel("Greenland", _defaultCountryColor, "Greenland", "North America" ),
      MyModel("Guatemala", _defaultCountryColor, "Guatemala", "North America" ),
      MyModel("Guyana", _defaultCountryColor, "Guyana", "South America" ),
      MyModel("Honduras", _defaultCountryColor, "Honduras", "North America" ),
      MyModel("Croatia", _defaultCountryColor, "Croatia", "Europe" ),
      MyModel("Haiti", _defaultCountryColor, "Haiti", "North America" ),
      MyModel("Hungary", _defaultCountryColor, "Hungary", "Europe" ),
      MyModel("Indonesia", _defaultCountryColor, "Indonesia", "Asia" ),
      MyModel("India", _defaultCountryColor, "India", "Asia" ),
      MyModel("Ireland", _defaultCountryColor, "Ireland", "Europe" ),
      MyModel("Iran", _defaultCountryColor, "Iran", "Asia" ),
      MyModel("Iraq", _defaultCountryColor, "Iraq", "Asia" ),
      MyModel("Iceland", _defaultCountryColor, "Iceland", "Europe" ),
      MyModel("Israel", _defaultCountryColor, "Israel", "Asia" ),
      MyModel("Italy", _defaultCountryColor, "Italy", "Europe" ),
      MyModel("Jamaica", _defaultCountryColor, "Jamaica", "North America" ),
      MyModel("Jordan", _defaultCountryColor, "Jordan", "Asia" ),
      MyModel("Japan", _defaultCountryColor, "Japan", "Asia" ),
      MyModel("Kazakhstan", _defaultCountryColor, "Kazakhstan", "Asia" ),
      MyModel("Kenya", _defaultCountryColor, "Kenya", "Africa" ),
      MyModel("Kyrgyzstan", _defaultCountryColor, "Kyrgyzstan", "Asia" ),
      MyModel("Cambodia", _defaultCountryColor, "Cambodia", "Asia" ),
      MyModel("South Korea", _defaultCountryColor, "Korea", "Asia" ),
      MyModel("Kosovo", _defaultCountryColor, "Kosovo", "Europe" ),
      MyModel("Kuwait", _defaultCountryColor, "Kuwait", "Asia" ),
      MyModel("Laos", _defaultCountryColor, "Lao PDR", "Asia" ),
      MyModel("Lebanon", _defaultCountryColor, "Lebanon", "Asia" ),
      MyModel("Liberia", _defaultCountryColor, "Liberia", "Africa" ),
      MyModel("Libya", _defaultCountryColor, "Libya", "Africa" ),
      MyModel("Sri Lanka", _defaultCountryColor, "Sri Lanka", "Asia" ),
      MyModel("Lesotho", _defaultCountryColor, "Lesotho", "Africa" ),
      MyModel("Lithuania", _defaultCountryColor, "Lithuania", "Europe" ),
      MyModel("Luxembourg", _defaultCountryColor, "Luxembourg", "Europe" ),
      MyModel("Latvia", _defaultCountryColor, "Latvia", "Europe" ),
      MyModel("Morocco", _defaultCountryColor, "Morocco", "Africa" ),
      MyModel("Moldova", _defaultCountryColor, "Moldova", "Europe" ),
      MyModel("Madagascar", _defaultCountryColor, "Madagascar", "Africa" ),
      MyModel("Mexico", _defaultCountryColor, "Mexico", "North America" ),
      MyModel("Macedonia", _defaultCountryColor, "Macedonia", "Europe" ),
      MyModel("Mali", _defaultCountryColor, "Mali", "Africa" ),
      MyModel("Myanmar", _defaultCountryColor, "Myanmar", "Asia" ),
      MyModel("Montenegro", _defaultCountryColor, "Montenegro", "Europe" ),
      MyModel("Mongolia", _defaultCountryColor, "Mongolia", "Asia" ),
      MyModel("Mozambique", _defaultCountryColor, "Mozambique", "Africa" ),
      MyModel("Mauritania", _defaultCountryColor, "Mauritania", "Africa" ),
      MyModel("Malawi", _defaultCountryColor, "Malawi", "Africa" ),
      MyModel("Malaysia", _defaultCountryColor, "Malaysia", "Asia" ),
      MyModel("Namibia", _defaultCountryColor, "Namibia", "Africa" ),
      MyModel("New Caledonia", _defaultCountryColor, "New Caledonia", "Australia" ),
      MyModel("Niger", _defaultCountryColor, "Niger", "Africa" ),
      MyModel("Nigeria", _defaultCountryColor, "Nigeria", "Africa" ),
      MyModel("Nicaragua", _defaultCountryColor, "Nicaragua", "North America" ),
      MyModel("Netherlands", _defaultCountryColor, "Netherlands", "Europe" ),
      MyModel("Norway", _defaultCountryColor, "Norway", "Europe" ),
      MyModel("Nepal", _defaultCountryColor, "Nepal", "Asia" ),
      MyModel("New Zealand", _defaultCountryColor, "New Zealand", "Australia" ),
      MyModel("Oman", _defaultCountryColor, "Oman", "Asia" ),
      MyModel("Pakistan", _defaultCountryColor, "Pakistan", "Asia" ),
      MyModel("Panama", _defaultCountryColor, "Panama", "North America" ),
      MyModel("Peru", _defaultCountryColor, "Peru", "South America" ),
      MyModel("Philippines", _defaultCountryColor, "Philippines", "Asia" ),
      MyModel("Papua New Guinea", _defaultCountryColor, "Papua New Guinea", "Australia" ),
      MyModel("Poland", _defaultCountryColor, "Poland", "Europe" ),
      MyModel("Puerto Rico", _defaultCountryColor, "Puerto Rico", "North America" ),
      MyModel("North Korea", _defaultCountryColor, "Dem. Rep. Korea", "Asia" ),
      MyModel("Portugal", _defaultCountryColor, "Portugal", "Europe" ),
      MyModel("Paraguay", _defaultCountryColor, "Paraguay", "South America" ),
      MyModel("Palestine", _defaultCountryColor, "Palestine", "Asia" ),
      MyModel("Qatar", _defaultCountryColor, "Qatar", "Asia" ),
      MyModel("Romania", _defaultCountryColor, "Romania", "Europe" ),
      MyModel("Russia", _defaultCountryColor, "Russia", "Asia" ),
      MyModel("Rwanda", _defaultCountryColor, "Rwanda", "Africa" ),
      MyModel("Western Sahara", _defaultCountryColor, "W. Sahara", "Africa" ),
      MyModel("Saudi Arabia", _defaultCountryColor, "Saudi Arabia", "Asia" ),
      MyModel("Sudan", _defaultCountryColor, "Sudan", "Africa" ),
      MyModel("South Sudan", _defaultCountryColor, "S. Sudan", "Africa" ),
      MyModel("Senegal", _defaultCountryColor, "Senegal", "Africa" ),
      MyModel("Solomon Islands", _defaultCountryColor, "Solomon Is.", "Australia" ),
      MyModel("Sierra Leone", _defaultCountryColor, "Sierra Leone", "Africa" ),
      MyModel("El Salvador", _defaultCountryColor, "El Salvador", "North America" ),
      MyModel("Somaliland", _defaultCountryColor, "Somaliland", "Africa" ),
      MyModel("Somalia", _defaultCountryColor, "Somalia", "Africa" ),
      MyModel("Republic of Serbia", _defaultCountryColor, "Serbia", "Europe" ),
      MyModel("Suriname", _defaultCountryColor, "Suriname", "South America" ),
      MyModel("Slovakia", _defaultCountryColor, "Slovakia", "Europe" ),
      MyModel("Slovenia", _defaultCountryColor, "Slovenia", "Europe" ),
      MyModel("Sweden", _defaultCountryColor, "Sweden", "Europe" ),
      MyModel("Swaziland", _defaultCountryColor, "Swaziland", "Africa" ),
      MyModel("Syria", _defaultCountryColor, "Syria", "Asia" ),
      MyModel("Chad", _defaultCountryColor, "Chad", "Africa" ),
      MyModel("Togo", _defaultCountryColor, "Togo", "Africa" ),
      MyModel("Thailand", _defaultCountryColor, "Thailand", "Asia" ),
      MyModel("Tajikistan", _defaultCountryColor, "Tajikistan", "Asia" ),
      MyModel("Turkmenistan", _defaultCountryColor, "Turkmenistan", "Asia" ),
      MyModel("East Timor", _defaultCountryColor, "Timor-Leste", "Asia" ),
      MyModel("Trinidad and Tobago", _defaultCountryColor, "Trinidad and Tobago", "North America" ),
      MyModel("Tunisia", _defaultCountryColor, "Tunisia", "Africa" ),
      MyModel("Turkey", _defaultCountryColor, "Turkey", "Asia" ),
      MyModel("Taiwan", _defaultCountryColor, "Taiwan", "Asia" ),
      MyModel("United Republic of Tanzania", _defaultCountryColor, "Tanzania", "Africa" ),
      MyModel("Uganda", _defaultCountryColor, "Uganda", "Africa" ),
      MyModel("Ukraine", _defaultCountryColor, "Ukraine", "Europe" ),
      MyModel("Uruguay", _defaultCountryColor, "Uruguay", "South America" ),
      MyModel("United States of America", _defaultCountryColor, "United States of America", "North America" ),
      MyModel("Uzbekistan", _defaultCountryColor, "Uzbekistan", "Asia" ),
      MyModel("Venezuela", _defaultCountryColor, "Venezuela", "South America" ),
      MyModel("Vietnam", _defaultCountryColor, "Vietnam", "Asia" ),
      MyModel("Vanuatu", _defaultCountryColor, "Vanuatu", "Australia" ),
      MyModel("Yemen", _defaultCountryColor, "Yemen", "Asia" ),
      MyModel("South Africa", _defaultCountryColor, "South Africa", "Africa" ),
      MyModel("Zambia", _defaultCountryColor, "Zambia", "Africa" ),
      MyModel("Zimbabwe", _defaultCountryColor, "Zimbabwe", "Africa" ),
    ];

    _countriesFromMap = ["AlbatrUS", "Afghanistan", "Angola", "Albania", "United Arab Emirates", "Argentina", "Armenia", "Australia", "Austria", "Azerbaijan", "Burundi", "Belgium", "Benin", "Burkina Faso", "Bangladesh", "Bulgaria", "Bahamas", "Bosnia and Herz.", "Belarus", "Belize", "Bolivia", "Brazil", "Brunei", "Bhutan", "Botswana", "Central African Rep.", "Canada", "Switzerland", "Chile", "China", "Côte d'Ivoire", "Cameroon", "Dem. Rep. Congo", "Congo", "Colombia", "Costa Rica", "Cuba", "N. Cyprus", "Cyprus", "Czech Rep.", "Germany", "Djibouti", "Denmark", "Dominican Rep.", "Algeria", "Ecuador", "Egypt", "Eritrea", "Spain", "Estonia", "Ethiopia", "Finland", "Fiji", "Falkland Is.", "France", "Gabon", "United Kingdom", "Georgia", "Ghana", "Guinea", "Gambia", "Guinea-Bissau", "Eq. Guinea", "Greece", "Greenland", "Guatemala", "Guyana", "Honduras", "Croatia", "Haiti", "Hungary", "Indonesia", "India", "Ireland", "Iran", "Iraq", "Iceland", "Israel", "Italy", "Jamaica", "Jordan", "Japan", "Kazakhstan", "Kenya", "Kyrgyzstan", "Cambodia", "Korea", "Kosovo", "Kuwait", "Lao PDR", "Lebanon", "Liberia", "Libya", "Sri Lanka", "Lesotho", "Lithuania", "Luxembourg", "Latvia", "Morocco", "Moldova", "Madagascar", "Mexico", "Macedonia", "Mali", "Myanmar", "Montenegro", "Mongolia", "Mozambique", "Mauritania", "Malawi", "Malaysia", "Namibia", "New Caledonia", "Niger", "Nigeria", "Nicaragua", "Netherlands", "Norway", "Nepal", "New Zealand", "Oman", "Pakistan", "Panama", "Peru", "Philippines", "Papua New Guinea", "Poland", "Puerto Rico", "Dem. Rep. Korea", "Portugal", "Paraguay", "Palestine", "Qatar", "Romania", "Russia", "Rwanda", "W. Sahara", "Saudi Arabia", "Sudan", "S. Sudan", "Senegal", "Solomon Is.", "Sierra Leone", "El Salvador", "Somaliland", "Somalia", "Serbia", "Suriname", "Slovakia", "Slovenia", "Sweden", "Swaziland", "Syria", "Chad", "Togo", "Thailand", "Tajikistan", "Turkmenistan", "Timor-Leste", "Trinidad and Tobago", "Tunisia", "Turkey", "Taiwan", "Tanzania", "Uganda", "Ukraine", "Uruguay", "United States of America", "Uzbekistan", "Venezuela", "Vietnam", "Vanuatu", "Yemen", "South Africa", "Zambia", "Zimbabwe"];

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
          content: Text('To jest okienko, które wyskakuje na początku aplikacji.'),
          actions: [
            TextButton(
              onPressed: () {
                refreshMap();
                Navigator.of(context,rootNavigator: true).pop();
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
                    strokeWidth: 1, //TO DO
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
                                    refreshMap();
                                    Navigator.of(context).pop();
                                    print("ALE ODSWIERZYLEM MAPE!");
                                  },
                                  child: Text('WYPIERDALAJ'),
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
            ),
            /*Container(
              height: entranceSnackbar(),
            )*/
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
      primaryValueMapper: (int index) => _data[index].name, //this is needed to connect models to places on map - DONT CHANGE!
      dataLabelMapper: (int index) => _data[index].blank, //this is shown as a name of country
      shapeColorValueMapper: (int index) => _data[index].color,
      //shapeColorValueMapper: (int index) => myYellow,
    );

    _zoomPanBehavior = MapZoomPanBehavior(enableDoubleTapZooming: false, minZoomLevel: 1, maxZoomLevel: 50)
      ..zoomLevel = 4
      ..focalLatLng = MapLatLng(19.0759837, 72.8776559)
      ..toolbarSettings = MapToolbarSettings();
  }

  void refreshMap() {
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
  }

  Future<void> getTrips() async {
    _trips = await DatabaseService.fetchTrips();
    print(_trips);
    List<String> _countrylist = _trips.map((trip) => trip.country).toList();
    print(_countrylist);

    Set<String> _countrySet = _countrylist.toSet();
    print(_countrySet);


    for (int i = 0; i < _countriesFromMap.length; i++) {
      if (_countrySet.contains(_countriesFromMap[i])) {
        _data[i].color = _friendsVisitedCountryColor;
        print("Koloruje na czerwono: ${i}");
      }
    }

    setState(() {
      temp = temp + 1;
    });
  }

  int funWithSelectedCountries() {
    print("i'm in funWithSelectedCountries");
    int ret = 0;
    if (_newCountryClickedIndex == 0) {
      _snackTime = false;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ret = -1;
    }
    else{
      if (_snackTime == false) {
        _snackTime = true;
        _snackBar = createSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(_snackBar);
        ret = _newCountryClickedIndex;
      }
      else{
        if(_newCountryClickedIndex != _oldCountryClickedIndex){
          _snackBar = createSnackBar();
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(_snackBar);
          ret = _newCountryClickedIndex;
        }
        else{
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

  SnackBar createSnackBar() {
    SnackBar _tempSnackBar = SnackBar(
      content: Column(
        children: [
          Text(_data[_newCountryClickedIndex].name),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                    onPressed: (){
                      print("open site of country ${_newCountryClickedIndex}");
                    },
                    child: Text("open",style: const TextStyle(
                      color: Colors.green,
                    ),)
                ),
              ),
              Expanded(
                child: ElevatedButton(
                    onPressed: (){
                      print("blue ${_newCountryClickedIndex}");
                      _data[_newCountryClickedIndex].color = _myVisitedCountryColor;
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
                      print("yellow ${_newCountryClickedIndex}");
                      if(_data[_newCountryClickedIndex].color == Colors.black) {print("tak");}
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