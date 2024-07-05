import 'package:flutter/material.dart';
import 'package:restaurants_task/style/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const routeName = '/HomePage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildBody() {
    return SizedBox();
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppColors.PRIMARY_COLOR,
      selectedItemColor: AppColors.SECONDARY_COLOR,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Posts',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.tab),
          label: 'Tab 2',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.tab),
          label: 'Tab 3',
        ),
      ],
    );
  }

  void _showSnackBar(BuildContext context, String? message) {
    if (message == null) return;

    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.removeCurrentSnackBar();
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
