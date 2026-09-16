import 'package:flutter/material.dart';
import 'UsersPage.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => AdminPanelState();
}

class AdminPanelState extends State<AdminPanel> {
  int selectedIndex = -1; 
  bool usersExpanded = false; 

  final titles = const ["Pending Users", "Approved Users", "Rejected Users"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedIndex >= 0 ? titles[selectedIndex] : "Admin Panel"),
        backgroundColor: const Color.fromRGBO(6, 10, 53, 1),
      ),
      body: Row(
        children: [
          Container(
            width: 220,
            color: const Color.fromRGBO(6, 10, 53, 1),
            child: ListView(
              children: [
                const SizedBox(height: 40),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Admin Panel",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                InkWell(
                  onTap: () {
                    setState(() {
                      usersExpanded = !usersExpanded;
                      if (!usersExpanded) {
                        selectedIndex = -1; 
                      }
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    color: usersExpanded
                        ? Colors.white.withOpacity(0.2)
                        : Colors.transparent,
                    child: Row(
                      children: [
                        const Icon(Icons.people, color: Colors.white),
                        const SizedBox(width: 10),
                        Text(
                          "Users",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: usersExpanded
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          usersExpanded ? Icons.expand_less : Icons.expand_more,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),

                if (usersExpanded) ...[
                  _childItem("Pending Users", 0),
                  _childItem("Approved Users", 1),
                  _childItem("Rejected Users", 2),
                ],
              ],
            ),
          ),

          Expanded(
            child: selectedIndex >= 0
                ? UsersPage(statusIndex: selectedIndex)
                : const Center(
                    child: Text(
                      "Select a section from Users",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _childItem(String title, int index) {
    final selected = selectedIndex == index;

    return InkWell(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
        color: selected ? Colors.white.withOpacity(0.15) : Colors.transparent,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 14,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
