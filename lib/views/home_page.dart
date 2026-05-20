import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../controllers/show_controller.dart';
import 'detail_page.dart';

class HomePage extends StatelessWidget {
  final ShowController showC = Get.put(ShowController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Skuy Nonton!'), backgroundColor: Colors.black),
      body: Obx(() {
        if (showC.isLoading.value) return Center(child: CircularProgressIndicator(color: Colors.red)); // Loading Indicator 
        return GridView.builder(
          padding: EdgeInsets.all(8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.65, crossAxisSpacing: 10, mainAxisSpacing: 10,
          ),
          itemCount: showC.shows.length,
          itemBuilder: (context, index) {
            final show = showC.shows[index];
            return GestureDetector(
              onTap: () => Get.to(() => DetailPage(showId: show.id)), // Navigasi ke Detail [cite: 19]
              child: Card(
                color: Colors.grey[900],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                        child: CachedNetworkImage(
                          imageUrl: show.imageUrl, fit: BoxFit.cover, width: double.infinity,
                          placeholder: (context, url) => Center(child: CircularProgressIndicator(color: Colors.red)), // Gambar [cite: 13]
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(show.name, style: TextStyle(fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis), // Judul [cite: 14]
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 16),
                              SizedBox(width: 4),
                              Text(show.rating.toString()), // Rating [cite: 15]
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}