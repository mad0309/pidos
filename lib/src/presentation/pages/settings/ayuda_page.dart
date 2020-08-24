import 'package:flutter/material.dart';
import 'package:pidos/src/presentation/widgets/circle_avatar_name.dart';
import 'package:pidos/src/presentation/widgets/drawer_nav.dart';
import 'package:pidos/src/utils/colors.dart';


class AyudaPage extends StatelessWidget {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: cyanColor),
          onPressed:()  => Navigator.of(context).pop(),
        ),
        actions: [
          InkResponse(
            onTap: () => _scaffoldKey.currentState.openEndDrawer(),
            child: Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: CircleAvatarName(
                diameterOutside: 40.0,
                diameterInside: 25.0,
                shortName: 'K',
                textSize: 10.0,
              ),
            ),
          )
        ],
      ),
      endDrawer: DrawerNav(),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 40.0),
                child: Text('Ayuda', style: TextStyle(color: primaryColor, fontSize: 30.0,fontWeight: FontWeight.w700)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text('Puedes encontrar ayuda en', style: TextStyle(color: Color(0xFF666666), fontSize: 18.0)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: Text('pidoscolombia.com/ayuda', style: TextStyle(color: Color(0xFF666666), fontSize: 18.0, fontWeight: FontWeight.w600)),
              )
            ],
          ),
        ),
      ),
    );
  }
}