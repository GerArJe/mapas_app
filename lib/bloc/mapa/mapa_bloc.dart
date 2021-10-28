import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

import 'package:mapas_app/themes/uber_map_theme.dart';

part 'mapa_event.dart';
part 'mapa_state.dart';

class MapaBloc extends Bloc<MapaEvent, MapaState> {
  // Controlardor del mapa
  GoogleMapController? _mapController;

  // Polylines
  Polyline _miRuta = Polyline(
    polylineId: PolylineId('mi_ruta'),
    width: 4,
    color: Colors.transparent,
  );

  MapaBloc() : super(MapaState()) {
    on<OnMapalisto>((event, emit) {
      emit(state.copyWith(mapaListo: true));
    });

    on<OnNuevaUbicacion>((event, emit) {
      emit(_onNuevaUbicacion(event));
    });

    on<OnMarcarRecorrido>((event, emit) {
      emit(_onMarcarRecorrido(event));
    });

    on<OnSeguirUbicacion>((event, emit) {
      emit(_onSeguirUbicacion(event));
    });

    on<OnMovioMapa>((event, emit) {
      emit(_onMovioMapa(event));
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

  MapaState _onNuevaUbicacion(OnNuevaUbicacion event) {
    if (state.seguirUbicacion) {
      moverCamara(event.ubicacion);
    }
    List<LatLng> points = [..._miRuta.points, event.ubicacion];
    _miRuta = _miRuta.copyWith(pointsParam: points);
    final currenPolylines = state.polylines;
    currenPolylines['mi_ruta'] = _miRuta;
    return state.copyWith(polylines: currenPolylines);
  }

  MapaState _onMarcarRecorrido(OnMarcarRecorrido event) {
    if (!state.dibujarRecorrido) {
      _miRuta = _miRuta.copyWith(colorParam: Colors.black87);
    } else {
      _miRuta = _miRuta.copyWith(colorParam: Colors.transparent);
    }
    final currenPolylines = state.polylines;
    currenPolylines['mi_ruta'] = _miRuta;
    return state.copyWith(
        polylines: currenPolylines, dibujarRecorrido: !state.dibujarRecorrido);
  }

  MapaState _onSeguirUbicacion(OnSeguirUbicacion event) {
    if (!state.seguirUbicacion) {
      moverCamara(_miRuta.points[_miRuta.points.length - 1]);
    }
    return state.copyWith(seguirUbicacion: !state.seguirUbicacion);
  }

  MapaState _onMovioMapa(OnMovioMapa event) {
    return state.copyWith(ubicacionCentral: event.centroMapa);
  }
}
