part of 'mapa_bloc.dart';

@immutable
abstract class MapaEvent {}

class OnMapalisto extends MapaEvent {}

class OnNuevaUbicacion extends MapaEvent {
  final LatLng ubicacion;

  OnNuevaUbicacion(this.ubicacion);
}
