import 'package:flutter/material.dart';
import 'package:siswa_flutter/pages/dashboard_page.dart';
import 'package:siswa_flutter/pages/manage_siswa.dart';

class NavbarPage extends StatefulWidget {
  const NavbarPage({Key? key}) : super(key: key);

  @override
  State<NavbarPage> createState() => _NavbarPageState();
}

class _NavbarPageState extends State<NavbarPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    body() {
      switch (currentIndex) {
        case 0:
          return const DashboardPage();
        case 1:
          return const ManageSiswaPage();
        default:
      }
    }

    return Scaffold(
      body: body(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            label: 'Beranda',
            icon: currentIndex == 0
                ? const Icon(
                    Icons.dashboard_rounded,
                    color: Colors.blueAccent,
                  )
                : const Icon(
                    Icons.dashboard_rounded,
                    color: Colors.grey,
                  ),
          ),
          BottomNavigationBarItem(
            label: 'Atur Siswa',
            icon: currentIndex == 1
                ? const Icon(
                    Icons.data_exploration_rounded,
                    color: Colors.blueAccent,
                  )
                : const Icon(
                    Icons.data_exploration_rounded,
                    color: Colors.grey,
                  ),
          ),
        ],
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
      ),
    );
  }
}
