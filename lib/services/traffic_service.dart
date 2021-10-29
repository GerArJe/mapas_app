import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrafficService {
  TrafficService._privateContructor();
  static final TrafficService _intance = TrafficService._privateContructor();

  factory TrafficService() {
    return _intance;
  }

  final _dio = Dio();

  Future getCoordsInicioYFin(LatLng inicio, LatLng destino) async {
    print('inicio: ${inicio}');
    print('destino: ${destino}');
  }
}
