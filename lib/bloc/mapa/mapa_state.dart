part of 'mapa_bloc.dart';

@immutable
class MapaState {
  final bool mapaListo;
  final bool dibujarRecorrido;
  final bool seguirUbicacion;

  // Polyline
  final Map<String, Polyline> polylines;

  MapaState(
      {this.mapaListo = false,
      this.dibujarRecorrido = true,
      this.seguirUbicacion = false,
      Map<String, Polyline>? polylines})
      : this.polylines = polylines ?? new Map();

  MapaState copyWith(
          {bool? mapaListo,
          bool? dibujarRecorrido,
          bool? seguirUbicacion,
          Map<String, Polyline>? polylines}) =>
      MapaState(
        mapaListo: mapaListo ?? this.mapaListo,
        dibujarRecorrido: dibujarRecorrido ?? this.dibujarRecorrido,
        seguirUbicacion: seguirUbicacion ?? this.seguirUbicacion,
        polylines: polylines ?? this.polylines,
      );
}
