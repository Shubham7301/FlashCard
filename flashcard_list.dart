import 'package:flutter/material.dart';  
import 'add_edit_flashcard.dart';  
import 'flashcard_provider.dart';  
import 'package:provider/provider.dart';  

class FlashcardList extends StatelessWidget {  
  @override  
  Widget build(BuildContext context) {  
    final flashcardProvider = Provider.of<FlashcardProvider>(context);  

    return Scaffold(  
      appBar: AppBar(title: Text('Flashcards')),  
      body: ListView.builder(  
        itemCount: flashcardProvider.flashcards.length,  
        itemBuilder: (context, index) {  
          final flashcard = flashcardProvider.flashcards[index];  
          return Card(  
            child: ListTile(  
              title: Text(flashcard.question),  
              subtitle: Text('Tap to see answer'),  
              onTap: () => _showAnswerDialog(context, flashcard.answer),  
              trailing: Row(  
                mainAxisSize: MainAxisSize.min,  
                children: [  
                  IconButton(  
                    icon: Icon(Icons.edit),  
                    onPressed: () {  
                      Navigator.of(context).push(MaterialPageRoute(  
                        builder: (context) => AddEditFlashcard(index: index),  
                      ));  
                    },  
                  ),  
                  IconButton(  
                    icon: Icon(Icons.delete),  
                    onPressed: () {  
                      _confirmDelete(context, index);  
                    },  
                  ),  
                ],  
              ),  
            ),  
          );  
        },  
      ),  
      floatingActionButton: FloatingActionButton(  
        onPressed: () {  
          Navigator.of(context).push(MaterialPageRoute(  
            builder: (context) => AddEditFlashcard(),  
          ));  
        },  
        child: Icon(Icons.add),  
      ),  
    );  
  }  

  void _showAnswerDialog(BuildContext context, String answer) {  
    showDialog(  
      context: context,  
      builder: (context) => AlertDialog(  
        title: Text('Answer'),  
        content: Text(answer),  
        actions: [  
          TextButton(  
            onPressed: () => Navigator.of(context).pop(),  
            child: Text('Close'),  
          ),  
        ],  
      ),  
    );  
  }  

  void _confirmDelete(BuildContext context, int index) {  
    showDialog(  
      context: context,  
      builder: (context) => AlertDialog(  
        title: Text('Confirm Delete'),  
        content: Text('Are you sure you want to delete this flashcard?'),  
        actions: [  
          TextButton(  
            onPressed: () {  
              Provider.of<FlashcardProvider>(context, listen: false)  
                  .deleteFlashcard(index);  
              Navigator.of(context).pop();  
            },  
            child: Text('Yes'),  
          ),  
          TextButton(  
            onPressed: () => Navigator.of(context).pop(),  
            child: Text('No'),  
          ),  
        ],  
      ),  
    );  
  }  
}