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

  @override
  void initState() {
    _data = const <Model>[
      Model('New South Wales', Color.fromRGBO(255, 215, 0, 1.0),
          'New South Wales'),
      Model('Queensland', Color.fromRGBO(72, 209, 204, 1.0), 'Queensland'),
      Model('Northern Territory', Color.fromRGBO(255, 78, 66, 1.0),
          'Northern\nTerritory'),
      Model('Victoria', Color.fromRGBO(171, 56, 224, 0.75), 'Victoria'),
      Model('South Australia', Color.fromRGBO(126, 247, 74, 0.75),
          'South Australia'),
      Model('Western Australia', Color.fromRGBO(79, 60, 201, 0.7),
          'Western Australia'),
      Model('Tasmania', Color.fromRGBO(99, 164, 230, 1), 'Tasmania'),
      Model('Australian Capital Territory', Colors.teal, 'ACT')
    ];

    _mapSource = MapShapeSource.asset(
      'assets/australia.json',
      shapeDataField: 'STATE_NAME',
      //shapeDataField: 'continent',
      dataCount: _data.length,
      primaryValueMapper: (int index) => _data[index].state,
      dataLabelMapper: (int index) => _data[index].stateCode,
      shapeColorValueMapper: (int index) => _data[index].color,
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
                      _data[index].stateCode,
                      style: const TextStyle(color: Colors.white),
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
                dataLabelSettings: MapDataLabelSettings(
                  textStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize:
                      Theme.of(context).textTheme.bodySmall!.fontSize),
                ),
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
  const Model(this.state, this.color, this.stateCode);

  /// Represents the Australia state name.
  final String state;

  /// Represents the Australia state color.
  final Color color;

  /// Represents the Australia state code.
  final String stateCode;
}