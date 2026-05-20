import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../controllers/favorite_controller.dart';
import 'detail_page.dart';

class FavoritePage extends StatelessWidget {
  final FavoriteController favC = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Daftar Favorit'), backgroundColor: Colors.black),
      body: Obx(() {
        if (favC.favoriteList.isEmpty) return Center(child: Text("Belum ada favorit"));
        return ListView.builder(
          itemCount: favC.favoriteList.length,
          itemBuilder: (context, index) {
            final show = favC.favoriteList[index];
            return ListTile(
              onTap: () => Get.to(() => DetailPage(showId: show.id)), // Ke detail show [cite: 34]
              leading: CachedNetworkImage(imageUrl: show.imageUrl, width: 50, fit: BoxFit.cover),
              title: Text(show.name),
              subtitle: Row(
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 14),
                  SizedBox(width: 4),
                  Text(show.rating.toString()),
                ],
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () => favC.toggleFavorite(show), // Dihapus [cite: 33]
              ),
            );
          },
        );
      }),
    );
  }
}