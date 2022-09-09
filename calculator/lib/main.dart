import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Bill(),
  ));
}

class Bill extends StatefulWidget {
  const Bill({Key? key}) : super(key: key);

  @override
  State<Bill> createState() => _BillState();
}

class _BillState extends State<Bill> {
  double tipperhead = 0.0;
  int tippercentage = 0;
  int person = 1;
  double billamt = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.08),
        alignment: Alignment.center,
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20.5),
          children: <Widget>[
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  color: Colors.purpleAccent.shade100,
                  borderRadius: BorderRadius.circular(15.0)),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Total per head",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "\$ ${calculateamtperhead(person, billamt, tippercentage)}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: 300,
              width: 500,
              margin: EdgeInsets.only(top: 20.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.blue.shade100,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: <Widget>[
                  TextField(
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.attach_money_rounded),
                        prefix: Text(
                          " Bill amt:  ",
                          style: TextStyle(
                            color: Colors.purple.shade300,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      onChanged: (String value) {
                        try {
                          billamt = double.parse(value);
                        } catch (exception) {
                          billamt = 0.0;
                        }
                      }),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Split",
                          style: TextStyle(
                            color: Colors.purple.shade300,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (person > 1) {
                                    person--;
                                  }
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.pink.shade100,
                                ),
                                child: Text(
                                  '-',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                "$person",
                                style: TextStyle(
                                  color: Colors.purple.shade300,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(
                                  () {
                                    person++;
                                  },
                                );
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.pink.shade100,
                                ),
                                child: Text(
                                  "+",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tip",
                          style: TextStyle(
                            color: Colors.purple.shade300,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 40),
                          child: Text(
                            "\$ ${calculatetotatltip(tippercentage, billamt)}",
                            style: TextStyle(
                              color: Colors.purple.shade300,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          "$tippercentage%",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.purple,
                          ),
                        ),
                        Slider(
                            value: tippercentage.toDouble(),
                            divisions: 100,
                            min: 0,
                            max: 100,
                            onChanged: (newvalue) {
                              setState(() {
                                tippercentage = newvalue.round();
                              });
                            })
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  calculateamtperhead(int split, double billamt, int tippercentage) {
    double totalamt =
        ((calculatetotatltip(tippercentage, billamt)) + billamt) / split;
    return totalamt;
  }

  calculatetotatltip(int tippercentage, double billamt) {
    double totaltip = 0.0;
    if (billamt < 0 || billamt.toString().isEmpty || billamt == null) {
    } else {
      totaltip = (billamt * tippercentage) / 100;
    }
    return totaltip;
  }
}
