import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:deribit_trader/send_orders.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deribit Trader lol!',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text("Deribit Tradeur :}"),),
        body: Column(
          children: <Widget>[
            Row(  // Contract selection
              children: <Widget>[
                Column(   // Combobox?
                  children: <Widget>[Slider(value: 0, min: 0, max: 16, onChanged: (val)=>print("Slider changed lol: $val"))],
                ),
                Column(   // "x 1000 contracts" text
                  children: <Widget>[Text("x 1000 contracts")],
                )
              ],
            ),
            Row(  // Mkt buy+sell buttons
              children: <Widget>[
                Column(   // mkt BUY button
                  children: <Widget>[BuyButton()],
                ),
                Column(   // mkt SELL button
                  children: <Widget>[BuyButton()],  //TODO: change to sell
                )
              ],
            )
          ],
        ),
      )
//      home: MyHomePage(title: 'Hopefully a button shows up here'),
    );
  }
}












/*
------------------THIS IS ALL OLD CODE BELOW THIS LINE!!!-----------------------
 */





final DeribitClient client = DeribitClient();



class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  MyHomePageState createState() => MyHomePageState();
}


class MyHomePageState extends State<MyHomePage> {
  String price = 'NOTHING YET LOL';
  Future<String> priceFut = client.getIndex();

//  FutureBuilder<String> apiResult = FutureBuilder(
//    future: client.getIndex(),
//    builder: (context, snapshot) {
//      return Text('${snapshot.data}');
//    }
//  );

  @override
  void initState() {
    super.initState();
    priceFut.then((val) => this.setPrice(val));
//    .catchError(onError);
  }

  void setPrice(String price) {
    setState(() {
      this.price = price;
      print(this.price);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(price),
              BuyButton(),
              RaisedButton(
                  onPressed: () {
                    client.getIndex().then((val) => this.setPrice(val));
                  },
                  child: Text("Refresh price lol")),
//              FlatButton(onPressed: ()=> print("pressed FlatButton(2)"), child: Text("FlatButton")),
//              RaisedButton(onPressed: ()=> print("pressed RaisedButton(3)"), child: Text("RaisedButton"))
            ],
          )
      ),
    );
  }
}


class BuyButton extends StatelessWidget{

  void doStuff() {
    print("pressed BuyButton");
//    String price = await client.getIndex();

//    print(price);
  }

  @override
  Widget build(BuildContext context) {
    return RaisedButton(onPressed: doStuff, child: Text("Market Buy"));
  }
}