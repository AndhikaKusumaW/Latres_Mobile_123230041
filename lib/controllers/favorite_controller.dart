import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../models/show_model.dart';

class FavoriteController extends GetxController {
  final String boxName = 'favoritesBox';
  var favoriteList = <Show>[].obs;

  @override
  void onInit() {
    loadFavorites();
    super.onInit();
  }

  void loadFavorites() {
    var box = Hive.box(boxName);
    var list = box.values.map((e) {
      final map = Map<String, dynamic>.from(e);
      return Show.fromJson(map);
    }).toList();
    favoriteList.assignAll(list);
  }

  void toggleFavorite(Show show) {
    var box = Hive.box(boxName);
    if (box.containsKey(show.id)) {
      box.delete(show.id); // Hapus favorit [cite: 33]
    } else {
      box.put(show.id, show.toJson()); // Tambah favorit [cite: 28]
    }
    loadFavorites();
  }

  bool isFavorite(int id) {
    var box = Hive.box(boxName);
    return box.containsKey(id);
  }
}