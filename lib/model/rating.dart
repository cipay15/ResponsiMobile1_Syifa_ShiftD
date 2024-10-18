class Rating {
  int? id;
  int? averageRating;
  int? totalRating;
  int? bestRating;

  Rating({this.id, this.averageRating, this.totalRating, this.bestRating});

  factory Rating.fromJson(Map<String, dynamic> obj) {
    return Rating(
      id: obj['id'] as int?,
      averageRating: obj['average_rating'] as int?,
      totalRating: obj['total_reviews'] as int?,
      bestRating: obj['best_seller_rank'] as int?,
    );
  }
}
