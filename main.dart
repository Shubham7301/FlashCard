import 'package:flutter/material.dart';  
import 'package:provider/provider.dart';  
import 'flashcard_provider.dart';  
import 'flashcard_list.dart'; 
import 'add_edit_flashcard.dart';  

void main() {  
  runApp(MyApp());  
}  

class MyApp extends StatelessWidget {  
  @override  
  Widget build(BuildContext context) {  
    return ChangeNotifierProvider(  
      create: (context) => FlashcardProvider(),  
      child: MaterialApp(  
        title: 'Flashcard App',  
        theme: ThemeData(primarySwatch: Colors.blue),  
        home: FlashcardList(),  
      ),  
    );  
  }  
}