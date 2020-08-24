import 'package:flutter/material.dart';


double baseHeight = 540.0;

double screenAwareSizeHeight( double size, BuildContext context ){
  return ((size / MediaQuery.of(context).size.height) * MediaQuery.of(context).size.height);
}
double screenAwareSizeWidth( double size, BuildContext context ){
  return (size / MediaQuery.of(context).size.width) * MediaQuery.of(context).size.width;
}