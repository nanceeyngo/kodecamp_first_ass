import 'package:flutter/material.dart';
import 'package:motivational_quotes_app/quote_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quoteProvider = context.watch<QuoteProvider>();
    final quote = quoteProvider.dailyQuote;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("Daily Quote", style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.favorite),
              color: Colors.white,
              onPressed: () {
                Navigator.pushNamed(context, '/favorites');
              },
            ),
          )
        ],
      ),
      body: quote == null ?
          const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Text(
                '"${quote.text}"',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            Text('- ${quote.author}', style: TextStyle(fontSize: 20,),),
            const SizedBox(height: 20),
            IconButton(
              icon: Icon(
                quote.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
                size: 30,
              ),
              onPressed: () {
                quoteProvider.toggleFavorite(quote);
                quote.isFavorite?
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
                    content: Text('Quote added to Favorites', style: TextStyle(fontSize: 20),),
                    duration: Duration(seconds: 1),  // Duration for how long the SnackBar will be visible
                  ),
                ):
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
            )
          ],
        ),
      ),
    );
  }
}
