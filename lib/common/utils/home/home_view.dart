import 'package:flutter/material.dart';


class HomeView extends StatelessWidget {
  static const name = 'Home';
  static String getViewName() => name;
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Busca una linea',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none, // Remove border
                ),
                filled: true, // Fill the background
                fillColor: Colors.grey[200], // Light grey background
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Add vertical padding
            child: Container(
              height: 100.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: const DecorationImage(
                  image: NetworkImage(
                      'https://elcomercio.pe/resizer/cQldVjFH-mDVWbJHJ2SqWAjsaI8=/580x330/smart/filters:format(jpeg):quality(75)/cloudfront-us-east-1.images.arcpublishing.com/elcomercio/3UV4OIX2A5BTRDHLKF3QLWOUHA.jpg'), // Replace with your image
                  fit: BoxFit.cover,
                ),
              ),
              child: const Center(
                child: Text(
                  'Empieza tu prueba gratuita',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Líneas frecuentes',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: busLines.length,
              itemBuilder: (context, index) {
                return BusLineCard(busLine: busLines[index]);
              },
            ),
          ),
        ],
      );
  }
}

class BusLine {
  final String code;
  final String name;
  final String imagePath;

  BusLine({
    required this.code,
    required this.name,
    required this.imagePath,
  });
}

final List<BusLine> busLines = [
  BusLine(
    code: '[209]',
    name: 'Ate - San Miguel\nCorredor Rojo',
    imagePath:
        'https://upload.wikimedia.org/wikipedia/commons/5/59/Linea_7_-_Lima.jpg',
  ),
  BusLine(
    code: '[CR71]',
    name: 'Ate - San Martin de\nPorres',
    imagePath:
        'https://upload.wikimedia.org/wikipedia/commons/5/59/Linea_7_-_Lima.jpg', 
  ),
  BusLine(
    code: '[CR07]',
    name: 'Callao -\nLa Perla',
    imagePath:
        'https://upload.wikimedia.org/wikipedia/commons/5/59/Linea_7_-_Lima.jpg', 
  ),
];

class BusLineCard extends StatelessWidget {
  final BusLine busLine;

  const BusLineCard({super.key, required this.busLine});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Add horizontal padding
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0), // Rounded corners
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                  children: [
                    Text(
                      busLine.code,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      busLine.name,
                      style: const TextStyle(fontSize: 14.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}