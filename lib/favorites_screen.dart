import 'package:flutter/material.dart';
import 'package:motivational_quotes_app/quote_provider.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = context.watch<QuoteProvider>().favorites;
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Quotes', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),),
        backgroundColor: Colors.brown,
      ),
      body: favoritesProvider.isEmpty
          ? const Center(child: Text('No favorites yet.', style: TextStyle(fontSize: 20),))
          : ListView.builder(
        itemCount: favoritesProvider.length,
        itemBuilder: (_, index) {
          final quote = favoritesProvider[index];
          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ListTile(
              title: Text('"${quote.text}"', style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),),
              subtitle: Text('- ${quote.author}', style: TextStyle(fontSize: 18),),
              trailing: IconButton(
                icon: const Icon(Icons.delete, size: 30,),
                color: Colors.red,
                onPressed: () {
                  Provider.of<QuoteProvider>(context, listen: false)
                      .toggleFavorite(quote);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/1.1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      showCloseIcon: true,
                      closeIconColor: Colors.white,
                      backgroundColor: Colors.pinkAccent,
                      content: Text('Quote removed from Favorites', style: TextStyle(fontSize: 20),),
                      duration: Duration(seconds: 1),  // Duration for how long the SnackBar will be visible
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
