import 'package:flutter/material.dart';

import 'package:led_control_application/leds_model.dart';
import 'package:led_control_application/api_service.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Leds? ledColors;

  Color? pickerColor;
  Color? currentColor;
  int? prog;

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
  }

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("RGB Led control"),
      ),
      body: ledColors == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Column(
              
              children: [
                ColorPicker(
                  pickerColor: pickerColor!,
                  onColorChanged: changeColor,
                ),
                Expanded(
                  child: GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    crossAxisCount: 3,
                    children: [
                      OutlinedButton(
                          onPressed: () {
                            setState(() {
                              prog = 0;
                            });
                            ApiService().postLeds(
                                pickerColor!.red,
                                pickerColor!.green,
                                pickerColor!.blue,
                                pickerColor!.alpha,
                                prog!);
                          },
                          child: const Text("Szín")),
                      OutlinedButton(
                          onPressed: () {
                            setState(() {
                              prog = 1;
                            });
                            ApiService().postLeds(
                                pickerColor!.red,
                                pickerColor!.green,
                                pickerColor!.blue,
                                pickerColor!.alpha,
                                prog!);
                          },
                          child: const Text("Kígyó")),
                      OutlinedButton(
                          onPressed: () {
                            setState(() {
                              prog = 2;
                            });
                            ApiService().postLeds(
                                pickerColor!.red,
                                pickerColor!.green,
                                pickerColor!.blue,
                                pickerColor!.alpha,
                                prog!);
                          },
                          child: const Text("Szivárvány", textAlign: TextAlign.center,)),
                      OutlinedButton(
                          onPressed: () {
                            setState(() {
                              prog = 3;
                            });
                            ApiService().postLeds(
                                pickerColor!.red,
                                pickerColor!.green,
                                pickerColor!.blue,
                                pickerColor!.alpha,
                                prog!);
                          },
                          child: const Text("Szivárvány átmenettel", textAlign: TextAlign.center,)),
                      OutlinedButton(
                          onPressed: () {
                            setState(() {
                              prog = 4;
                            });
                            ApiService().postLeds(
                                pickerColor!.red,
                                pickerColor!.green,
                                pickerColor!.blue,
                                pickerColor!.alpha,
                                prog!);
                          },
                          child: const Text("Gradiens")),
                      OutlinedButton(
                          onPressed: () {
                            setState(() {
                              prog = 5;
                            });
                            ApiService().postLeds(
                                pickerColor!.red,
                                pickerColor!.green,
                                pickerColor!.blue,
                                pickerColor!.alpha,
                                prog!);
                          },
                          child: const Text("Mozgó gradiens", textAlign: TextAlign.center,)),
                    ],
                  ),
                )
              ],
            )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ApiService().postLeds(pickerColor!.red, pickerColor!.green,
              pickerColor!.blue, pickerColor!.alpha, prog!);
        },
        tooltip: 'Set',
        child: const Icon(Icons.highlight_rounded),
      ),
    );
  }
}
