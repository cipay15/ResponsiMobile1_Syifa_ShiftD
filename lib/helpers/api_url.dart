class ApiUrl {
  static const String baseUrl = 'http://responsi.webwizards.my.id/api/buku';
  static const String listRating = baseUrl + '/rating';
  static const String createRating = baseUrl + '/rating';

  static const String registrasi =
      'http://responsi.webwizards.my.id/api/registrasi';
  static const String login = 'http://responsi.webwizards.my.id/api/login';

  static String showRating(int id) {
    return baseUrl + '/rating/' + id.toString();
  }

  static String updateRating(int id) {
    return baseUrl + '/rating/' + id.toString() + '/update';
  }

  static String deleteRating(int id) {
    return baseUrl + '/rating/' + id.toString() + '/delete';
  }
}
