import 'package:flutter/material.dart';  
import 'flashcard_provider.dart';  
import 'flashcard.dart';  
import 'package:provider/provider.dart';  

class AddEditFlashcard extends StatelessWidget {  
  final int? index;  

  AddEditFlashcard({this.index});  

  final TextEditingController questionController = TextEditingController();  
  final TextEditingController answerController = TextEditingController();  

  @override  
  Widget build(BuildContext context) {  
    final flashcardProvider = Provider.of<FlashcardProvider>(context);  

    // Set default question and answer only when adding a new flashcard  
    if (index == null) {  
      // Pre-populate with default question and answer  
      questionController.text = "What is your name?";  
      answerController.text = "SRS";  
    } else {  
      final flashcard = flashcardProvider.flashcards[index!];  
      questionController.text = flashcard.question;  
      answerController.text = flashcard.answer;  
    }  

    return Scaffold(  
      appBar: AppBar(title: Text(index == null ? 'Add Flashcard' : 'Edit Flashcard')),  
      body: Padding(  
        padding: EdgeInsets.all(16.0),  
        child: Column(  
          children: [  
            TextField(  
              controller: questionController,  
              decoration: InputDecoration(labelText: 'Question'),  
            ),  
            TextField(  
              controller: answerController,  
              decoration: InputDecoration(labelText: 'Answer'),  
            ),  
            SizedBox(height: 20),  
            ElevatedButton(  
              onPressed: () {  
                if (questionController.text.isEmpty) {  
                  ScaffoldMessenger.of(context).showSnackBar(  
                    SnackBar(content: Text('Question cannot be empty')),  
                  );  
                  return;  
                }  

                final flashcard = Flashcard(  
                  question: questionController.text,  
                  answer: answerController.text,  
                );  

                if (index == null) {  
                  flashcardProvider.addFlashcard(flashcard);  
                } else {  
                  flashcardProvider.editFlashcard(index!, flashcard);  
                }  

                Navigator.of(context).pop();  
              },  
              child: Text(index == null ? 'Add' : 'Save'),  
            ),  
          ],  
        ),  
      ),  
    );  
  }  
}