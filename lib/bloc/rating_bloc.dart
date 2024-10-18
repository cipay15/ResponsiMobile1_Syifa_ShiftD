import 'dart:convert';
import '/helpers/api.dart';
import '/helpers/api_url.dart';
import '/model/rating.dart';
// Pastikan Produk di-import jika belum

class RatingBloc {
  static Future<List<Rating>> getRatings() async {
    String apiUrl = ApiUrl.listRating;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listRating = (jsonObj as Map<String, dynamic>)['data'];
    List<Rating> ratings = []; // Perbaikan penamaan dari rating ke ratings
    for (int i = 0; i < listRating.length; i++) {
      ratings.add(Rating.fromJson(listRating[i])); // Perbaikan variabel
    }
    return ratings;
  }

  static Future<bool> addRating({required Rating rating}) async {
    // Ganti Rating? ke Rating
    String apiUrl = ApiUrl.createRating;

    var body = {
      "average_rating": rating.averageRating,
      "total_reviews": rating.totalRating, // Gunakan rating
      "best_seller_rank": rating.bestRating.toString() // Gunakan rating
    };

    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'] ==
        'success'; // Sesuaikan dengan status yang diharapkan
  }

  static Future<bool> updateRating({required Rating rating}) async {
    String apiUrl = ApiUrl.updateRating(rating.id!);
    print(apiUrl);

    var body = {
      "average_rating": rating.averageRating,
      "total_reviews": rating.totalRating,
      "best_seller_rank": rating.bestRating
    };
    print("Body : $body");
    var response = await Api().put(apiUrl, jsonEncode(body));
    var jsonObj = json.decode(response.body);
    return jsonObj['status'] ==
        'success'; // Sesuaikan dengan status yang diharapkan
  }

  static Future<bool> deleteRating({required int id}) async {
    // Ganti int? ke required int
    String apiUrl = ApiUrl.deleteRating(id);

    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['data']; // Pastikan ini boolean
  }
}
