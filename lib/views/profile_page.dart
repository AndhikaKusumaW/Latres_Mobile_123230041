import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class ProfilePage extends StatelessWidget {
  final AuthController authC = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profil'), backgroundColor: Colors.black, centerTitle: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(radius: 50, backgroundColor: Colors.grey, child: Icon(Icons.person, size: 60, color: Colors.white)),
              SizedBox(height: 20),
              Obx(() => Text(authC.username.value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))), // Username [cite: 36]
              SizedBox(height: 30),
              Text("Kesan: Praktikum ini menantang tapi seru!", textAlign: TextAlign.center, style: TextStyle(fontStyle: FontStyle.italic)), // Kesan/Pesan [cite: 37]
              Text("Pesan: Semoga nilainya bagus Aamiin.", textAlign: TextAlign.center, style: TextStyle(fontStyle: FontStyle.italic)),
              SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                  onPressed: () => authC.logout(), // Tombol logout [cite: 38]
                  child: Text('Logout', style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}