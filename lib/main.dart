import 'package:aircover_take_home/bloc/bloc_provider.dart';
import 'package:aircover_take_home/bloc/letter_bloc.dart';
import 'package:aircover_take_home/main_page.dart';
import 'package:aircover_take_home/model/letter_creator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  LetterCreator _letterCreator = new LetterCreator();
  late LetterBloc _letterBloc;

  MyApp() {
    _letterBloc = new LetterBloc(_letterCreator);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'AirCover Technical Project',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: 'Inter',
            primaryColor: Color(0xFF0C1947)),
        home: BlocProvider<LetterBloc>(
            bloc: _letterBloc, child: Material(child: MainPage())));
  }
}
