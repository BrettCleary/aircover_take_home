import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:aircover_take_home/bloc/bloc.dart';

//BlocProvider provides Bloc derived classes to their descendants
class BlocProvider<T extends Bloc> extends StatefulWidget {
  final Widget child;
  final T bloc;

  const BlocProvider({Key? key, required this.bloc, required this.child}) : super(key: key);

  // used by child widgets to get the bloc on the _BlocProvider it inherited
  static T of<T extends Bloc>(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_BlocProvider<T>>()
        !.bloc;
  }

  static Type _providerType<T>() => T;

  @override
  State createState() => _BlocProviderState<T>();
}

class _BlocProviderState<T extends Bloc> extends State<BlocProvider> {

  // add _BlocProvider into the tree as an inherited widget
  @override
  Widget build(BuildContext context) {
    return _BlocProvider<T>(bloc: widget.bloc as T, child: widget.child);
  }

  // have to have dispose to close streams, inheritedWidget does not have a dispose
  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}

class _BlocProvider<T extends Bloc> extends InheritedWidget {
  final T bloc;

  _BlocProvider({
    Key? key,
    required this.bloc,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_BlocProvider old) => bloc != old.bloc;
}
