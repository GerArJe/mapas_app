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
        Center(
          child: Transform.translate(
              offset: Offset(0, -12),
              child: Icon(
                Icons.location_on,
                size: 50,
              )),
        ),

        // Boton confirmar destino
        Positioned(
          bottom: 70,
          left: 40,
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
              onPressed: () {}),
        ),
      ],
    );
  }
}
