import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodoTabBar extends StatelessWidget implements PreferredSizeWidget {
  final TabController tabController;
  final List<DateTime> dates;

  TodoTabBar({required this.tabController, required this.dates});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      child: TabBar(
        controller: tabController,
        isScrollable: true,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.transparent,
        ),
        tabs: dates.map((date) {
          final isSelected = tabController.index == dates.indexOf(date);
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 2,
            color: isSelected ? Colors.blueAccent : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    DateFormat('MMM').format(date),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    DateFormat('dd').format(date),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    DateFormat('yyyy').format(date),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey[700],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(100.0);
} 