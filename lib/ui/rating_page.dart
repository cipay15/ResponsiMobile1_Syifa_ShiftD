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
      appBar: AppBar(
        title: const Text('List Rating'),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                child: const Icon(Icons.add, size: 26.0),
                onTap: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RatingForm()));
                },
              ))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Logout'),
              trailing: const Icon(Icons.logout),
              onTap: () async {
                await LogoutBloc.logout().then((value) => {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => LoginPage()),
                          (route) => false)
                    });
              },
            )
          ],
        ),
      ),
      body: FutureBuilder<List>(
        future: RatingBloc.getRatings(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListRating(
                  list: snapshot.data,
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ListRating extends StatelessWidget {
  final List? list;

  const ListRating({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list!.length,
        itemBuilder: (context, i) {
          return ItemRating(
            rating: list![i],
          );
        });
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
                builder: (context) => RatingDetail(
                      rating: rating,
                    )));
      },
      child: Card(
        child: ListTile(
          title: Text(rating.averageRating.toString()),
          subtitle: Text(rating.totalRating.toString()),
          trailing: Text(rating.bestRating.toString()),
        ),
      ),
    );
  }
}
