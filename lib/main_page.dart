import 'dart:ui';

import 'package:aircover_take_home/bloc/bloc_provider.dart';
import 'package:aircover_take_home/bloc/letter_bloc.dart';
import 'package:aircover_take_home/helpers/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';

//MainPage is the view for the main page of the website
//MainPage interacts with the business logic through the inherited bloc provider widget
class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController _textHeightController = new TextEditingController();

  String _validator(String? value) {
    var heightParse = int.tryParse(value ?? '-1');
    int height = heightParse ?? -1;
    if (heightParse == null || height < 0) {
      return 'please enter a positive integer';
    } else if (height > 400) {
      return 'please enter a height less than 400';
    }
    return '';
  }

  void _onHeightSubmitted(String? value) {
    if (_validator(value) != '') {
      return;
    }
    int height = int.tryParse(value ?? '-1') ?? 0;
    LetterBloc letterBloc = BlocProvider.of<LetterBloc>(context);
    letterBloc.updateLetter(height);
  }

  void _onUpdateHeightClick() {
    _onHeightSubmitted(_textHeightController.text);
  }

  @override
  Widget build(BuildContext context) {
    LetterBloc letterBloc = BlocProvider.of<LetterBloc>(context);
    double logoHeight = 100;
    double logoWidth = 1032 / 140 * logoHeight;
    return Container(
        color: Color(0xFF0C1947),
        alignment: Alignment.center,
        child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
              //Logo
              Container(
                margin: EdgeInsets.all(30),
                child: Container(
                    width: logoWidth,
                    color: Colors.transparent,
                    child: Icon(
                      MyFlutterApp.aircover_logo_horizontal_light,
                      color: Colors.white,
                      size: logoHeight,
                    )),
                alignment: Alignment.center,
              ),
              //Question prompt for user
              Container(
                  margin: EdgeInsets.all(20),
                  child: Text('How many characters tall would you like your AC to be?',
                      style: TextStyle(fontSize: 30, color: Colors.white))),
              //Text input
              Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(200)),
                  constraints: BoxConstraints(maxWidth: 300),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                        counterText: '',
                        enabledBorder: InputBorder.none,
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        focusedBorder: InputBorder.none,
                        isCollapsed: true,
                        labelText: '',
                        labelStyle: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
                    controller: _textHeightController,
                    maxLength: 10,
                    validator: _validator,
                    onFieldSubmitted: _onHeightSubmitted,
                  )),
              //Update Text Button
              Container(
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(40)),
                  child: TextButton(
                      style: ButtonStyle(
                          //overlayColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40), side: BorderSide(color: Colors.transparent)))),
                      onPressed: _onUpdateHeightClick,
                      child: Container(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            'Update Text',
                            style: TextStyle(
                                fontSize: 30, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                          )))),
              //AC Letter Display
              Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(40),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(40)),
                  child: StreamBuilder(
                      stream: letterBloc.letterTextStream,
                      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                        //rebuild AC letters only
                        return Text(
                          snapshot.data ?? '',
                          style: TextStyle(
                              fontFamily: 'CourierPrime',
                              letterSpacing: 0,
                              fontFeatures: [FontFeature.tabularFigures()]),
                        );
                      })),
            ])));
  }
}
