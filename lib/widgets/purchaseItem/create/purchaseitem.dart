import 'package:flutter/material.dart';
import 'package:fluttergenerator/besiness_logic/models/ProductModel.dart';
import 'dart:developer';

import 'package:fluttergenerator/besiness_logic/models/PurchaseItemsModel.dart';
import 'package:fluttergenerator/besiness_logic/service/ProductService.dart';
import 'package:fluttergenerator/besiness_logic/service/PurchaseServiceItems.dart';

class PurchaseItemsWidget extends StatefulWidget {
  @override
  _PurchaseItemsWidgetState createState() => _PurchaseItemsWidgetState();
}

class _PurchaseItemsWidgetState extends State<PurchaseItemsWidget> {
  List<PurchaseItemModel> _items = [];

  String? _selectedProduct;
  double? _price;
  double? _quantity;
  ProductModel productModel=ProductModel();
  
  ProductService productService=ProductService();
  PurchaseServiceItems purchaseServiceItems =PurchaseServiceItems();
  List<ProductModel>? products;
  ProductModel? productselection;
  List<PurchaseItemModel>? purchaseItems;
  PurchaseItemModel purchaseItem =PurchaseItemModel();
  List<String> ? productNames;
  TextEditingController priseController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
 int edit=0;

 @override 
void initState() {
  super.initState();
  fetchProducts();
  fetchPurchase();

     
}

void fetchPurchase() async {
  List<PurchaseItemModel> purchaseItems = await purchaseServiceItems.fetchPurchaseItems();
     purchaseItems.forEach((purchaseitem){
    _items.add(purchaseitem);
    });
    setState(() {
      _items;
    });
}
void fetchProducts() async {
  products = await productService.fetchAllProduct();
  productNames = await products!
    .map((product) => product.reference)
    .whereType<String>()
    .toList();
}

List<DropdownMenuItem<String>> getDropdownItems() {
  if(productNames!=null){ 
    return productNames!.map((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
    }else {
    return <String>[' '].map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }
  
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _price = double.parse(value);
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Price',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                 
                ),
                 controller: priseController,
              ),
                SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: _selectedProduct,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedProduct = newValue;
                    products!.forEach((product){
                      if(product.reference==_selectedProduct){
                        productselection=product;
                      }
                  });
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Product',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                items: getDropdownItems(),
              ),
              SizedBox(height: 16.0),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _quantity = double.parse(value);
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Quantity',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                controller: quantityController,
              ),
              SizedBox(height: 16.0),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () async{
                    if(edit==0){
                 _addItem();
                    purchaseItem?.price=_price;
                    purchaseItem?.quantity=_quantity;
        
                        purchaseItem?.product=productselection;
                     
                    var result=await purchaseServiceItems.savePurchaseItems(purchaseItem);
                  
                     }else{
                      purchaseItem?.product=productselection;
                      
                      editItem(purchaseItem,double.parse(priseController.text),double.parse(quantityController.text));
                     }
                     edit=0;
                      priseController.clear();
                    quantityController.clear();
                    setState(() {
                      _selectedProduct=null;
                    });
                    
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add), // Icône à afficher
                      SizedBox(width: 8.0), // Espace entre l'icône et le texte
                      Text('ok'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.0),
               Container(
            decoration: BoxDecoration(
             border: Border.all(color: Colors.blue, width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(8.0)), // Optional: Add rounded corners
                ),
             child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) => Divider(
                  color: Colors.grey, // Couleur de la ligne
                  thickness: 1.0, // Épaisseur de la ligne
                ),
                shrinkWrap: true,
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  PurchaseItemModel item = _items[index];
                  return ListTile(
                    title: Text(item!.product?.reference ?? ''),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Price: ${item.price.toString()}'),
                        Text('Quantity: ${item.quantity.toString()}'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          color: Colors.green,
                          onPressed: () {
                            
                            priseController.text = item.price.toString();
                            quantityController.text = item.quantity.toString();
                            setState(() {
                            _selectedProduct = item.product?.reference;
                          });
                            
                            clickedItemForUpdate(item,double.parse(priseController.text),double.parse(quantityController.text));
                            
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
            ],
          ),
        ),
      ),
    );
  }

 void _addItem() {
  ProductModel? producttest;
  if (_selectedProduct != null && _price != null && _quantity != null) {
    setState(() {
      products!.forEach((product) {
        if (product.reference == _selectedProduct) {
          producttest = product;
        }
      });
      _items.add(
        PurchaseItemModel(
          product: producttest,
          price: _price!,
          quantity: _quantity!,
        ),
      );
      _selectedProduct = null;
  
    });
  }
}
void editItem(PurchaseItemModel item, double newPrice, double newQuantity) async {
  // Rechercher l'index de l'élément à modifier
    int index = _items.indexWhere((element) => element == item);


  // Vérifier si l'index est valide
  if (index != -1) {
    PurchaseItemModel updatedItem = PurchaseItemModel(
      product: item.product,
      price: newPrice,
      quantity: newQuantity,
    );
    _items[index] = updatedItem;
    setState(() {
      _items;
    });

    // Call the update method from the purchase service
    dynamic res =await purchaseServiceItems.updatedPurchaseItem(updatedItem);
  }
}
void clickedItemForUpdate(PurchaseItemModel item, double newPrice, double newQuantity) {
  // Rechercher l'index de l'élément à modifier
  int index = _items.indexOf(item);
purchaseItem=item;
  // Vérifier si l'index est valide
  if (index != -1) {
  
   PurchaseItemModel  updatedItem = PurchaseItemModel(
      product: item.product,
      price:double.parse(priseController.text),
      quantity:double.parse(quantityController.text),
    );
   // _items[index] = updatedItem;
 
   edit=1;
  }
}

  void _deleteItem(PurchaseItemModel item) {
    purchaseServiceItems.deletePurchaseItems(item);
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

