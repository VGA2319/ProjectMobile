import '../models/wisata.dart';

class FavoriteData {
  static List<Wisata> favorites = [];

  static bool isFavorite(Wisata wisata) {
    return favorites.any((item) => item.name == wisata.name);
  }

  static void toggleFavorite(Wisata wisata) {
    if (isFavorite(wisata)) {
      favorites.removeWhere((item) => item.name == wisata.name);
    } else {
      favorites.add(wisata);
    }
  }
}