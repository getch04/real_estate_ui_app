import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:real_estate_test/shared/k_space.dart';
import 'package:real_estate_test/theme.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return MaterialApp(
        title: 'Real Estate Test',
        theme: AppTheme.lightTheme,
        home: const HomePage(),
      );
    });
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _selectedIndex = 2; // Default selected index (home)
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).scaffoldBackgroundColor,
              Theme.of(context).primaryColor.withOpacity(0.5),
              Theme.of(context).primaryColor,
            ],
          ),
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SizedBox(
                height: 100.h,
                width: 100.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    KVerticalSpace.extraLarge,
                    KVerticalSpace.extraLarge,
                    KVerticalSpace.large,
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: _buildLocation(context)
                          .animate()
                          .fadeIn(duration: 300.ms)
                          .then(delay: 200.ms),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: _buildGreeting(context)
                          .animate()
                          .fadeIn(duration: 300.ms)
                          .then(delay: 400.ms),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: _buildOfferCount(context)
                          .animate()
                          .fadeIn(duration: 300.ms)
                          .then(delay: 600.ms),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: _buildPropertyList()
                          .animate()
                          .fadeIn(duration: 300.ms)
                          .then(delay: 800.ms),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: _buildBottomNavigationBar(context)
                  .animate()
                  .slideY(begin: 1, end: 0, duration: 300.ms)
                  .then(delay: 1000.ms),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocation(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.sp),
          ),
          child: Padding(
            padding: EdgeInsets.all(1.5.h),
            child: const Row(
              children: [
                Icon(Icons.location_pin, color: Colors.brown),
                SizedBox(width: 8),
                Text(
                  'Saint Petersburg',
                  style: TextStyle(fontSize: 16, color: Colors.brown),
                ),
              ],
            ),
          ),
        ),
        CircleAvatar(
          backgroundImage:
              const NetworkImage('https://via.placeholder.com/150'),
          radius: 19.sp,
        ),
      ],
    );
  }

  Widget _buildGreeting(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Hi, Marina',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                'Let\'s select your perfect place',
                maxLines: 2,
                softWrap: true,
                style: TextStyle(
                  fontSize: 21.sp,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                  color: Theme.of(context).colorScheme.scrim.withOpacity(0.8),
                ),
              ),
            ),
            const SizedBox(
              width: 100,
            )
          ],
        ),
      ],
    );
  }

  Widget _buildOfferCount(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildOfferCard('BUY', '1 034', Colors.orange, context, isCircle: true),
        const SizedBox(width: 16),
        _buildOfferCard('RENT', '2 212', Colors.white, context),
      ],
    );
  }

  Widget _buildOfferCard(
    String type,
    String count,
    Color color,
    BuildContext context, {
    bool isCircle = false,
  }) {
    return Expanded(
      child: Container(
        height: 180,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: isCircle
              ? BorderRadius.circular(100.h)
              : BorderRadius.circular(20.sp),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            KVerticalSpace.tiny,
            Text(
              type,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color == Colors.orange
                    ? Theme.of(context).colorScheme.onPrimary.withOpacity(0.6)
                    : Colors.black,
              ),
            ),
            const Spacer(),
            Text(
              count,
              style: TextStyle(
                fontSize: 25.sp,
                fontWeight: FontWeight.bold,
                color: color == Colors.orange ? Colors.white : Colors.black,
              ),
            ),
            Text(
              'offers',
              style: TextStyle(
                fontSize: 16,
                color: color == Colors.orange
                    ? Theme.of(context).colorScheme.onPrimary.withOpacity(0.6)
                    : Colors.black,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertyList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(24.sp),
          right: Radius.circular(24.sp),
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.only(top: 7, left: 7, right: 7),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          _buildPropertyCard('Gladkova St., 25'),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildGridPropertyCard('Trofeleva St., 43'),
              _buildGridPropertyCard('Another St., 34'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyCard(String address) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.sp)),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(24.sp),
            ),
            child: Image.network(
              'https://media.designcafe.com/wp-content/uploads/2020/01/21001206/bedroom-paint-colors.jpg',
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                decoration: BoxDecoration(
                  color:
                      const Color.fromARGB(255, 251, 246, 228).withOpacity(0.9),
                  borderRadius: BorderRadius.circular(35.sp),
                ),
                child: Padding(
                  padding: EdgeInsets.all(5.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Text(
                        address,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 4,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 22.sp,
                          backgroundColor: Colors.white,
                          child: const Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridPropertyCard(String address) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.sp)),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.sp),
              topRight: Radius.circular(15.sp),
            ),
            child: Image.network(
              'https://via.placeholder.com/300',
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  address,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Icon(Icons.arrow_forward),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 60),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        borderRadius: BorderRadius.circular(24.sp),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavItem(0, BootstrapIcons.search_heart_fill),
          _buildNavItem(1, BootstrapIcons.chat_square_text_fill),
          _buildNavItem(2, BootstrapIcons.house_fill),
          _buildNavItem(3, Icons.favorite),
          _buildNavItem(4, Icons.person),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    int index,
    IconData icon,
  ) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: CircleAvatar(
        backgroundColor:
            _selectedIndex == index ? Colors.yellow.shade800 : Colors.black,
        radius: _selectedIndex == index ? 28 : 23,
        child: Icon(
          icon,
          color: Colors.white,
          size: _selectedIndex == index ? 30 : 25,
        ),
      ),
    );
  }
}
