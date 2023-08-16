import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:green_cleats/api/apis.dart';
import 'package:green_cleats/apps/PlayersApp/groundBooking/ground.dart';
import 'package:green_cleats/utils/colors.dart';
import 'package:green_cleats/utils/utils.dart';

class GroundsPage extends StatefulWidget {
  var player_id;
  var player_name;
  var team_id;

  GroundsPage({
    Key? key,
    required this.player_name,
    required this.player_id,
    required this.team_id,
  });

  @override
  State<GroundsPage> createState() => _GroundsPageState();
}

class _GroundsPageState extends State<GroundsPage> {
  // List<String> items = ["All", "Futsal", "Fullfield"];
  int current = 0;
  late List<dynamic> grounds;
  List<dynamic>? filteredGrounds = [];

  @override
  void initState() {
    super.initState();
    loadGrounds();
  }

  Future<void> loadGrounds() async {
    final data = await getGrounds();
    setState(() {
      grounds = data;
      filteredGrounds = grounds;
    });
  }

  void searchGrounds(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredGrounds = grounds;
      } else {
        filteredGrounds = grounds.where((ground) {
          final groundName = ground['ground_name'].toString().toLowerCase();
          return groundName.contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: searchGrounds,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.whiteColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Search',
                hintStyle: TextStyle(
                  color: AppColors.animationBlueColor,
                  fontSize: 16.0,
                ),
                prefixIcon: Icon(Icons.search),
                prefixIconColor: AppColors.backgroundColor,
              ),
            ),
          ),
          // Column(
          //   children: [
          //     SizedBox(
          //       height: 60,
          //       width: double.infinity,
          //       child: ListView.builder(
          //         physics: const BouncingScrollPhysics(),
          //         itemCount: items.length,
          //         scrollDirection: Axis.horizontal,
          //         itemBuilder: (ctx, index) {
          //           return GestureDetector(
          //             onTap: () {
          //               setState(() {
          //                 current = index;
          //               });
          //             },
          //             child: AnimatedContainer(
          //               duration: const Duration(milliseconds: 300),
          //               margin: EdgeInsets.all(5),
          //               width: 80,
          //               height: 45,
          //               decoration: BoxDecoration(
          //                 borderRadius: BorderRadius.circular(12),
          //                 color: current == index
          //                     ? AppColors.animationGreenColor
          //                     : AppColors.whiteColor,
          //               ),
          //               child: Center(
          //                 child: Text(
          //                   items[index],
          //                   style: TextStyle(
          //                     color: current == index
          //                         ? AppColors.whiteColor
          //                         : AppColors.animationBlueColor,
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           );
          //         },
          //       ),
          //     ),
          //   ],
          // ),
          Container(
            margin: EdgeInsets.all(8),
            color: AppColors.whiteColor,
            child: ListView.separated(
              shrinkWrap: true,
              primary: false,
              padding: const EdgeInsets.all(10.0),
              itemCount: filteredGrounds!.length,
              itemBuilder: (context, index) {
                return _buildGroundItem(
                  context,
                  filteredGrounds!,
                  index,
                  widget.player_id,
                  widget.player_name,
                  widget.team_id,
                );
              },
              separatorBuilder: (context, index) =>
                  const SizedBox(height: 10.0),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildGroundItem(
  context,
  List<dynamic> data,
  int index,
  player_id,
  player_name,
  team_id,
) {
  var ground = data[index];
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: SizedBox(
      height: 300,
      child: FlipCard(
        direction: FlipDirection.HORIZONTAL,
        front: frontCard(context, ground, player_id, player_name, team_id),
        back: backCard(ground),
      ),
    ),
  );
}

Widget frontCard(context, data, player_id, player_name, team_id) {
  var ground = data;

  return Card(
    elevation: 20,
    shadowColor: AppColors.animationGreenColor,
    semanticContainer: true,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    child: Column(
      children: [
        SizedBox(
          height: 200,
          width: double.infinity,
          child: Hero(
            tag: "blogImage",
            child: Image(
              alignment: Alignment.topCenter,
              fit: BoxFit.fitWidth,
              image: NetworkImage(
                ground["data"].length > 0
                    ? ground["data"][0]["picture_url"]
                    : owlImage,
              ),
            ),
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  top: 8.0,
                  bottom: 8.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      ground["ground_name"],
                      style: TextStyle(
                        color: AppColors.animationGreenColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GroundPage(
                              groundData: ground,
                              player_id: player_id,
                              player_name: player_name,
                              team_id: team_id,
                            ),
                          ),
                        );
                      },
                      child: Text('Book Me'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.animationGreenColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget backCard(data) {
  Map ground = data;
  return Card(
    semanticContainer: true,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    child: Column(
      children: [
        SizedBox(
          height: 200,
          width: double.infinity,
          child: Hero(
            tag: "blogImage",
            child: Image(
              alignment: Alignment.topCenter,
              fit: BoxFit.fitWidth,
              image: NetworkImage(
                ground["data"].length > 0
                    ? ground["data"][0]["picture_url"]
                    : owlImage,
              ),
            ),
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  top: 8.0,
                  bottom: 8.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${ground["fees"]} Rs / Slot",
                      style: TextStyle(
                        color: AppColors.khakiColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          const WidgetSpan(
                            child: Icon(
                              Icons.location_on_outlined,
                              color: Colors.grey,
                            ),
                          ),
                          TextSpan(
                            text: ground["location"],
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      style: TextStyle(height: 2.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
