import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';


class MyBaseBloc implements BaseBloc {
  bool _calledDispose = false;
  final Function _dispose;

  MyBaseBloc(this._dispose);

  @override
  void dispose() {
    if (_calledDispose) {
      throw Exception('[$runtimeType] dispose called more than once');
    }
    _dispose();
    _calledDispose = true;
    print('[$runtimeType] disposed');
  }
}
