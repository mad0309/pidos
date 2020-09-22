import 'package:flutter/material.dart';
import 'package:pidos/src/presentation/widgets/circle_avatar_name.dart';
import 'package:pidos/src/presentation/widgets/drawer_nav.dart';
import 'package:pidos/src/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';


class AcercaDePage extends StatelessWidget {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();



  /// metodo build
  @override
  Widget build(BuildContext context) {
    final screenSizeHeight = MediaQuery.of(context).size.height;
    final screenSizeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: cyanColor),
          onPressed:() => Navigator.of(context).pop(),
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: screenSizeHeight * 0.067, bottom: screenSizeHeight * 0.042), //top: 40.0, bottom: 25.0
                  child: Text('Acerca de', style: TextStyle(fontFamily: 'Raleway',color: primaryColor, fontSize: 30.0,fontWeight: FontWeight.w700)),
                ),
                Container(
                  width: screenSizeWidth  * 0.305, //width: 110.0,
                  child: Image(
                    image: AssetImage('assets/img/acerca_de_icon.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: screenSizeHeight * 0.0337), //top: 20.0
                  child: Text('Pidos App Versión', style: TextStyle(color: Color(0xFF666666), fontSize: 18.0)),
                ),
                Text('1.0.0', style: TextStyle(color: Color(0xFF666666), fontSize: 18.0)),
                SizedBox(height: 10.0),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 50.0),
                  child: _ayudaButton(
                    title: 'Términos y condiciones',
                    urlLaucher: 'https://pidoscolombia.com/terminos-condiciones'
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 50.0),
                  child: _ayudaButton(
                    title: 'Políticas de privacidad',
                    urlLaucher: 'https://pidoscolombia.com/politica-privacidad'
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 50.0),
                  child: _ayudaButton(
                    title: 'Política de datos',
                    urlLaucher: 'https://pidoscolombia.com/politica-datos'
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _ayudaButton({
    String title,
    String urlLaucher
  }){
    return SizedBox(
        width: double.infinity,
        child: RaisedButton(
          child: Container( 
            padding: EdgeInsets.symmetric( vertical: 10.0 ),
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18.0
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
          onPressed: () => _launchURL(urlLaucher),
          focusElevation: 0.0,
          hoverElevation: 0.0,
          splashColor: secundaryColor,
        ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}


