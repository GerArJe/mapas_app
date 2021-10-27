import 'package:flutter/material.dart';

import 'package:mapas_app/helpers/helpers.dart';
import 'package:mapas_app/pages/mapa_page.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: this.checkGpsYLocation(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          );
        },
      ),
    );
  }

  Future checkGpsYLocation(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 1000));

    Navigator.pushReplacement(context, navegarMapaFadeIn(context, MapaPage()));
  }
}
