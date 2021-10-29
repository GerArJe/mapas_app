import 'package:flutter/material.dart';

import 'package:mapas_app/models/search_result.dart';

class SearchDestination extends SearchDelegate<SearchResult> {
  @override
  final String searchFieldLabel;

  SearchDestination() : this.searchFieldLabel = 'Buscar...';

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
    return Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
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
  }
}
