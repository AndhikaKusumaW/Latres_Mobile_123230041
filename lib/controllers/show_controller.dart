import 'package:get/get.dart';
import '../models/show_model.dart';
import '../services/api_service.dart';

class ShowController extends GetxController {
  var shows = <Show>[].obs;
  var isLoading = true.obs;
  var showDetail = Rxn<Show>();
  var isDetailLoading = false.obs;

  @override
  void onInit() {
    getShows();
    super.onInit();
  }

  void getShows() async {
    try {
      isLoading(true);
      var result = await ApiService.fetchShows();
      shows.assignAll(result);
    } finally {
      isLoading(false);
    }
  }

  void getShowDetail(int id) async {
    try {
      isDetailLoading(true);
      var result = await ApiService.fetchShowDetails(id);
      showDetail.value = result;
    } finally {
      isDetailLoading(false);
    }
  }
}