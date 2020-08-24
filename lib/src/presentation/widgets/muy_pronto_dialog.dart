import 'package:flutter/material.dart';
import 'package:pidos/src/presentation/widgets/button_submit.dart';
import 'package:pidos/src/utils/colors.dart';

/// (Dialog)
/// Cuadro de dialogo
///
Future<dynamic> muyProntoDialog({
  @required BuildContext context,
}) async {
  return await showDialog(
    context: context,
    child: _SystemPadding(
      child: _TransferenciaDialog(),
    )

  );
}


/// 
/// _SystemPadding: Sirve para cuando se requiere colocar una caja de texto en dialog|alertDialog, 
/// este staful da el efecto de desplazamiento hacia arriba
///
class _SystemPadding extends StatelessWidget {
  final Widget child;

   _SystemPadding({
    this.child
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: MediaQuery.of(context).viewPadding,
      duration: Duration(milliseconds: 500),
      child: child,
    );
  }
}


class _TransferenciaDialog extends StatefulWidget {

  @override
  __TransferenciaDialogState createState() => __TransferenciaDialogState();
}

class __TransferenciaDialogState extends State<_TransferenciaDialog> {

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      insetPadding: EdgeInsets.all(30.0),
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 60.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.star, color: electricVioletColor, size: 30.0),
                Text('Muy Pronto', style: TextStyle( color: primaryColor, fontSize: 35.0, fontWeight: FontWeight.w700 ), ),
                Icon(Icons.star, color: electricVioletColor, size: 30.0),
              ],
            ),
            Text('podrás realizar esta acción', style: TextStyle( color: Colors.black, fontSize: 16.0 ), ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 40.0),
              child: ButtonSubmit(
                color: electricVioletColor,
                onPressed: () => Navigator.of(context).pop(),
                textColor: cyanColor,
                title: 'Entendido',
              ),
            )
          ],
        ),
      )
    );
  }
}