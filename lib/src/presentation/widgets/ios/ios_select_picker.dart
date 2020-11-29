import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pidos/src/utils/colors.dart';

///List<Widget>.generate(
                        //   lsLocalidad.length,(int index) => Text(lsLocalidad[index].name)
                        // )

Future<dynamic> showIosSelectPicker({
  BuildContext context,
  List<Widget> items,
  Function(int) onChangedItem,
  int initialItem,
  String title
}) {
  return showCupertinoModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context, scrollContrller) {
        return Material(
          color: Colors.transparent,
          child: SizedBox(
            height: 220.0,
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  width:double.infinity,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Container(child: Text(''))
                      ),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(title ?? '', style: TextStyle(fontWeight: FontWeight.w300))
                        )
                      ),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Text('OK', style: TextStyle(color: primaryColor, fontSize: 18.0, fontWeight: FontWeight.w600))
                          )
                        )
                      ),
                    ],
                  )
                ),
                Expanded(
                  child: ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                      child: CupertinoPicker(
                        scrollController: FixedExtentScrollController(
                          initialItem: initialItem ?? 0,
                        ),
                        magnification: 1.0, //incremetn the size of item selected
                        backgroundColor: Color(0xFFF6F6F6).withOpacity(0.95),
                        useMagnifier: true,
                        onSelectedItemChanged: onChangedItem,
                        itemExtent: 30.0,
                        children: items,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );


}