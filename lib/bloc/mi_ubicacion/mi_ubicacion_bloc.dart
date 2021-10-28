import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:meta/meta.dart';

part 'mi_ubicacion_event.dart';
part 'mi_ubicacion_state.dart';

class MiUbicacionBloc extends Bloc<MiUbicacionEvent, MiUbicacionState> {
  StreamSubscription<Position>? _positionSubscription;

  MiUbicacionBloc() : super(MiUbicacionState()) {
    on<OnUbicacionCambio>((event, emit) {
      print(event);
      emit(MiUbicacionState(
        existeUbicacion: true,
        ubicacion: event.ubicacion,
      ));
    });
  }

  void iniciarSeguimiento() {
    _positionSubscription = Geolocator.getPositionStream(
      desiredAccuracy: LocationAccuracy.high,
      distanceFilter: 10,
    ).listen((Position position) {
      final nuevaUbicacion = LatLng(position.latitude, position.longitude);
      add(OnUbicacionCambio(nuevaUbicacion));
    });
  }

  void cancelarSeguimiento() {
    _positionSubscription?.cancel();
  }
}
