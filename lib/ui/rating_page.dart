import 'package:flutter/material.dart';
import '../bloc/logout_bloc.dart';
import '../bloc/rating_bloc.dart';
import '/model/rating.dart';
import '/ui/rating_detail.dart';
import '/ui/rating_form.dart';
import 'login_page.dart';

class RatingPage extends StatefulWidget {
  const RatingPage({Key? key}) : super(key: key);

  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.red,
              Colors.orange,
              Colors.yellow,
              Colors.green,
              Colors.blue,
              Colors.indigo,
              Colors.purple,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            AppBar(
              title: const Text('List Rating'),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    child: const Icon(Icons.add, size: 26.0),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RatingForm()),
                      );
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              child: FutureBuilder<List<Rating>>(
                future: RatingBloc.getRatings(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text('Error loading ratings'));
                  }
                  final ratings = snapshot.data ?? [];
                  return ListView.builder(
                    itemCount: ratings.length,
                    itemBuilder: (context, index) {
                      return ItemRating(rating: ratings[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Logout'),
              trailing: const Icon(Icons.logout),
              onTap: () async {
                await LogoutBloc.logout();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ItemRating extends StatelessWidget {
  final Rating rating;

  const ItemRating({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RatingDetail(rating: rating),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: ListTile(
          title: Text('Average Rating: ${rating.averageRating}'),
          subtitle: Text('Total Reviews: ${rating.totalRating}'),
          trailing: Text('Best Rating: ${rating.bestRating}'),
        ),
      ),
    );
  }
}
