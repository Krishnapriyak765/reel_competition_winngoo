class Review {
  final int rating;
  final String review;

  Review({required this.rating, required this.review});

  Map<String, dynamic> toJson() {
    return {'rating': rating, 'review': review};
  }
}
