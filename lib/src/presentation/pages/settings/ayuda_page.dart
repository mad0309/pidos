import 'package:flutter/material.dart';
import 'package:pidos/src/presentation/widgets/circle_avatar_name.dart';
import 'package:pidos/src/presentation/widgets/drawer_nav.dart';
import 'package:pidos/src/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';


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
                child: Text('Ayuda', style: TextStyle(fontFamily: 'Raleway',color: primaryColor, fontSize: 30.0,fontWeight: FontWeight.w700)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 80.0),
                child: Text('Puedes encontrar tutoriales y ayuda aquí',textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF666666), fontSize: 18.0)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 50.0),
                child: _ayudaButton()
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _ayudaButton(){
    return SizedBox(
        width: double.infinity,
        child: RaisedButton(
          child: Container( 
            padding: EdgeInsets.symmetric( vertical: 10.0 ),
            child: Text(
              'Ayuda',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20.0
              )
            ),
          ),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: electricVioletColor),
            borderRadius: BorderRadius.circular(20.0)
          ),
          color: Colors.transparent,
          elevation: 0.0,
          textColor: electricVioletColor,
          onPressed: _launchURL,
          focusElevation: 0.0,
          hoverElevation: 0.0,
          splashColor: secundaryColor,
        ),
    );
  }

  _launchURL() async {
    const url = 'https://pidoscolombia.com/ayuda';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}