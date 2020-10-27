


import 'package:pidos/src/domain/models/movimientos.dart';

abstract class MovimientosRepository {

  Stream<List<Movimientos>> listarMovimientos();

}