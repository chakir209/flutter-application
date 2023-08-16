import 'package:flutter/material.dart';
import 'package:fluttergenerator/besiness_logic/models/ProductModel.dart';
import 'dart:developer';

import 'package:fluttergenerator/besiness_logic/models/PurchaseModel.dart';
import 'package:fluttergenerator/besiness_logic/service/ProductService.dart';
import 'package:fluttergenerator/besiness_logic/service/PurchaseService.dart';
import 'package:fluttergenerator/widgets/purchase/create/purchase.dart';

class purchaseListWidget extends StatefulWidget {
  @override
  _PurchaseListWidgetState createState() => _PurchaseListWidgetState();
}

class _PurchaseListWidgetState extends State<purchaseListWidget> {
  List<PurchaseModel> _items = [];

  String? _selectedReference;
  double? total;
  String? description;
  String? reference;
  ProductModel productModel=ProductModel();
  
  ProductService productService=ProductService();
  PurchaseService purchaseService =PurchaseService();
  List<ProductModel>? products;
  ProductModel? productselection;
  List<String> ? productNames;
  TextEditingController referenceController = TextEditingController();
  TextEditingController totalController = TextEditingController();
 int edit=0;

 @override 
void initState() {
  super.initState();
  fetchPurchase();

     
}

void fetchPurchase() async {
  List<PurchaseModel> purchases = await purchaseService.fetchAllPurchase();
     purchases.forEach((purchase){
    _items.add(purchase);
    });
    setState(() {
      _items;
    });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
        
              SizedBox(height: 16.0),
              Text('Purchase List:',style:TextStyle(
                fontSize:19,
                color:Colors.blue,
                fontWeight:FontWeight.bold,
              ),
              textAlign: TextAlign.left,
              ),
              SizedBox(height:10.0),
            Container(
  decoration: BoxDecoration(
    border: Border.all(color: Colors.blue, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(8.0)), // Optional: Add rounded corners
  ),
             child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) => Divider(
                  color: Colors.blue, // Couleur de la ligne
                  thickness: 1.0, // Épaisseur de la ligne
                ),
                shrinkWrap: true,
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  PurchaseModel item = _items[index];
                  return ListTile(
                    title: Text(item!.reference ?? ''),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('total: ${item.total.toString()}'),
                        Text('description: ${item.description.toString()}'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          color: Colors.green,
                          onPressed: () {
                            
                            referenceController.text = item.reference.toString();
                            totalController.text = item.total.toString();
                            setState(() {
                            _selectedReference = item.reference;
                          });
                            
                            clickedItemForUpdate(item,double.parse(referenceController.text),double.parse(totalController.text));
                            
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          color: Colors.red,
                          onPressed: () {
                            _deleteItem(item);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
              SizedBox(height: 16.0),
              /*
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _validate();
                    },
                    child: Text('Validate'),
                  ),
                  SizedBox(width: 16.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red, // Couleur de fond
                    ),
                    onPressed: () {
                      _cancel();
                    },
                    child: Text('Cancel'),
                  ),
                ],
              ),
              */
        
    
            ],
          ),
        ),
      ),
            floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Naviguez vers le widget MyRedirectedWidget lorsqu'on appuie sur le bouton
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Purchase()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

 void _addItem() {
  ProductModel? producttest;
  if (_selectedReference != null && description != null && description != null) {
    setState(() {
      products!.forEach((product) {
        if (reference == _selectedReference) {
          producttest = product;
        }
      });
      _items.add(
        PurchaseModel(
          reference: reference!,
          total: total!,
          description: description!,
        ),
      );
      _selectedReference = null;
  
    });
  }
}
void editItem(PurchaseModel item, String reference, double total ,String description) async {
  // Rechercher l'index de l'élément à modifier
    int index = _items.indexWhere((element) => element == item);


  // Vérifier si l'index est valide
  if (index != -1) {
    PurchaseModel updatedItem = PurchaseModel(
       reference: reference!,
          total: total!,
          description: description!,
    );
    _items[index] = updatedItem;
    setState(() {
      _items;
    });

    // Call the update method from the purchase service
   // dynamic res =await purchaseServiceItems.updatedPurchaseItem(updatedItem);
  }
}
void clickedItemForUpdate(PurchaseModel item, double newPrice, double newQuantity) {
 /* // Rechercher l'index de l'élément à modifier
  int index = _items.indexOf(item);
purchaseItem=item;
  // Vérifier si l'index est valide
  if (index != -1) {
  
   PurchaseItemModel  updatedItem = PurchaseItemModel(
      product: item.product,
      price:double.parse(referenceController.text),
      quantity:double.parse(totalController.text),
    );
   // _items[index] = updatedItem;
 */
   edit=1;
  //}
}

  void _deleteItem(PurchaseModel item) async {
   dynamic res= await purchaseService.deletePurchase(item);
    _items.remove(item);
    setState(() {
      _items;
    });
     

  }

  void _validate() {
    // Implémentez ici la logique pour valider l'achat
  }

  void _cancel() {
    setState(() {
      _items.clear();
    });
  }
}

