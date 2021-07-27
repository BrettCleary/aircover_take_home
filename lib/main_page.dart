import 'dart:ui';

import 'package:aircover_take_home/bloc/bloc_provider.dart';
import 'package:aircover_take_home/bloc/letter_bloc.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController _textHeightController = new TextEditingController();

  String _validator(String? value) {
    print('validating: $value');
    return '';
  }

  void _onHeightSubmitted(String? value) {
    print('submitted: $value');
    int height = int.tryParse(value ?? '-1') ?? -1;
    if (height < 0) {
      return;
    }
    LetterBloc letterBloc = BlocProvider.of<LetterBloc>(context);
    letterBloc.updateLetter(height);
  }

  void _updateHeightTest() {
    LetterBloc letterBloc = BlocProvider.of<LetterBloc>(context);
    letterBloc.updateLetter(10);
  }

  @override
  Widget build(BuildContext context) {
    LetterBloc letterBloc = BlocProvider.of<LetterBloc>(context);
    return Container(
        color: Color(0xFF0C1947),
        alignment: Alignment.center,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  child: Text('aircover',
                      style: TextStyle(fontSize: 200, color: Colors.white))),
              Container(
                  child: Text('How tall would you like your AC to be?',
                      style: TextStyle(fontSize: 40, color: Colors.white))),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(200)),
                  constraints: BoxConstraints(maxWidth: 200),
                  child: TextFormField(
                    controller: _textHeightController,
                    maxLength: 10,
                    validator: _validator,
                    onFieldSubmitted: _onHeightSubmitted,
                  )),
              TextButton(
                  onPressed: _updateHeightTest, child: Text('Update Text')),
              Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(200)),
                  child: StreamBuilder(
                      stream: letterBloc.letterTextStream,
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        //rebuild AC letters only
                        return Text(
                          snapshot.data ?? '',
                          style: TextStyle(
                              fontFamily: 'CourierPrime',
                              letterSpacing: 0,
                              fontFeatures: [FontFeature.tabularFigures()]),
                        );
                      })),
            ]));
  }
}
