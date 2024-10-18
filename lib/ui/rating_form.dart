import 'package:flutter/material.dart';
import 'package:buku/model/rating.dart';
import '../bloc/rating_bloc.dart';
import '../widget/warning_dialog.dart';
import 'rating_page.dart';

class RatingForm extends StatefulWidget {
  final Rating? rating;

  RatingForm({Key? key, this.rating}) : super(key: key);

  @override
  _RatingFormState createState() => _RatingFormState();
}

class _RatingFormState extends State<RatingForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "Add Rating";
  String tombolSubmit = "Save";
  final _averageRatingTextboxController = TextEditingController();
  final _totalRatingTextboxController = TextEditingController();
  final _bestRatingTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  @override
  void dispose() {
    _averageRatingTextboxController.dispose();
    _totalRatingTextboxController.dispose();
    _bestRatingTextboxController.dispose();
    super.dispose();
  }

  void isUpdate() {
    if (widget.rating != null) {
      setState(() {
        judul = "Change Rating";
        tombolSubmit = "Change";
        _averageRatingTextboxController.text =
            widget.rating!.averageRating.toString();
        _totalRatingTextboxController.text =
            widget.rating!.totalRating.toString();
        _bestRatingTextboxController.text =
            widget.rating!.bestRating.toString();
      });
    } else {
      judul = "ADD RATING";
      tombolSubmit = "Save";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _averageRatingTextField(),
                _totalRatingTextField(),
                _bestRatingTextField(),
                _buttonSubmit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _averageRatingTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Average Rating"),
      keyboardType: TextInputType.number,
      controller: _averageRatingTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Average Rating harus diisi";
        }
        return null;
      },
    );
  }

  Widget _totalRatingTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Total Reviews"),
      keyboardType: TextInputType.number,
      controller: _totalRatingTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Total Reviews harus diisi";
        }
        return null;
      },
    );
  }

  Widget _bestRatingTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Best Seller Rank"),
      keyboardType: TextInputType.number,
      controller: _bestRatingTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Best Seller Rank Harus diisi";
        }
        return null;
      },
    );
  }

  Widget _buttonSubmit() {
    return OutlinedButton(
      child: Text(tombolSubmit),
      onPressed: () {
        var validate = _formKey.currentState!.validate();
        if (validate) {
          if (!_isLoading) {
            if (widget.rating != null) {
              // Kondisi update produk
              // Tambahkan logika update produk di sini
            } else {
              simpan();
            }
          }
        }
      },
    );
  }

  void simpan() {
    setState(() {
      _isLoading = true;
    });
    Rating createRating = Rating(id: null);
    createRating.averageRating =
        int.tryParse(_averageRatingTextboxController.text) ?? 0;
    createRating.totalRating =
        int.tryParse(_totalRatingTextboxController.text) ?? 0;
    createRating.bestRating =
        int.tryParse(_bestRatingTextboxController.text) ?? 0;

    RatingBloc.addRating(rating: createRating).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => const RatingPage(),
      ));
    }, onError: (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Simpan gagal, silahkan coba lagi",
        ),
      );
    }).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }
}
