import 'package:chapa_tu_bus_app/execution_monitoring/domain/entities/favorite_bus_line.dart';
import 'package:chapa_tu_bus_app/execution_monitoring/presentation/utils/favorites_bus_lines.dart';
import 'package:flutter/material.dart';

class FavoritesView extends StatelessWidget {
  static const name = 'Favorites lines';
  static String getViewName() => name;
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 60.0), // Espacio para el botón
            child: ListView.builder(
              itemCount: favoriteBusLines.length,
              itemBuilder: (context, index) {
                return FavoriteBusLineCard(busLine: favoriteBusLines[index]);
              },
            ),
          ),
          Positioned(
            top: 16.0,
            right: 16.0,
            child: ElevatedButton(
              onPressed: () {
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: const Text('Edit'),
            ),
          ),
        ],
      ),
    );
  }
}

class FavoriteBusLineCard extends StatelessWidget {
  final FavoriteBusLine busLine;

  const FavoriteBusLineCard({super.key, required this.busLine});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 100.0,
              height: 80.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: NetworkImage(busLine.imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    busLine.code,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(busLine.name),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}