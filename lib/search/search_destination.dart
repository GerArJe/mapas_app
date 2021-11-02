import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

import 'package:mapas_app/models/search_result.dart';
import 'package:mapas_app/services/traffic_service.dart';
import 'package:mapas_app/models/search_response.dart';

class SearchDestination extends SearchDelegate<SearchResult> {
  @override
  final String searchFieldLabel;
  final TrafficService _trafficService;
  final LatLng proximidad;

  SearchDestination(this.proximidad)
      : searchFieldLabel = 'Buscar...',
        _trafficService = TrafficService();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => this.query = '',
        icon: Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => this.close(context, SearchResult(cancelo: true)),
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return _contruirResultadosSugerencias();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.length == 0) {
      return ListView(
        children: [
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text('colocar ubicación manualmente'),
            onTap: () {
              this.close(context, SearchResult(cancelo: false, manual: true));
            },
          ),
        ],
      );
    } else {
      return _contruirResultadosSugerencias();
    }
  }

  Widget _contruirResultadosSugerencias() {
    if (query == 0) {
      return Container();
    }
    _trafficService.getSugerenciasPorQuery(query.trim(), proximidad);
    // query.trim(), proximidad
    return StreamBuilder(
      stream: _trafficService.sugerenciasStream,
      builder: (BuildContext context, AsyncSnapshot<SearchResponse> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final lugares = snapshot.data!.features;

        if (lugares!.length == 0) {
          return ListTile(
            title: Text('No hay resultado con $query'),
          );
        }

        return ListView.separated(
          separatorBuilder: (_, i) => Divider(),
          itemCount: lugares.length,
          itemBuilder: (_, i) {
            final lugar = lugares[i];
            return ListTile(
              leading: Icon(Icons.place),
              title: Text(lugar.textEs),
              subtitle: Text(lugar.placeNameEs),
              onTap: () {
                print(lugar);
              },
            );
          },
        );
      },
    );
  }
}
