import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Values extends ChangeNotifier {
  List<String> value = ['', '', '', '', '', '', '', '', ''];
  int chance = 0;
  int total = 0;
  int win = -1;
  int pl0 = 0, pl1 = 0;
  void reset() {
    value = ['', '', '', '', '', '', '', '', ''];
    chance = 0;
    total = 0;
    win = -1;
    pl0 = 0;
    pl1 = 0;
    notifyListeners();
  }

  void tapped(int index, BuildContext context) async {
    if(value[index]!=''){
      return;
    }
    value[index] = chance % 2 == 0 ? 'O' : 'X';
    notifyListeners();
    _check(index);
    total++;
    if (win != -1) {
      win = chance;
    } else if (total == 9) {
      win = 2;
    }
    if (win == -1) {
      chance = 1 - chance;
    } else {
      if (win == 0) {
        pl0++;
      } else if (win == 1) {
        pl1++;
      }
      await _showDialog(win, context);

      win = -1;
      total = 0;
      chance = 0;
      value = ['', '', '', '', '', '', '', '', ''];
    }
    notifyListeners();
  }

  Future<void> _showDialog(int win, BuildContext context) async {
    await showDialog(
        barrierColor: Colors.white.withOpacity(0),
        barrierDismissible: false,
        context: context,
        builder: (cxt) {
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.of(context).pop();
          });
          String alert = '';
          if (win == 1) {
            alert = 'Player B Wins!!';
          } else if (win == 0) {
            alert = 'Player A Wins!!';
          } else {
            alert = 'Match Drawn!!';
          }

          return AlertDialog(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: Center(
              child: Text(
                alert,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurpleAccent

                ),
              ),
            ),
          );
        });
    // await Navigator.of(context).push(
    //   PageRouteBuilder(
    //       pageBuilder: (context, _, __) {
    //         Future.delayed(const Duration(seconds: 2), () {
    //           Navigator.of(context).pop();
    //         });
    //         return const AlertDialog(
    //           backgroundColor: Colors.transparent,
    //           elevation: 0.0,
    //           title: Text("Draw"),
    //         );
    //       },
    //       opaque: false
    //   ),
    // );
  }

  _check(int index) {
    int result = 0;

    for (int i = 0; i < 3; i++) {
      int temp = 1;
      for (int j = 3 * i + 1; j < 3 * (i + 1); j++) {
        if (value[j] == '' || value[j - 1] != value[j]) {
          temp = 0;
          break;
        }
      }
      result |= temp;
      temp = 1;
      for (int j = 1; j < 3; j++) {
        if (value[i + j * 3] == '' ||
            value[i + j * 3] != value[i + (j - 1) * 3]) {
          temp = 0;
          break;
        }
      }
      result |= temp;
    }
    int temp = 1;
    for (int i = 4; i < 9; i += 4) {
      if (value[i] != value[i - 4] || value[i] == '') {
        temp = 0;
        break;
      }
    }
    result |= temp;
    temp = 1;
    for (int i = 4; i < 7; i += 2) {
      if (value[i] != value[i - 2] || value[i] == '') {
        temp = 0;
        break;
      }
    }
    result |= temp;
    if (result == 1) {
      win = 1;
    }
  }
}
