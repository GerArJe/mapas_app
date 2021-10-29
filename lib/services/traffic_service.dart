import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:mapas_app/models/driving_response.dart';

class TrafficService {
  TrafficService._privateContructor();
  static final TrafficService _intance = TrafficService._privateContructor();

  factory TrafficService() {
    return _intance;
  }

  final _dio = Dio();
  final _baseUrl = 'https://api.mapbox.com/directions/v5';
  final _apiKey =
      'pk.eyJ1IjoiZ2FyZXZhbG8iLCJhIjoiY2t2Y2R6M2Z6M2t2bjMybXN1bWM0eTU0eSJ9.xXF2imub5Y29QiSrM9Th7Q';

  Future<DrivingResponse> getCoordsInicioYFin(
      LatLng inicio, LatLng destino) async {
    final coordString =
        '${inicio.longitude},${inicio.latitude};${destino.longitude},${destino.latitude}';
    final url = '${_baseUrl}/mapbox/driving/$coordString?';

    final resp = await _dio.get(url, queryParameters: {
      'alternatives': true,
      'geometries': 'polyline6',
      'steps': false,
      'access_token': _apiKey,
      'language': 'es',
    });

    final data = DrivingResponse.fromJson(resp.data);

    return data;
  }
}
