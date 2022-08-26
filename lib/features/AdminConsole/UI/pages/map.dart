import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Map extends StatefulWidget {
  double lang, long;
  Map({Key? key, required this.lang, required this.long}) : super(key: key);

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  @override
  Widget build(BuildContext context) {
    var marker = <Marker>[
      Marker(
          point: LatLng(widget.lang, widget.long),
          builder: (ctx) => const Icon(
                Icons.pin_drop,
                color: Colors.red,
              ))
    ];

    return FlutterMap(
      options: MapOptions(center: LatLng(widget.lang, widget.long), zoom: 10),
      layers: [
        TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            // userAgentPackageName: 'com.example.app',
            subdomains: ['a', 'b', 'c']),
        MarkerLayerOptions(markers: marker)
      ],
    );
  }
}
