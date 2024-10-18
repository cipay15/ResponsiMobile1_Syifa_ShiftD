import 'dart:convert';
import '/helpers/api.dart';
import '/helpers/api_url.dart';
import '/model/rating.dart';

class RatingBloc {
  static Future<List<Rating>> getRatings() async {
    String apiUrl = ApiUrl.listRating;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listRating = (jsonObj as Map<String, dynamic>)['data'];
    List<Rating> ratings = [];

    for (int i = 0; i < listRating.length; i++) {
      ratings.add(Rating.fromJson(listRating[i]));
    }
    return ratings;
  }

  static Future<bool> addRating({required Rating rating}) async {
    String apiUrl = ApiUrl.createRating;

    var body = {
      "average_rating": rating.averageRating.toString(),
      "total_reviews": rating.totalRating.toString(),
      "best_seller_rank": rating.bestRating.toString(),
    };

    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'] == 'success';
  }

  static Future<bool> updateRating({required Rating rating}) async {
    String apiUrl = ApiUrl.updateRating(rating.id!);

    var body = {
      "average_rating": rating.averageRating.toString(),
      "total_reviews": rating.totalRating.toString(),
      "best_seller_rank": rating.bestRating.toString(),
    };

    var response = await Api().put(apiUrl, jsonEncode(body));
    var jsonObj = json.decode(response.body);
    return jsonObj['status'] == 'success';
  }

  static Future<bool> deleteRating({required int id}) async {
    String apiUrl = ApiUrl.deleteRating(id);
    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'] == 'success';
  }
}
