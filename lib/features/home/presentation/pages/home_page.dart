import 'package:flutter/material.dart';
import 'package:restaurants_task/features/favorites/presentation/pages/favorites_tab.dart';
import 'package:restaurants_task/features/restaurant/presentation/pages/restaurant_tab.dart';
import 'package:restaurants_task/style/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const routeName = '/HomePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          RestaurantTab(),
          FavoritesTab(),
        ],
      ),
      bottomNavigationBar: _BottomNavBar(pageController: _pageController),
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

class _BottomNavBar extends StatefulWidget {
  const _BottomNavBar({
    required PageController pageController,
  }) : _pageController = pageController;

  final PageController _pageController;

  @override
  State<_BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<_BottomNavBar> {
  int _currentIndex = 0;
  @override
  void initState() {
    _currentIndex = widget._pageController.hasClients
        ? widget._pageController.page?.round() ??
            widget._pageController.initialPage
        : 0;

    widget._pageController.addListener(_updateSelectedSelectedItem);
    super.initState();
  }

  void _updateSelectedSelectedItem() {
    if (!mounted) return;
    if (!widget._pageController.hasClients) return;

    final index = widget._pageController.page!.floor();
    if (index != _currentIndex) setState(() => _currentIndex = index);
  }

  @override
  void dispose() {
    widget._pageController.removeListener(_updateSelectedSelectedItem);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppColors.PRIMARY_COLOR,
      selectedItemColor: AppColors.SECONDARY_COLOR,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Map',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'My Favorites',
        ),
      ],
      onTap: widget._pageController.jumpToPage,
    );
  }
}
