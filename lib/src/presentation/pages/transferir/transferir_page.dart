import 'package:flutter/material.dart';
import 'package:pidos/src/presentation/widgets/button_submit.dart';
import 'package:pidos/src/utils/colors.dart';


class TransferirPage extends StatefulWidget {

  final Map<String,dynamic> transferencia;

  const TransferirPage({
    this.transferencia
  });


  @override
  _TransferirPageState createState() => _TransferirPageState();
}

class _TransferirPageState extends State<TransferirPage> {


  double _screenSizeHeight;
  double _screenSizeWidth;

  ///
  /// Logo
  ///
  Widget _logoImage(){
    return SafeArea(
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // SizedBox(height: _screenSizeHeight * 0.084), /// height: 50.0
            Image(
              image: AssetImage('assets/img/logo_solo.png'),
              fit: BoxFit.cover,
              // width: _screenSizeWidth * 0.33, //width: 120.0
              width: _screenSizeWidth * 0.138, //width: 50.0
            )
          ],
        ),
      ),
    );
  }

  Widget _titulo(){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: _screenSizeHeight * 0.016), //vertical: 10.0
      child: Text(
        (widget.transferencia['status'])
          ? '¡Transferencia exitosa!'
          : '¡Transferencia Rechazada!', 
        style: TextStyle(fontFamily: 'Raleway',color: (widget.transferencia['status']) ? electricVioletColor : Colors.red, fontSize: 25.0,fontWeight: FontWeight.w700)
      ),
    );
  }

  Widget _nroTransferencia(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Transferencia Nº 3040', style: TextStyle(color: Colors.black, fontSize: 18.0)),
        SizedBox(width: 8.0),
        (widget.transferencia['status']) 
          ? Icon(Icons.check_circle_outline, color: Colors.green,size: 22.0)
          : Icon(Icons.error_outline, color: Colors.red,size: 22.0),
      ],
    );
  }

  Widget _detalleTransferencia(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 55.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0), 
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('ID Origen',style: TextStyle(color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w700)),
                      Text('ID Destino',style: TextStyle(color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('PID-${widget.transferencia['currentPidId']}',style: TextStyle(color: Colors.black, fontSize: 15.0)),
                    Container(
                      width: 1,
                      height: 30.0,
                      color: Color(0xFF0CE7FD),
                    ),
                    Text('PID-${widget.transferencia['destinationPidId']}',style: TextStyle(color: Colors.black, fontSize: 15.0)),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: _detailRow('Tipo de transacción:', 'ENVÍO'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: _detailRow('Cantidad:', '${widget.transferencia['cantidadPidEnviada']} PIDOS'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: _detailRow('Nº de transacción:', '1030'),
          ),
          _button()
        ]
      ),
    );
  }

  Widget _detailRow(String title, String value){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.w700)),
        Text(value,style: TextStyle(color: Colors.black, fontSize: 15.0)),
      ],
    );
  }

  Widget _button(){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 10.0),
      child: ButtonSubmit(
        color: electricVioletColor,
        onPressed: () => Navigator.of(context).pop(),
        textColor: Colors.white,
        title: 'Aceptar',
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    _screenSizeHeight = _screenSize.height;
    _screenSizeWidth = _screenSize.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Column(
          children: [
            _logoImage(),
            _titulo(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 10.0),
              child: Divider(
                color: primaryColor,
              ),
            ),
            _nroTransferencia(),
            _detalleTransferencia()
          ],
        ),
      ),
    );
  }
}