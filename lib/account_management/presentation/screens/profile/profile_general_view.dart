import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileGeneralView extends StatefulWidget {
  static const name = 'Profile';
  static String getViewName() => name;
  const ProfileGeneralView({super.key});

  @override
  State<ProfileGeneralView> createState() => _ProfileGeneralViewState();
}

class _ProfileGeneralViewState extends State<ProfileGeneralView> {
  final user = FirebaseAuth.instance.currentUser!;
  final bool notificationsEnabled = false;

  String photoURL = '';
  String email = '';
  String name = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void signUserOut() {
    context.go('/start');
    FirebaseAuth.instance.signOut();
  }

  Future<void> _loadUserData() async {
    final userEmail = user.email; // Obtiene el email del usuario actual
    if (userEmail != null) {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: userEmail)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final userData = querySnapshot.docs.first.data();
        setState(() {
          name = userData['name'];
          email = userData['email'];
          photoURL = userData['photoURL'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                  radius: 40, backgroundImage: NetworkImage(photoURL)),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                email,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 24),
            BuildProfileOption(
              icon: Icons.settings,
              text: 'Configuración',
              isShowMore: true,
              onTap: () {
                context.go('/home/3/settings');
              },
            ),
            BuildProfileOption(
              icon: Icons.credit_card,
              text: 'Pagos',
              isShowMore: true,
              onTap: () {
                context.go('/home/3/payments');
              },
            ),
            BuildProfileOption(
              icon: Icons.percent,
              text: 'Mi suscripción',
              isShowMore: true,
              onTap: () {
                context.go('/home/3/subscriptions');
              },
            ),
            BuildProfileOption(
              icon: Icons.favorite,
              text: 'Mis favoritos',
              isShowMore: true,
              onTap: () {
                context.go('/home/2');
              },
            ),
            const BuildProfileOption(
              icon: Icons.notifications,
              text: 'Notificaciones',
              isSwitch: true,
            ),
            BuildProfileOption(
              icon: Icons.exit_to_app,
              text: 'Cerrar sesión',
              onTap: () {
                signUserOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BuildProfileOption extends StatefulWidget {
  final IconData icon;
  final String text;
  final bool isSwitch;
  final bool isShowMore;
  final VoidCallback? onTap;
  const BuildProfileOption(
      {super.key,
      required this.icon,
      required this.text,
      this.isSwitch = false,
      this.isShowMore = false,
      this.onTap});

  @override
  State<BuildProfileOption> createState() => _BuildProfileOptionState();
}

class _BuildProfileOptionState extends State<BuildProfileOption> {
  bool notificationsEnabled = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: SizedBox(
          height: 55,
          child: Row(
            children: [
              Icon(widget.icon, color: Colors.grey),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  widget.text,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              if (widget.isSwitch)
                Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    value: notificationsEnabled,
                    onChanged: (value) {
                      setState(() {
                        notificationsEnabled = value;
                      });
                    },
                    activeColor: Colors.blue,
                    trackColor: WidgetStateProperty.resolveWith<Color>(
                      (Set<WidgetState> states) {
                        if (states.contains(WidgetState.selected)) {
                          return Colors.blue[100]!;
                        }
                        return Colors.grey[300]!;
                      },
                    ),
                  ),
                )
              else if (widget.isShowMore)
                const Icon(Icons.arrow_forward_ios, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
