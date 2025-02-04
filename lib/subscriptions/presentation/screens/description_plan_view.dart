import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DescriptionPlanView extends StatelessWidget {
  const DescriptionPlanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'General description\nof the plan',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BuildPlanInfoCard(
                icon: Icons.directions_bus,
                planName: 'Premium',
                status: 'Active',
                renewalDate: '20/05/24',
                color: Colors.blue[100]!,
                iconColor: Colors.blue,
              ),
              const SizedBox(height: 16),
              BuildPlanDetailsCard(
                title: 'This is what the plan includes',
                details: const [
                  '1 Premium account',
                  'Browse without ads',
                  'Add as many lines as you want to your favorites',
                  'Receive notifications about your favorite lines',
                  'Up-to-date information on the status of the next buses closest to your location.'
                ],
                buttonText: 'See available plans', 
                onPressed: () { 
                  context.go('/home/3/subscriptions/plans-available');
                },
              ),
            ],
          ),
        ),
      ),);
  }
}

class BuildPlanInfoCard extends StatelessWidget {

  final IconData icon;
  final String planName;
  final String status;
  final String renewalDate;
  final Color color;
  final Color iconColor;

  const BuildPlanInfoCard({
    super.key,
    required this.icon, 
    required this.planName, 
    required this.status, 
    required this.renewalDate, 
    required this.color, 
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: color,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: iconColor,
            ),
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  planName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  status,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Text(
                  'Your current plan will renew at\n$renewalDate',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BuildPlanDetailsCard extends StatelessWidget {
  final String title;
  final List<String> details;
  final String buttonText;
  final VoidCallback onPressed;
  const BuildPlanDetailsCard({
    super.key, 
    required this.title, 
    required this.details, 
    required this.buttonText, 
    required this.onPressed
  });

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
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: details
                .map((detail) => Text(
                      '• $detail',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ))
                .toList(),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFC4B5FD),
              padding:
                  const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }
}
