import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MySubscriptionView extends StatelessWidget {
  const MySubscriptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My supscription'),
        leading: IconButton(
          icon: const Icon( Icons.arrow_back_ios ), 
          onPressed: () {
            context.go('/home/3');
          }
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BuildSubscriptionItem(
                icon: Icons.directions_bus,
                title: 'Premium',
                status: 'Active',
                color: Colors.blue[100]!,
                iconColor: Colors.blue,
                onTap: () {
                  context.go('/home/3/subscriptions/description-plan');
                },
              ),
              const SizedBox(height: 16),
              BuildSubscriptionItem(
                icon: Icons.search,
                title: 'See available plans',
                subtitle: 'Premium, Students',
                color: Colors.white,
                iconColor: Colors.grey,
                onTap: () {
                  context.go('/home/3/subscriptions/plans-available');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BuildSubscriptionItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String status;
  final String subtitle;
  final Color color;
  final Color iconColor;
  final VoidCallback onTap;
  const BuildSubscriptionItem({
    super.key, 
    required this.icon, 
    required this.title,
    this.status = '',
    this.subtitle = '', 
    required this.color, 
    required this.iconColor, 
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
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
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  if (status.isNotEmpty)
                    Text(
                      status,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  if (subtitle.isNotEmpty)
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}