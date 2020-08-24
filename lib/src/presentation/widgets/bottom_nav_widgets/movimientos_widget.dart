import 'package:flutter/material.dart';
import 'package:pidos/src/utils/colors.dart';


class MovimientosWidget extends StatelessWidget {

  final String fechaMovimiento;
  final String pids;
  final String pidId;
  final String comerciante;
  final String comercianteId;

  const MovimientosWidget({
    @required this.fechaMovimiento,
    @required this.pids,
    @required this.pidId,
    @required this.comerciante,
    @required this.comercianteId
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: secundaryColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black26,
            blurRadius: 3.0,
            offset: Offset(0.0, 3.0),
            spreadRadius: 0.3
          )
        ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(this.fechaMovimiento, style: TextStyle(fontSize: 18.0,color: Colors.black, fontWeight: FontWeight.w600)),
              Text('$pids PIDS', style: TextStyle(fontSize: 18.0,color: Colors.green, fontWeight: FontWeight.w700)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('PID $pidId', style: TextStyle(fontSize: 16.0,color: Colors.black, fontWeight: FontWeight.w300)),
                  Text('$comerciante', style: TextStyle(fontSize: 16.0,color: Colors.black, fontWeight: FontWeight.w300)),
                ],
              ),
              Text('$comercianteId', style: TextStyle(fontSize: 16.0,color: Colors.black, fontWeight: FontWeight.w300)),
            ],
          ),
        ],
      ),
    );
  }
}