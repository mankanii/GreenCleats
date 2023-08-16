import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:green_cleats/apps/PlayersApp/Blogs/blogs_page.dart';
import 'package:green_cleats/apps/PlayersApp/groundBooking/grounds_page.dart';
import 'package:green_cleats/apps/PlayersApp/main_posting_page.dart';
import 'package:green_cleats/apps/PlayersApp/More/more_page.dart';
import 'package:green_cleats/apps/PlayersApp/playerProfile/player_profile.dart';
import 'package:green_cleats/apps/PlayersApp/trainerBooking/trainer_page.dart';
import 'package:green_cleats/utils/colors.dart';

class BottomNavBar extends StatefulWidget {
  var player_id;

  var team_id;

  var player_name;

  var index;

  BottomNavBar(
      {super.key,
      required this.player_id,
      required this.team_id,
      required this.player_name,
      required this.index});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _children = [
      const BlogsPage(),
      GroundsPage(
          player_id: widget.player_id,
          player_name: widget.player_name,
          team_id: widget.team_id),
      MainPostingPage(
          player_id: widget.player_id, player_name: widget.player_name),
      TrainerPage(player_id: widget.player_id),
      MorePage(
        player_id: widget.player_id,
        team_id: widget.team_id,
        player_name: widget.player_name,
      ),
    ];
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.animationBlueColor,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.khakiColor,
        unselectedItemColor: AppColors.animationGreenColor,
        onTap: onTappedBar,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.read_more), label: "Blogs"),
          BottomNavigationBarItem(
              icon: Icon(Icons.stadium_outlined), label: "Grounds"),
          BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.sports_soccer_outlined,
              ),
              icon: Icon(
                Icons.home_outlined,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center_outlined), label: "Trainer"),
          BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz_sharp), label: "More"),
        ],
      ),
    );
  }
}
