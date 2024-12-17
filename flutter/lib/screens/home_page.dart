import 'package:flutter/material.dart';
import 'report_issue_page.dart';
import 'history_page.dart';

class HomePage extends StatelessWidget {
  final bool isVisitor;

  // Constructor to accept isVisitor parameter
  const HomePage({super.key, required this.isVisitor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          if (!isVisitor)
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                // Handle logout logic here
              },
            ),
        ],
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildCard(context, 'Report Issue', Icons.report, ReportIssuePage(), isVisitor),
            _buildCard(context, 'History', Icons.history, HistoryPage(), isVisitor),
          ],
        ),
      ),
    );
  }

  // Build a card for navigation
  Widget _buildCard(BuildContext context, String title, IconData icon, Widget page, bool isVisitor) {
    return GestureDetector(
      onTap: () {
        if (isVisitor) {
          // If visitor, restrict access to history
          if (title == 'History') {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Guests cannot view the history page')));
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => page),
            );
          }
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => page),
          );
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 60, color: Colors.cyan),
          Text(title, style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
