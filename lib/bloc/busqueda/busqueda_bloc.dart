import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:mapas_app/models/search_result.dart';

part 'busqueda_event.dart';
part 'busqueda_state.dart';

class BusquedaBloc extends Bloc<BusquedaEvent, BusquedaState> {
  BusquedaBloc() : super(BusquedaState()) {
    on<OnActivarMarcadorManual>((event, emit) {
      emit(state.copyWith(seleccionManual: true));
    });
    on<OnDesactivarMarcadorManual>((event, emit) {
      emit(state.copyWith(seleccionManual: false));
    });
    on<OnAgregarHistorial>((event, emit) {
      final existe = state.historial.where(
          (result) => result.nombreDestino == event.result.nombreDestino);

      if (existe == 0) {
        final newHistorial = [...state.historial, event.result];
        emit(state.copyWith(historial: newHistorial));
      }
    });
  }
}
