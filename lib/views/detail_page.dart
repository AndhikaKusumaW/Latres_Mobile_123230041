import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../controllers/show_controller.dart';
import '../controllers/favorite_controller.dart';

class DetailPage extends StatelessWidget {
  final int showId;
  DetailPage({required this.showId});

  final ShowController showC = Get.find();
  final FavoriteController favC = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    // Fetch detail show saat halaman dibuka
    showC.getShowDetail(showId);

    return Scaffold(
      backgroundColor: Colors.black, // Background gelap
      appBar: AppBar(
        title: Text('Detail', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white), // Tombol back warna putih
      ),
      body: Obx(() {
        if (showC.isDetailLoading.value) {
          return Center(child: CircularProgressIndicator(color: Colors.red));
        }

        final show = showC.showDetail.value;
        if (show == null) {
          return Center(child: Text("Data tidak ditemukan", style: TextStyle(color: Colors.white)));
        }

        // KUNCI AGAR ICON REAKTIF: Mengecek apakah film ada di dalam daftar favorit
        // Karena diletakkan di dalam Obx, UI akan langsung refresh saat nilai favoriteList berubah
        bool isFav = favC.favoriteList.any((element) => element.id == show.id);

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Gambar dengan Efek Gradient Hitam di Bawahnya
              Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: show.imageUrl,
                    fit: BoxFit.cover,
                    height: 480,
                    width: double.infinity,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [Colors.black, Colors.transparent],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              
              // 2. Konten Teks & Tombol
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(show.name, style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white)),
                    SizedBox(height: 8),
                    
                    // Rating
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 18),
                        SizedBox(width: 4),
                        Text(show.rating.toString(), style: TextStyle(fontSize: 14, color: Colors.white)),
                      ],
                    ),
                    SizedBox(height: 6),
                    
                    // Genre
                    Text(show.genres.join(', '), style: TextStyle(color: Colors.grey[400], fontSize: 14)),
                    
                    SizedBox(height: 16),
                    
                    // 3. Tombol Nonton & Favorit Berdampingan
                    Row(
                      children: [
                        // TOMBOL NONTON
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            onPressed: () {
                              // Notifikasi Nonton
                              Get.snackbar(
                                'Memutar film',
                                'Selamat menonton',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                                margin: EdgeInsets.all(16),
                              );
                            },
                            icon: Icon(Icons.play_arrow),
                            label: Text('Nonton', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        SizedBox(width: 12), // Jarak antar tombol
                        
                        // TOMBOL FAVORIT
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF1E1E1E), // Warna kotak abu-abu gelap
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: IconButton(
                            icon: Icon(
                              isFav ? Icons.favorite : Icons.favorite_border,
                              color: isFav ? Colors.red : Colors.white, // Langsung merah jika disukai
                            ),
                            onPressed: () {
                              favC.toggleFavorite(show);
                              // Notifikasi berhasil masuk favorit
                              Get.snackbar(
                                !isFav ? 'Berhasil' : 'Dihapus',
                                !isFav ? 'Film berhasil ditambahkan' : 'Film dihapus dari favorite',
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: !isFav ? Colors.green : Colors.grey[800],
                                colorText: Colors.white,
                                duration: Duration(seconds: 1),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                    
                    SizedBox(height: 24),
                    
                    // 4. Overview
                    Text('Overview', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                    SizedBox(height: 8),
                    Text(
                      show.summary, 
                      style: TextStyle(fontSize: 14, height: 1.5, color: Colors.grey[350]),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 40), 
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}