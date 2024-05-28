import 'package:chapa_tu_bus_app/common/utils/home/home_view.dart';
import 'package:flutter/material.dart';

class BusLineCard extends StatelessWidget {
  final BusLine busLine;

  const BusLineCard({super.key, required this.busLine});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        color: Colors.white,
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ), // Fixed height for the card
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            // Using Column instead of Row here
            crossAxisAlignment: CrossAxisAlignment.start, // Align to the start
            children: [
              Row(
                // Row for code and name
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Text(
                      busLine.code,
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4.0),
                  Flexible(
                    flex: 2,
                    child: SizedBox(
                      child: Text.rich(
                        TextSpan(
                          text: busLine.name,
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.black,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
