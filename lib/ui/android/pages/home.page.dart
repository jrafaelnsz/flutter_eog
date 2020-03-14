import 'package:eog/blocs/businnesslogic.dart';
import 'package:eog/ui/android/widgets/logo.widget.dart';
import 'package:eog/ui/android/widgets/submit-form.widget.dart';
import 'package:eog/ui/android/widgets/success.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color _color = Colors.deepPurple;
  var _busy = false;
  var _completed = false;
  var _resultText = "Compensa utilizar Etanol";
  var _gasCtrl = new MoneyMaskedTextController();
  var _alcCtrl = new MoneyMaskedTextController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: AnimatedContainer(
        duration: Duration(
          milliseconds: 1200,
        ),
        color: _color,
        child: ListView(
          children: <Widget>[
            Logo(),
            _completed
                ? Success(
                    result: _resultText,
                    reset: reset,
                  )
                : SubmitForm(
                    alcCtrl: _alcCtrl,
                    gasCtrl: _gasCtrl,
                    busy: _busy,
                    submitFunc: calculate,
                  ),
          ],
        ),
      ),
    );
  }

  Future calculate() {
    double alc =
        double.parse(_alcCtrl.text.replaceAll(new RegExp(r'[,.]'), '')) / 100;
    double gas =
        double.parse(_gasCtrl.text.replaceAll(new RegExp(r'[,.]'), '')) / 100;
    //double res = alc / gas;

    var bloc = new BusinnessLogic(valorEtanol: alc, valorGasolina: gas);

    setState(() {
      _color = Colors.deepPurpleAccent;
      _completed = false;
      _busy = true;
    });

    return new Future.delayed(
        const Duration(seconds: 1),
        () => {
              setState(() {
                if (bloc.etanolCompensa()) {
                  _resultText = "Compensa utilizar Etanol!";
                } else {
                  _resultText = "Compensa utilizar Gasolina!";
                }

                _busy = false;
                _completed = true;
              })
            });
  }

  reset() {
    setState(() {
      _color = Colors.deepPurple;
      _alcCtrl = new MoneyMaskedTextController();
      _gasCtrl = new MoneyMaskedTextController();
      _completed = false;
      _busy = false;
    });
  }
}
