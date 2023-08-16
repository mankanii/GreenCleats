import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:green_cleats/api/apis.dart';
import 'package:green_cleats/utils/colors.dart';
import 'trainer.dart';
import 'trainer_card.dart';

// class Trainer {
//   final String name;
//   final String type;
//   final String imageUrl;

//   Trainer({required this.name, required this.type, required this.imageUrl});
// }

class TrainerPage extends StatefulWidget {
  var player_id;

  TrainerPage({super.key, required this.player_id});

  @override
  _TrainerPageState createState() => _TrainerPageState();
}

class _TrainerPageState extends State<TrainerPage> {
  List _trainers = [];
  List _filteredTrainers = [];

  @override
  void initState() {
    super.initState();
    trainersData().then((response) {
      if (response.statusCode == 200) {
        setState(() {
          _trainers = json.decode(response.body)["trainers"];
          _filteredTrainers = _trainers;
          print(_filteredTrainers);
        });
      }
    });
  }

  void search(String query) {
    setState(() {
      _filteredTrainers = _trainers
          .where((trainer) =>
              trainer.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void book(trainer) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            TrainerDetailsPage(player_id: widget.player_id, trainer: trainer),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: TextField(
          //     onChanged: (query) => search(query),
          //     decoration: const InputDecoration(
          //       hintText: 'Search',
          //       prefixIcon: Icon(Icons.search),
          //       border: OutlineInputBorder(),
          //     ),
          //   ),
          // ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredTrainers.length,
              itemBuilder: (context, index) {
                return TrainerCard(
                  trainer: _filteredTrainers[index],
                  onBook: book,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
