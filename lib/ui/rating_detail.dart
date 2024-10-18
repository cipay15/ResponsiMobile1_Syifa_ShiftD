import 'package:flutter/material.dart';
import '../bloc/rating_bloc.dart';
import '../widget/warning_dialog.dart';
import '/model/rating.dart';
import '/ui/rating_form.dart';
import 'rating_page.dart';

// ignore: must_be_immutable
class RatingDetail extends StatefulWidget {
  Rating? rating;

  RatingDetail({Key? key, this.rating}) : super(key: key);

  @override
  _RatingDetailState createState() => _RatingDetailState();
}

class _RatingDetailState extends State<RatingDetail> {
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
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: const EdgeInsets.all(16.0),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Detail Rating',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildDetailText(
                        "Average Rating: ${widget.rating!.averageRating}",
                        20.0),
                    _buildDetailText(
                        "Total Reviews: ${widget.rating!.totalRating}", 18.0),
                    _buildDetailText(
                        "Best Seller Rank: ${widget.rating!.bestRating}", 18.0),
                    const SizedBox(height: 20),
                    _tombolHapusEdit(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailText(String text, double fontSize) {
    return Text(
      text,
      style: TextStyle(fontSize: fontSize),
      textAlign: TextAlign.center,
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Tombol Edit
        OutlinedButton(
          child: const Text("EDIT"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RatingForm(
                  rating: widget.rating!,
                ),
              ),
            );
          },
        ),
        // Tombol Hapus
        OutlinedButton(
          child: const Text("DELETE"),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Are You Sure To Delete This Rating?"),
      actions: [
        // Tombol hapus
        OutlinedButton(
          child: const Text("Yes"),
          onPressed: () {
            RatingBloc.deleteRating(id: widget.rating!.id!).then((value) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const RatingPage(),
              ));
            }, onError: (error) {
              showDialog(
                context: context,
                builder: (BuildContext context) => const WarningDialog(
                  description: "Hapus gagal, silahkan coba lagi",
                ),
              );
            });
          },
        ),
        // Tombol batal
        OutlinedButton(
          child: const Text("No"),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );

    showDialog(builder: (context) => alertDialog, context: context);
  }
}
