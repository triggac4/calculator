import 'package:flutter/material.dart';

class Breakthrough extends StatefulWidget {
  @override
  _BreakthroughState createState() => _BreakthroughState();
}

class _BreakthroughState extends State<Breakthrough> {
  String input = '';
  List<String> listInput = [];
  List<int> listArithmeticIndex = [];
  String forParsing = '';
  List<String> pairedValues = [];
  List<String> arithmeticValue = [];
  double answer = 0;
  delbutn() {
    if (input == '') {
      return;
    } else {
      int len = input.length;
      input = input.substring(0, len - 1);
    }
  }

  enterNumbers(m) {
    passThrough();
    //returns true if input ends with an arithmetic operation
    bool function = input.endsWith('+') ||
        input.endsWith('-') ||
        input.endsWith('x') ||
        input.endsWith('/');

    
    //this changes the input to become empty if you've got an error
    if (input == 'invalid input') {
      input = '';
    }
    if (answer.isInfinite) {
      input = '';
      answer = 0;
      return;
    }
    //this changes the input to 0.0 if previous input was empty and the new input is a fullstop(.)
    
    
    if (m == '.' && input == '') {
      input = '+0.0';
      return;
    }
    if(input==''){
      input='+$m';
      return;
    }

    //this adds 0.0 to the input if previous input endswith an arithmetic operation
    // and the new input is a fullstop(.)
    if (function && m == '.') {
      input = input + '0.0';
      return;
    }
    //this adds .0 to the input if previous input isnt empty
    // and the new input is a fullstop(.)
    if (m == '.' && input != '') {
      input = input + '.0';
      return;
    }

    //this adds space to the input if the input ends with .0 and the new input is 0
    //because we want to keep that zero in the input when another inputs is entered
    if (input.endsWith('.0') && m == '0') {
      input = input + ' ';
      return;
    }
    //this checks whether the input ends with space so as to be able to keep the zero
    //which the previous if statement puts the space there in the forst place for
    if (input.endsWith(' ')) {
      input = input.substring(0, input.length - 1) + '$m';
      return;
    }

    //this checks if the input ends with .0 and then replaces the 0 with the new input
    if (input.endsWith('.0')) {
      var last = input.lastIndexOf('0');
      input = input.substring(0, last) + '$m';
      return;
    }
    //this just adds to the previous input hahaha nothing special
    input = input + '$m';
  }

  enterArithmetic(m) {
    bool arithemetic = m == '+' || m == '-' || m == 'x' || m == '/';
    bool function = input.endsWith('+') ||
        input.endsWith('-') ||
        input.endsWith('x') ||
        input.endsWith('/');

    if (input == '' && (m == 'x' || m == '/')) {
      return;
    }
    if (answer.isInfinite) {
      input = '';
      answer = 0;
      return;
    }

    if (function && arithemetic) {
      input = input.substring(0, input.length - 1) + '$m';
      return;
    }
    if (input.endsWith('.0') && arithemetic) {
      input = input + '$m';
      return;
    }
    input = input + '$m';
  }
  solve() {
    if (answer.isInfinite) {
      return;
    }
    bool function = input.endsWith('+') ||
        input.endsWith('-') ||
        input.endsWith('x') ||
        input.endsWith('/');
    if (pairedValues.isEmpty) {
      return;
    }
    if (function) {
      return;
    }
    answer = 0;
    passThrough();
    double ank;
    bool trace = true;

    if (pairedValues.length == 1) {
      answer = double.parse(pairedValues[0]);
    } else {
     answer = double.parse(pairedValues[0]);
      for (int a = 1; a < pairedValues.length; a++){
        if (pairedValues[a].startsWith('+') ||
            pairedValues[a].startsWith('-')) {
          print(answer);
          print('yes it is using add ans sub');
          trace = true;
          answer = answer + double.parse(pairedValues[a]);
        } else if (pairedValues[a].startsWith('x') ||
            pairedValues[a].startsWith('/')) {
          List<String> paireddintandmult = [];
          double ans = 0;
          inner:
          for (int b = 0; b < arithmeticValue.length; b++) {
            String check = pairedValues[a - b];
            //TODO: comeback to this
            // if(a-b==0){
            //   check='+'+pairedValues[0];
            // }
            if (check.startsWith('+') || check.startsWith('-')) {
              int c = b;
              print(paireddintandmult);
              //this is just a precaution incase an element with + manages to enter the logic lol
              // paireddintandmult.removeWhere((element) =>
              //     element.startsWith('+') || element.startsWith('-'));
              if (trace) {  
                ank = answer - double.parse(pairedValues[a - c]);
                trace = false;
              }
              ans = double.parse(pairedValues[a - c]);
              print(ans);
              for (int d = 0; d < paireddintandmult.length; d++) {
                if (paireddintandmult[d].startsWith('/')) {
                  ans = ans /
                      double.parse(paireddintandmult[d]
                          .substring(1, paireddintandmult[d].length));
                } else if (paireddintandmult[d].startsWith('x')) {
                  ans = ans *
                      double.parse(paireddintandmult[d]
                          .substring(1, paireddintandmult[d].length));
                }
              }
              print(paireddintandmult);
              print(ans);
              print(ank);
              print('yup used d div and multiply');
              
              answer =ank + ans;
              break inner;
            }
            paireddintandmult.add(pairedValues[a - b]);
        }
        
      }
    }
  }}

