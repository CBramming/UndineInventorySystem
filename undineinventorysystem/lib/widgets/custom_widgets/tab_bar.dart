import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Material(
      color: Color.fromARGB(255, 68, 98, 122),
      child: TabBar(
        labelPadding: EdgeInsets.symmetric(vertical: 4),
        tabs: [
          Tab(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.qr_code_outlined, size: 24),
                Text(
                  'QR-Scanner',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          Tab(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.output_outlined, size: 24),
                Text(
                  'Manual',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          Tab(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.grid_on_outlined, size: 24),
                Text(
                  'Catalog',
                  style: TextStyle(
                    fontSize: 12,
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
