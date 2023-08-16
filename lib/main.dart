import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:fluttergenerator/widgets/purchase/list/PurchaseListWidget.dart';
import 'package:fluttergenerator/widgets/purchase/purchaseitem.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

enum ActiveTab { purchaseListWidget, purchaseItem }

class _MyAppState extends State<MyApp> {
  ActiveTab activeTab = ActiveTab.purchaseListWidget;
  Color _buttonColor1 = Colors.grey; // Couleur initiale du bouton
  Color _buttonColor2 = Colors.blue;
  void _changeColor1() {
    setState(() { 
        _buttonColor1=Colors.grey;
        _buttonColor2=Colors.blue;
    });
  }
  void _changeColor2() {
    setState(() {
        _buttonColor1=Colors.blue;
        _buttonColor2=Colors.grey;
    });
  }

  Widget _buildActiveWidget() {
    switch (activeTab) {
      case ActiveTab.purchaseListWidget:
        return purchaseListWidget();
      case ActiveTab.purchaseItem:
        return PurchaseItemsWidget();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      home: Scaffold(
        body: Column(
          children: [
            SizedBox(height:24.0),
            Container(
              color:Colors.blue,
              child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                        primary:_buttonColor1, // Couleur de fond
                         ),
                  onPressed: () {
                    setState(() {
                      activeTab = ActiveTab.purchaseListWidget;
                    });
                    _changeColor1();
                    
                  },
                  child: Text('Purchase'),
                ),
                ElevatedButton(
                  style:ElevatedButton.styleFrom(
                    primary:_buttonColor2,
                  ),
                  onPressed: () {
                    setState(() {
                      activeTab = ActiveTab.purchaseItem;
                    });
                    _changeColor2();
                  },
                  child: Text('Purchase Item'),
                ),
              ],
            ),
            ),
            
            Expanded(
              child: _buildActiveWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

