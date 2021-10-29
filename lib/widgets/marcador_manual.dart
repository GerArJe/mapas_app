part of 'widgets.dart';

class MarcadorManual extends StatelessWidget {
  const MarcadorManual({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (context, state) {
        if (state.seleccionManual) {
          return _BuildMarcadorManual();
        } else {
          return Container();
        }
      },
    );
  }
}

class _BuildMarcadorManual extends StatelessWidget {
  const _BuildMarcadorManual({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        // Boton regresar
        Positioned(
          top: 70,
          left: 20,
          child: FadeInLeft(
            duration: Duration(milliseconds: 150),
            child: CircleAvatar(
              maxRadius: 25,
              backgroundColor: Colors.white,
              child: IconButton(
                onPressed: () {
                  BlocProvider.of<BusquedaBloc>(context)
                      .add(OnDesactivarMarcadorManual());
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ),
        Center(
          child: Transform.translate(
              offset: Offset(0, -12),
              child: BounceInDown(
                from: 200,
                child: Icon(
                  Icons.location_on,
                  size: 50,
                ),
              )),
        ),

        // Boton confirmar destino
        Positioned(
          bottom: 70,
          left: 40,
          child: FadeIn(
            child: MaterialButton(
                minWidth: width - 120,
                child: Text(
                  'Confirmar destino',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.black,
                shape: StadiumBorder(),
                elevation: 0,
                splashColor: Colors.transparent,
                onPressed: () {
                  calcularDestino(context);
                }),
          ),
        ),
      ],
    );
  }

  void calcularDestino(BuildContext context) async {
    final trafficService = TrafficService();
    final mapaBloc = BlocProvider.of<MapaBloc>(context);

    final inicio = BlocProvider.of<MiUbicacionBloc>(context).state.ubicacion;
    final destino = mapaBloc.state.ubicacionCentral;

    if (inicio != null && destino != null) {
      final trafficResponse =
          await trafficService.getCoordsInicioYFin(inicio, destino);

      // Decodificar los puntos del geometry
      final geometry = trafficResponse.routes[0].geometry;
      final duracion = trafficResponse.routes[0].duration;
      final distancia = trafficResponse.routes[0].distance;

      final points = Poly.Polyline.Decode(encodedString: geometry, precision: 6)
          .decodedCoords;

      final List<LatLng> rutaCoordenadas =
          points.map((point) => LatLng(point[0], point[1])).toList();

      mapaBloc
          .add(OnCrearRutaInicioDestino(rutaCoordenadas, distancia, duracion));
    }
  }
}
