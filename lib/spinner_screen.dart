import 'package:flutter/material.dart';

class SpinnerScreen extends StatelessWidget {
  const SpinnerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        title: const Text('Loading Spinner Showcase'),
        backgroundColor: Colors.blueGrey,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            SpinnerCard(title: 'CircularProgressIndicator (default)', spinner: CircularProgressIndicator()),
            SpinnerCard(
              title: 'CircularProgressIndicator (custom color)',
              spinner: CircularProgressIndicator(color: Colors.deepPurple),
            ),
            SpinnerCard(
              title: 'CircularProgressIndicator (thicker stroke)',
              spinner: CircularProgressIndicator(
                strokeWidth: 6.0,
                color: Colors.teal,
              ),
            ),
            SpinnerCard(
              title: 'CircularProgressIndicator (with background)',
              spinner: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                backgroundColor: Colors.black12,
              ),
            ),
            SpinnerCard(
              title: 'Indeterminate LinearProgressIndicator',
              spinner: LinearProgressIndicator(),
            ),
            SpinnerCard(
              title: 'LinearProgressIndicator (custom)',
              spinner: LinearProgressIndicator(
                color: Colors.indigo,
                backgroundColor: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SpinnerCard extends StatelessWidget {
  final String title;
  final Widget spinner;

  const SpinnerCard({super.key, required this.title, required this.spinner});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Center(child: SizedBox(width: 50, height: 50, child: spinner)),
          ],
        ),
      ),
    );
  }
}
