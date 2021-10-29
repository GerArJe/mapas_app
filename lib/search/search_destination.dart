import 'package:flutter/material.dart';

class SearchDestination extends SearchDelegate {
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
        onPressed: () => this.close(context, null),
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
            print('Manuelamente');
            this.close(context, null);
          },
        ),
      ],
    );
  }
}
