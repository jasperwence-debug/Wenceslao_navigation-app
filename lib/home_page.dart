import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Icon(
            Icons.home,
            size: 80,
            color: Colors.indigo,
          ),
          const SizedBox(height: 16),
          const Text(
            'Welcome, Student!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Use the navigation bar below to explore the app.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Card(
            child: Column(
              children: const [
                ListTile(
                  leading: Icon(Icons.calculate),
                  title: Text('Calculator'),
                  subtitle: Text(
                    'Perform basic arithmetic operations.',
                  ),
                ),
                Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Profile'),
                  subtitle: Text(
                    'View your student information.',
                  ),
                ),
                Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.share),
                  title: Text('Social Media'),
                  subtitle: Text(
                    'View your sample social accounts.',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
