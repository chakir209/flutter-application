import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttergenerator/besiness_logic/models/ClientModel.dart';
import 'package:fluttergenerator/besiness_logic/models/PurchaseModel.dart';
import 'package:fluttergenerator/besiness_logic/service/ClientService.dart';
import 'package:fluttergenerator/besiness_logic/service/PurchaseService.dart';
import 'package:fluttergenerator/main.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
class Purchase extends StatefulWidget {
  @override
  _PurchaseState createState() => _PurchaseState();
}

class _PurchaseState extends State<Purchase> {
  String reference = '';
  DateTime purchaseDate = DateTime(2023);
  double total = 0;
  String client = '';
  String description = '';
  String? _selectedClient;
  String ? _selectedTag;
  PurchaseModel purchaseModel = PurchaseModel();
  final PurchaseService purchaseService = PurchaseService();
  final ClientService clientService = ClientService();
  List<ClientModel>? clients;
  List<String> ?clientNames ;
  TextEditingController referenceController = TextEditingController();
  TextEditingController referenceController2 = TextEditingController();
  TextEditingController referenceController3 = TextEditingController();
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  File? selectedImage;
 @override
void initState() {
  super.initState();
  fetchClients();
     
}
void _resetFormFields() {
  setState(() {
    reference = '';
    purchaseDate = DateTime(2023);
    total = 0;
    client = '';
    description = '';
    _selectedClient = null;
    _selectedTag = null;
  });
}
void fetchClients() async {
  clients = await clientService.fetchAllClient();
  clientNames = await clients!
    .map((client) => client.fullName)
    .whereType<String>()
    .toList();
}
 List<DropdownMenuItem<String>> getDropdownItems() {
  if (clientNames != null) {
    return clientNames!.map((String value) {
      return DropdownMenuItem<String>(
        value: value,

        child: Text(value),
      );
    }).toList();
  } else {
    return <String>[' '].map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }
}
 List<DropdownMenuItem<String>> getDropdownItemsTag() {
   
    return <String>[' reference1',' reference2'].map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
}
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height:60.0),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Référence',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          reference = value;
                        });
                      },
                      controller: referenceController,
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Date d\'achat',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onTap: () {
                        // Ouvrir le sélecteur de date
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        ).then((selectedDate) {
                          // Mettre à jour la valeur de la date sélectionnée
                          if (selectedDate != null) {
                            setState(() {
                              purchaseDate = selectedDate;
                            });
                          }
                        });
                      },
                      controller: TextEditingController(text: _dateFormat.format(purchaseDate)),
                      readOnly: true, // Empêcher la saisie manuelle
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                    onPressed: _pickImageFromGallery,
                      child: Text('Choisir une image'),
                    ),
                
                    selectedImage != null
                  ? Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          image: FileImage(selectedImage!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : SizedBox(),
                    SizedBox(height: 16.0),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Total',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          total = double.parse(value);
                        });
                      },
                      controller: referenceController2
                      ,
                    ),
                    SizedBox(height: 16.0),
                    
                 
                    DropdownButtonFormField<String>(
                      value: _selectedClient,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedClient = newValue;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Client',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      //a compli  .....
                      items: getDropdownItems(),
            
                    ),
                    SizedBox(height: 16.0),
                    DropdownButtonFormField<String>(
                      value: _selectedTag,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedTag = newValue;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Tag',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      //a compli  .....
                      items: getDropdownItemsTag(),
            
                    ),
                    SizedBox(height: 16.0),
                    Container(
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            description = value;
                          });
                        },
                        controller: referenceController3,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () async{
                            purchaseModel.reference = reference;
                           // purchaseModel.purchaseDate = purchaseDate;
                            purchaseModel.total = total;
                            purchaseModel.description = description;
                            clients!.map((client) {
  if (client.fullName == _selectedClient) {
    purchaseModel.client = client;
  } 
  return purchaseModel;
}).toList();
                            purchaseModel.image="";

                           var result= await purchaseService.postData(purchaseModel);
                           _resetFormFields();
                           referenceController.clear();
                           referenceController2.clear();
                           referenceController3.clear();
                           _selectedClient = null;
                           _selectedTag = null;

                            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyApp()
            ),
          );
                          },
                          child: Text('Valider'),
                        ),
                        SizedBox(width: 16.0),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                          ),
                          onPressed: () {
                                     Navigator.push(
                                       context,
                                     MaterialPageRoute(builder: (context) => MyApp()
                            ),
                           );
                          },
                          child: Text('Annuler'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        selectedImage = File(pickedImage.path);
      });
    } else {
      // Aucune photo n'a été sélectionnée
    }
  }


}