  passThrough() {
    listInput = [];
    listArithmeticIndex = [];
    forParsing = '';
    pairedValues = [];
    arithmeticValue = [];

    for (int a = 0; a < input.length; a++) {
      listInput.add(input[a]);
    }
    for (int b = 0; b < listInput.length; b++) {
      if (listInput[b] == '+' ||
          listInput[b] == '-' ||
          listInput[b] == 'x' ||
          listInput[b] == '/') {
        listArithmeticIndex.add(b);
      }
    }
    for (int c = 0; c < listInput.length; c++) {
      for (int d = 0; d < listArithmeticIndex.length; d++) {
        if (c == listArithmeticIndex[d]) {
          pairedValues.add(forParsing);
          arithmeticValue.add(listInput[c]);
          forParsing = '';
        }
      }
      forParsing = forParsing + listInput[c];
    }

    String v = '';
    if (listArithmeticIndex.isEmpty) {
      String v = input;
      pairedValues.add(v);
      pairedValues.remove('');
    } else if (listArithmeticIndex.isNotEmpty) {
      v = input.substring(
          (listArithmeticIndex[listArithmeticIndex.length - 1]), input.length);
      pairedValues.add(v);
      pairedValues.remove('');
    }
  }

  Widget rows(v, m, n, c) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
            child: RaisedButton(
                onPressed: () {
                  setState(() {
                    enterNumbers(v);
                    solve();
                  });
                },
                child: Text('$v'))),
        Expanded(
            child: RaisedButton(
                onPressed: () {
                  setState(() {
                    enterNumbers(m);
                    solve();
                  });
                },
                child: Text('$m'))),
        Expanded(
            child: RaisedButton(
                onPressed: () {
                  setState(() {
                    enterNumbers(n);
                    solve();
                  });
                },
                child: Text('$n'))),
        Expanded(
            child: RaisedButton(
                color: Colors.grey[400],
                onPressed: () {
                  setState(() {
                    enterArithmetic(c);
                  });
                },
                child: Text(c))),
      ],
    );
  }

  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey[800],
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Column(children: <Widget>[
          Container(
              color: Theme.of(context).primaryColor,
              width: double.infinity,
              alignment: Alignment.bottomRight,
              height: MediaQuery.of(context).size.height * 0.1,
              child: Text('$input',
                  style: TextStyle(fontSize: 30, color: Colors.white))),
          Container(
              color: Theme.of(context).primaryColor,
              width: double.infinity,
              alignment: Alignment.bottomRight,
              height: MediaQuery.of(context).size.height * 0.1,
              child: Text('$answer',
                  style: TextStyle(
                      fontSize: 30, color: Theme.of(context).accentColor))),
          Container(
              color: Colors.grey[200],
              height: MediaQuery.of(context).size.height * 0.748,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                        width: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Expanded(
                                child: RaisedButton(
                              color: Colors.grey[400],
                              onPressed: () {
                                setState(() {
                                  enterArithmetic('/');
                                });
                              },
                              child: Text('/'),
                            )),
                            Expanded(
                                child: RaisedButton(
                                    color: Colors.grey[400],
                                    onPressed: () {
                                      setState(() {
                                        enterArithmetic('x');
                                      });
                                    },
                                    child: Text('x'))),
                            Expanded(
                                child: RaisedButton(
                                    color: Colors.grey[400],
                                    onPressed: () {
                                      setState(() {
                                        delbutn();
                                        if (input.isNotEmpty) {
                                          solve();
                                        } else {
                                          answer = 0;
                                        }
                                      });
                                    },
                                    child: Text('del'))),
                            Expanded(
                                child: RaisedButton(
                                    color: Colors.grey[400],
                                    onPressed: () {
                                      setState(() {
                                        answer = 0;
                                        input = '';
                                        listInput = [];
                                        listArithmeticIndex = [];
                                        forParsing = '';
                                        pairedValues = [];
                                        arithmeticValue = [];
                                      });
                                    },
                                    child: Text('clr'))),
                          ],
                        )),
                  ),
                  Expanded(
                    child: Container(
                        width: double.infinity, child: rows(7, 8, 9, '-')),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      child: rows(4, 5, 6, '+'),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                        width: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                          child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          Expanded(
                                            child: RaisedButton(
                                              onPressed: () {
                                                setState(() {
                                                  enterNumbers('1');
                                                  solve();
                                                });
                                              },
                                              child: Text('1'),
                                            ),
                                          ),
                                          Expanded(
                                            child: RaisedButton(
                                              onPressed: () {
                                                setState(() {
                                                  enterNumbers('2');
                                                  solve();
                                                });
                                              },
                                              child: Text('2'),
                                            ),
                                          ),
                                        ],
                                      )),
                                    ),
                                    Expanded(
                                        child: Container(
                                      child: RaisedButton(
                                        onPressed: () {
                                          setState(() {
                                            enterNumbers('0');
                                            solve();
                                          });
                                        },
                                        child: Text('0'),
                                      ),
                                    ))
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                                child: Container(
                              child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Expanded(
                                        child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          Expanded(
                                            child: RaisedButton(
                                              onPressed: () {
                                                setState(() {
                                                  enterNumbers('3');
                                                  solve();
                                                });
                                              },
                                              child: Text('3'),
                                            ),
                                          ),
                                          Expanded(
                                            child: RaisedButton(
                                              onPressed: () {
                                                setState(() {
                                                  enterNumbers('.');
                                                });
                                              },
                                              child: Text('.'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                                    Expanded(
                                        child: Container(
                                      child: RaisedButton(
                                          color: Theme.of(context).accentColor,
                                          onPressed: () {
                                            setState(() {
                                              solve();
                                              input =answer.toString().startsWith('-')? '$answer':'+$answer';
                                            });
                                          },
                                          child: Text('=')),
                                    ))
                                  ]),
                            ))
                          ],
                        )),
                  ),
                ],
              ))
        ]),
      ),
    ));
  }
}
