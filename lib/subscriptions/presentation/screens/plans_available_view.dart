import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PlansAvailableView extends StatelessWidget {
  const PlansAvailableView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Plans available',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.grey),
          onPressed: () {
            context.go('/home/3/subscriptions');
          },
        ),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BuildPlanCard(
                planName: 'Premium',
                features: [
                  '1 Premium account',
                  'Browse without ads',
                  'Add as many lines as you want to your favorites',
                  'Receive notifications about your favorite lines',
                  'Up-to-date information on the status of the next buses closest to your location.',
                ],
              ),
              SizedBox(height: 16),
              BuildPlanCard(
                planName: 'Estudiantes',
                features: [
                  '1 Premium account verified as a student',
                  'Descount on the subscription',
                  'Browse without ads',
                  'Add up to 5 lines to your favorites',
                  'Information on the status of the next buses closest to your location.',
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BuildPlanCard extends StatelessWidget {
  final String planName;
  final List<String> features;
  const BuildPlanCard({super.key, required this.planName, required this.features});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            planName,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: features
                .map((feature) => Text(
                      '• $feature',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}