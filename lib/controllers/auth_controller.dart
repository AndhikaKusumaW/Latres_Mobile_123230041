import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../views/login_page.dart';
import '../views/main_page.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;
  var username = ''.obs;

  @override
  void onInit() {
    checkLoginStatus();
    super.onInit();
  }

  void checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoggedIn.value = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn.value) {
      username.value = prefs.getString('username') ?? '';
      Get.offAll(() => MainPage());
    }
  }

  void login(String user, String pass) async {
    if (user.isNotEmpty && pass.isNotEmpty) { // Input bebas 
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('username', user);
      username.value = user;
      Get.offAll(() => MainPage());
    } else {
      Get.snackbar('Error', 'Username dan Password tidak boleh kosong');
    }
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Menghapus session [cite: 8]
    Get.offAll(() => LoginPage());
  }
}