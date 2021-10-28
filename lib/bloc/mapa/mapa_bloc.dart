import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

import 'package:mapas_app/themes/uber_map_theme.dart';

part 'mapa_event.dart';
part 'mapa_state.dart';

class MapaBloc extends Bloc<MapaEvent, MapaState> {
  GoogleMapController? _mapController;

  MapaBloc() : super(MapaState()) {
    on<OnMapalisto>((event, emit) {
      emit(state.copyWith(mapaListo: true));
    });
  }

  void initMapa(GoogleMapController controller) {
    if (!state.mapaListo) {
      _mapController = controller;
      _mapController?.setMapStyle(jsonEncode(uberMapTheme));
      add(OnMapalisto());
    }
  }

  void moverCamara(LatLng destino) {
    final cameraUpdate = CameraUpdate.newLatLng(destino);
    _mapController?.animateCamera(cameraUpdate);
  }
}
