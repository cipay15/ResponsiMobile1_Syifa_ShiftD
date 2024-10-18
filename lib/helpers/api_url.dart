class ApiUrl {
  static const String baseUrl = 'http://103.196.155.42/';
  static const String registrasi = baseUrl + 'api/registrasi';
  static const String login = baseUrl + 'api/login';
  static const String listRating = baseUrl + 'api/buku/rating';
  static const String createRating = baseUrl + 'api/buku/rating';

  static String updateRating(int id) {
    return baseUrl + 'api/buku/rating/' + id.toString() + '/update';
  }

  static String showRating(int id) {
    return baseUrl + 'api/buku/rating' + id.toString();
  }

  static String deleteRating(int id) {
    return baseUrl + 'api/buku/rating/' + id.toString() + '/delete';
  }
}
