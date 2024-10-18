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
      appBar: AppBar(
        title: const Text('Detail Rating'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Average  : ${widget.rating!.averageRating}",
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              "Total : ${widget.rating!.totalRating}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "Best :${widget.rating!.bestRating}",
              style: const TextStyle(fontSize: 18.0),
            ),
            _tombolHapusEdit()
          ],
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
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
      content: const Text("Are You Sure?"),
      actions: [
        //tombol hapus
        OutlinedButton(
          child: const Text("Yes"),
          onPressed: () {
            RatingBloc.deleteRating(id: widget.rating!.id!).then(
                (value) => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const RatingPage()))
                    }, onError: (error) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => const WarningDialog(
                        description: "Hapus gagal, silahkan coba lagi",
                      ));
            });
          },
        ),
        //tombol batal
        OutlinedButton(
          child: const Text("No"),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );

    showDialog(builder: (context) => alertDialog, context: context);
  }
}
