part of 'widgets.dart';

class BtnUbicacion extends StatelessWidget {
  const BtnUbicacion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapaBloc = BlocProvider.of<MapaBloc>(context);
    final miUbicacionBloc = BlocProvider.of<MiUbicacionBloc>(context);

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
            onPressed: () {
              final destino = miUbicacionBloc.state.ubicacion;
              if (destino != null) mapaBloc.moverCamara(destino);
            },
            icon: Icon(Icons.my_location, color: Colors.black87)),
      ),
    );
  }
}
