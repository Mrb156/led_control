import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:led_control_application/leds_model.dart';
import 'package:led_control_application/api_service.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class unitWall extends StatefulWidget {
  const unitWall({Key? key}) : super(key: key);

  @override
  State<unitWall> createState() => _unitWallState();
}

class _unitWallState extends State<unitWall> {
  Leds? ledColors;

  Color? pickerColor;
  Color? currentColor;
  int? prog;
  Color buttonColor0 = Colors.transparent;
  Color buttonColor1 = Colors.transparent;
  Color buttonColor2 = Colors.transparent;
  Color buttonColor3 = Colors.transparent;
  Color buttonColor4 = Colors.transparent;
  Color buttonColor5 = Colors.transparent;

  Color textColor0 = Colors.teal;
  Color textColor1 = Colors.teal;
  Color textColor2 = Colors.teal;
  Color textColor3 = Colors.teal;
  Color textColor4 = Colors.teal;
  Color textColor5 = Colors.teal;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    ledColors = (await ApiService().getLeds())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
    pickerColor = ledColors != null
        ? Color.fromRGBO(
            ledColors!.redValue, ledColors!.greenValue, ledColors!.blueValue, 1)
        : const Color(0xff443a49);
    currentColor = pickerColor;
    prog = ledColors != null ? ledColors!.prog : 0;
    switch (prog) {
      case 0:
        buttonColor0 = Colors.teal;
        textColor0 = Colors.white;
        break;
      case 1:
        buttonColor1 = Colors.teal;
        textColor1 = Colors.white;
        break;
      case 2:
        buttonColor2 = Colors.teal;
        textColor2 = Colors.white;
        break;
      case 3:
        buttonColor3 = Colors.teal;
        textColor3 = Colors.white;
        break;
      case 4:
        buttonColor4 = Colors.teal;
        textColor4 = Colors.white;
        break;
      case 5:
        buttonColor5 = Colors.teal;
        textColor5 = Colors.white;
        break;
      default:
    }
  }

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fal vezérlés"),
      ),
      body: ledColors == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Column(
              children: [
                ColorPicker(
                  labelTypes: const [],
                  colorPickerWidth: MediaQuery.of(context).size.width * 0.6,
                  pickerColor: pickerColor!,
                  onColorChanged: changeColor,
                ),
                Expanded(
                  child: GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    primary: false,
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.height * 0.05),
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    crossAxisCount: 3,
                    children: [
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              backgroundColor: buttonColor0),
                          onPressed: () {
                            setState(() {
                              prog = 0;
                              buttonColor0 = Colors.teal;
                              textColor0 = Colors.white;

                              buttonColor1 = Colors.transparent;
                              buttonColor2 = Colors.transparent;
                              buttonColor3 = Colors.transparent;
                              buttonColor4 = Colors.transparent;
                              buttonColor5 = Colors.transparent;

                              textColor1 = Colors.teal;
                              textColor2 = Colors.teal;
                              textColor3 = Colors.teal;
                              textColor4 = Colors.teal;
                              textColor5 = Colors.teal;
                            });
                            ApiService().postLeds(
                                pickerColor!.red,
                                pickerColor!.green,
                                pickerColor!.blue,
                                pickerColor!.alpha,
                                prog!);
                          },
                          child: Text(
                            "Szín",
                            style: TextStyle(color: textColor0),
                          )),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              backgroundColor: buttonColor1),
                          onPressed: () {
                            setState(() {
                              prog = 1;
                              buttonColor1 = Colors.teal;
                              textColor1 = Colors.white;
                              buttonColor0 = Colors.transparent;
                              buttonColor2 = Colors.transparent;
                              buttonColor3 = Colors.transparent;
                              buttonColor4 = Colors.transparent;
                              buttonColor5 = Colors.transparent;

                              textColor0 = Colors.teal;
                              textColor2 = Colors.teal;
                              textColor3 = Colors.teal;
                              textColor4 = Colors.teal;
                              textColor5 = Colors.teal;
                            });
                            ApiService().postLeds(
                                pickerColor!.red,
                                pickerColor!.green,
                                pickerColor!.blue,
                                pickerColor!.alpha,
                                prog!);
                          },
                          child: Text("Kígyó",
                              style: TextStyle(color: textColor1))),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              backgroundColor: buttonColor2),
                          onPressed: () {
                            setState(() {
                              prog = 2;
                              buttonColor2 = Colors.teal;
                              textColor2 = Colors.white;
                              buttonColor0 = Colors.transparent;
                              buttonColor1 = Colors.transparent;
                              buttonColor3 = Colors.transparent;
                              buttonColor4 = Colors.transparent;
                              buttonColor5 = Colors.transparent;

                              textColor0 = Colors.teal;
                              textColor1 = Colors.teal;
                              textColor3 = Colors.teal;
                              textColor4 = Colors.teal;
                              textColor5 = Colors.teal;
                            });
                            ApiService().postLeds(
                                pickerColor!.red,
                                pickerColor!.green,
                                pickerColor!.blue,
                                pickerColor!.alpha,
                                prog!);
                          },
                          child: Text("Szivárvány",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: textColor2))),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              backgroundColor: buttonColor3),
                          onPressed: () {
                            setState(() {
                              prog = 3;
                              buttonColor3 = Colors.teal;
                              textColor3 = Colors.white;
                              buttonColor0 = Colors.transparent;
                              buttonColor1 = Colors.transparent;
                              buttonColor2 = Colors.transparent;
                              buttonColor4 = Colors.transparent;
                              buttonColor5 = Colors.transparent;

                              textColor0 = Colors.teal;
                              textColor1 = Colors.teal;
                              textColor2 = Colors.teal;
                              textColor4 = Colors.teal;
                              textColor5 = Colors.teal;
                            });
                            ApiService().postLeds(
                                pickerColor!.red,
                                pickerColor!.green,
                                pickerColor!.blue,
                                pickerColor!.alpha,
                                prog!);
                          },
                          child: Text("Szivárvány átmenettel",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: textColor3))),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              backgroundColor: buttonColor4),
                          onPressed: () {
                            setState(() {
                              prog = 4;
                              buttonColor4 = Colors.teal;
                              textColor4 = Colors.white;
                              buttonColor0 = Colors.transparent;
                              buttonColor1 = Colors.transparent;
                              buttonColor2 = Colors.transparent;
                              buttonColor3 = Colors.transparent;
                              buttonColor5 = Colors.transparent;

                              textColor0 = Colors.teal;
                              textColor1 = Colors.teal;
                              textColor2 = Colors.teal;
                              textColor3 = Colors.teal;
                              textColor5 = Colors.teal;
                            });
                            ApiService().postLeds(
                                pickerColor!.red,
                                pickerColor!.green,
                                pickerColor!.blue,
                                pickerColor!.alpha,
                                prog!);
                          },
                          child: Text("Gradiens",
                              style: TextStyle(color: textColor4))),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              backgroundColor: buttonColor5),
                          onPressed: () {
                            setState(() {
                              prog = 5;
                              buttonColor5 = Colors.teal;
                              textColor5 = Colors.white;
                              buttonColor0 = Colors.transparent;
                              buttonColor1 = Colors.transparent;
                              buttonColor2 = Colors.transparent;
                              buttonColor3 = Colors.transparent;
                              buttonColor4 = Colors.transparent;

                              textColor0 = Colors.teal;
                              textColor1 = Colors.teal;
                              textColor2 = Colors.teal;
                              textColor3 = Colors.teal;
                              textColor4 = Colors.teal;
                            });
                            ApiService().postLeds(
                                pickerColor!.red,
                                pickerColor!.green,
                                pickerColor!.blue,
                                pickerColor!.alpha,
                                prog!);
                          },
                          child: Text("Mozgó gradiens",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: textColor5))),
                    ],
                  ),
                )
              ],
            )),
    );
  }
}
