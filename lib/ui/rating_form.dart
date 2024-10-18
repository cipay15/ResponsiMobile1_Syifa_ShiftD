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

  // Menyimpan warna untuk label
  final List<Color> rainbowColors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ];
  late Color averageRatingColor;
  late Color totalRatingColor;
  late Color bestRatingColor;

  final _averageRatingTextboxController = TextEditingController();
  final _totalRatingTextboxController = TextEditingController();
  final _bestRatingTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
    _initializeColors();
  }

  void _initializeColors() {
    averageRatingColor = rainbowColors[0];
    totalRatingColor = rainbowColors[1];
    bestRatingColor = rainbowColors[2];
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
    }
  }

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
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        judul,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _averageRatingTextField(),
                      const SizedBox(height: 16),
                      _totalRatingTextField(),
                      const SizedBox(height: 16),
                      _bestRatingTextField(),
                      const SizedBox(height: 20),
                      _buttonSubmit(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _averageRatingTextField() {
    return _buildTextField(
        "Average Rating", _averageRatingTextboxController, averageRatingColor);
  }

  Widget _totalRatingTextField() {
    return _buildTextField(
        "Total Reviews", _totalRatingTextboxController, totalRatingColor);
  }

  Widget _bestRatingTextField() {
    return _buildTextField(
        "Best Seller Rank", _bestRatingTextboxController, bestRatingColor);
  }

  Widget _buildTextField(
      String label, TextEditingController controller, Color labelColor) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: labelColor),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: labelColor),
        ),
      ),
      keyboardType: TextInputType.number,
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return "$label harus diisi";
        }
        return null;
      },
    );
  }

  Widget _buttonSubmit() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12),
          backgroundColor: Colors.blueAccent,
        ),
        child: Text(tombolSubmit),
        onPressed: () {
          var validate = _formKey.currentState!.validate();
          if (validate) {
            if (!_isLoading) {
              if (widget.rating != null) {
                // Tambahkan logika update produk di sini jika diperlukan
              } else {
                simpan();
              }
            }
          }
        },
      ),
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
