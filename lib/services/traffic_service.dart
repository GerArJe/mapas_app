import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

import 'package:mapas_app/models/driving_response.dart';
import 'package:mapas_app/models/search_response.dart';

class TrafficService {
  TrafficService._privateContructor();
  static final TrafficService _intance = TrafficService._privateContructor();

  factory TrafficService() {
    return _intance;
  }

  final _dio = Dio();
  final _baseUrlDir = 'https://api.mapbox.com/directions/v5';
  final _baseUrlGeo = 'https://api.mapbox.com/geocoding/v5';
  final _apiKey =
      'pk.eyJ1IjoiZ2FyZXZhbG8iLCJhIjoiY2t2Y2R6M2Z6M2t2bjMybXN1bWM0eTU0eSJ9.xXF2imub5Y29QiSrM9Th7Q';

  Future<DrivingResponse> getCoordsInicioYFin(
      LatLng inicio, LatLng destino) async {
    final coordString =
        '${inicio.longitude},${inicio.latitude};${destino.longitude},${destino.latitude}';
    final url = '${_baseUrlDir}/mapbox/driving/$coordString?';

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

  Future<SearchResponse> getResultadosPorQuery(
      String busqueda, LatLng proximidad) async {
    final url = '${_baseUrlGeo}/mapbox.places/$busqueda.json?';

    try {
      final resp = await _dio.get(url, queryParameters: {
        'proximity': '${proximidad.longitude},${proximidad.latitude}',
        'language': 'es',
        'autocomplete': true,
        'access_token': _apiKey,
      });

      final searchResponse = searchResponseFromJson(resp.data);
      return searchResponse;
    } catch (e) {
      return SearchResponse(features: []);
    }
  }
}
