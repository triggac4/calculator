import 'package:calculator/breakthrough.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Breakthrough(),
      theme: ThemeData(
          primaryColor: Colors.grey[800], accentColor: Colors.orangeAccent,
          textTheme: TextTheme( )
          ),
    ),
  );
}

class Trycatch extends StatefulWidget {
  @override
  _TrycatchState createState() => _TrycatchState();
}

class _TrycatchState extends State<Trycatch> {
  //the input variable where all inputs go to
  String input = '';
  //the list of index location for all arithmetic function in the input
  List<int> listInt = [];
  //the list of every variable in the input
  List<String> listInput = [];
  //the answer we used the calculator for in the first place
  double ans = 0;



  //this function removes the last element in the input
  delbutn() {
    if (input == '') {
      return;
    } else {
      int len = input.length;
      input = input.substring(0, len - 1);
      
    }
  }

  //function to input into String input which contains so much logic
  changebool(m) {
    passThrough();
    //returns true if input ends with an arithmetic operation
    bool function = input.endsWith('+') ||
        input.endsWith('-') ||
        input.endsWith('x') ||
        input.endsWith('/');
    //returns true if the next input is an arithmetic function
    bool arithemetic = m == '+' || m == '-' || m == 'x' || m == '/';
    //this changes the input to become empty if you've got an error
    var isarithmetic = listInput.any((i) {
      return (i == '+' || i == '-' || i == 'x' || i == '/');
    });
    if (input == 'invalid input') {
      input = '';
    }
    if (ans.isInfinite) {
      input = '';
      ans = 0;
      return;
    }
    //this changes the input to 0.0 if previous input was empty and the new input is a fullstop(.)
    if (m == '.' && input == '') {
      input = '0.0';
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
    //this changes the arithemetic function to another one if the input ends with an arithmetic function
    //and the new input is an arithemetic function
    if (function && arithemetic) {

      input = input.substring(0, input.length - 1) + '$m';
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
    //this checks if the input ends with .0 and the new input is an arithmrtic function
    //it adds the fiction behind the .0 this if statement was written because of the
    //if statement below it to prevent it from performing that statement
    if (arithemetic && isarithmetic) {
      addition();
      input = ans.toString() + '$m';
      ans = 0;
      return;
    }
    if (input.endsWith('.0') && arithemetic) {
      input = input + '$m';
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

//function to perform arithemetic
  void addition() {

    //getting freshly parsed inputList(listInput) and arithemtic operation position list(listInt)
    passThrough();
    //parsing through the listInt
    if(listInt.isEmpty){
      ans=double.parse(input);
    }
    
    for (int w = 0; w < listInt.length; w++) {
      
      //this happens when arithmetic operation lists length=1
      if (listInt.length == 1) {
        //this happens when the arithmetic operation=1 and the arithmetic operation in the string is +
        if (listInput[listInt[w]] == '+') {
          //use subString to get position of where the arithemetic is and save the value before the arithemetic and after
          String firstv = input.substring(0, listInt[w]);
          String secondv = input.substring(listInt[w] + 1, input.length);
          //try to parse the two values gotten into double and add them if failed input variable changes to invalid input
          try {
            ans = double.parse(firstv) + double.parse(secondv);
          } catch (e) {
            ans = 0;
            input = 'invalid input';
          }
        } else if (listInput[listInt[w]] == '-') {
          //use subString to get position of where the arithemetic is and save the value before the arithemetic and after
          String firstv = input.substring(0, listInt[w]);
          String secondv = input.substring(listInt[w] + 1, input.length);
//try to parse the two values gotten into double and add them if failed input variable changes to invalid input
          try {
            ans = double.parse(firstv) - double.parse(secondv);
          } catch (e) {
            ans = 0;
            input = 'invalid input';
          }
        } else if (listInput[listInt[w]] == 'x') {
          //use subString to get position of where the arithemetic is and save the value before the arithemetic and after
          String firstv = input.substring(0, listInt[w]);
          String secondv = input.substring(listInt[w] + 1, input.length);
          //try to parse the two values gotten into double and add them if failed input variable changes to invalid input
          try {
            ans = double.parse(firstv) * double.parse(secondv);
          } catch (e) {
            ans = 0;
            input = 'invalid input';
          }
        } else if (listInput[listInt[w]] == '/') {
          //use subString to get position of where the arithemetic is and save the value before the arithemetic and after
          String firstv = input.substring(0, listInt[w]);
          String secondv = input.substring(listInt[w] + 1, input.length);
          //try to parse the two values gotten into double and add them if failed input variable changes to invalid input
          try {
            ans = double.parse(firstv) / double.parse(secondv);
          } catch (e) {
            ans = 0;
            input = 'invalid input';
          }
        }
      }
    }
  }

  passThrough() {
    //setting the inputlist and arithmetic operations list to zero so it would remove previous values and parse again
    listInput = [];
    listInt = [];
    //parsing through the input
    for (int i = 0; i < input.length; i++) {
      //adding each input into a List
      listInput.add(input[i]);
    }
//passing through the input list which was created above
    for (int j = 0; j < listInput.length; j++) {
      //checking for arithmetic operations
      if (listInput[j] == '+' ||
          listInput[j] == '-' ||
          listInput[j] == 'x' ||
          listInput[j] == '/') {
        //adding each arithemetic operations index to a list
        listInt.add(j);
      }
    }
// for(int w=0;w<path.length;w++){

//  values=input.split(path[1]);
//  values=input.split(path[2]);
// }

//print(values);
//just checking to see if the job was done
//print(listInt);
//print(listInput);
  }

  Widget rows(v, m, n, c) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
            child: RaisedButton(
                onPressed: () {
                  setState(() {
                    changebool(v);
                  });
                },
                child: Text('$v'))),
        Expanded(
            child: RaisedButton(
                onPressed: () {
                  setState(() {
                    changebool(m);
                  });
                },
                child: Text('$m'))),
        Expanded(
            child: RaisedButton(
                onPressed: () {
                  setState(() {
                    changebool(n);
                  });
                },
                child: Text('$n'))),
        Expanded(
            child: RaisedButton(
                color: Colors.grey[400],
                onPressed: () {
                  setState(() {
                    changebool(c);
                  });
                },
                child: Text(c))),
      ],
    );
  }
  dipose(){
    
    super.dispose();
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
              child: Text('$ans',
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
                                  changebool('/');
                                });
                              },
                              child: Text('/'),
                            )),
                            Expanded(
                                child: RaisedButton(
                                    color: Colors.grey[400],
                                    onPressed: () {
                                      setState(() {
                                        changebool('x');
                                      });
                                    },
                                    child: Text('x'))),
                            Expanded(
                                child: RaisedButton(
                                    color: Colors.grey[400],
                                    onPressed: () {
                                      setState(() {
                                        delbutn();
                                      });
                                    },
                                    child: Text('del'))),
                            Expanded(
                                child: RaisedButton(
                                    color: Colors.grey[400],
                                    onPressed: () {
                                      setState(() {
                                        input = '';
                                        ans = 0;
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
                                                  changebool('1');
                                                });
                                              },
                                              child: Text('1'),
                                            ),
                                          ),
                                          Expanded(
                                            child: RaisedButton(
                                              onPressed: () {
                                                setState(() {
                                                  changebool('2');
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
                                            changebool('0');
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
                                                  changebool('3');
                                                });
                                              },
                                              child: Text('3'),
                                            ),
                                          ),
                                          Expanded(
                                            child: RaisedButton(
                                              onPressed: () {
                                                setState(() {
                                                  changebool('.');
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
                                              addition();
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
