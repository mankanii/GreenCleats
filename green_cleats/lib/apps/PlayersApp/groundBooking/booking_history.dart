import 'package:flutter/material.dart';
import 'package:green_cleats/api/apis.dart';
import 'package:green_cleats/utils/colors.dart';
import 'package:green_cleats/utils/utils.dart';

final List<Map> currentCard = [];

final List<Map> previousCard = [];

class BookingHistory extends StatefulWidget {
  var teamId;

  BookingHistory({super.key, required this.teamId});

  @override
  State<BookingHistory> createState() => _BookingHistoryState();
}

class _BookingHistoryState extends State<BookingHistory> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bookingHistory(widget.teamId).then((response) {
      var data = response;
      currentCard.clear();
      previousCard.clear();
      for (var element in data) {
        setState(() {
          if (compareDates(element['date']) == "same" ||
              compareDates(element['date']) == "after") {
            currentCard.add(
              {
                "image": element['ground_image'].length == 0
                    ? owlImage
                    : element['ground_image'][0]["picture_url"],
                "groundName": element['ground_name'],
                "date": element['date'],
                "slot": "${element['start_time']} - ${element['end_time']}",
              },
            );
          } else {
            previousCard.add(
              {
                "image": element['ground_image'].length == 0
                    ? owlImage
                    : element['ground_image'][0]["picture_url"],
                "groundName": element['ground_name'],
                "date": element['date'],
                "slot": "${element['start_time']} - ${element['end_time']}",
              },
            );
          }
        });
        // print("Date: ${element['ground_image'][0]} ");
      }
      // print("Length: ${data.length}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.animationBlueColor,
          title: const Text("Booking History"),
          bottom: TabBar(
            indicatorColor: AppColors.animationGreenColor,
            tabs: const [Tab(text: "Current"), Tab(text: "Previous")],
          ),
        ),
        body: TabBarView(children: [
          ListView.separated(
            shrinkWrap: true,
            primary: false,
            padding: const EdgeInsets.all(8.0),
            itemCount: currentCard.length,
            itemBuilder: (context, index) {
              print("Current Card: ${currentCard.length}");
              return _buildCurrent(context, index);
            },
            separatorBuilder: (context, index) => const SizedBox(height: 10.0),
          ),
          ListView.separated(
            shrinkWrap: true,
            primary: false,
            padding: const EdgeInsets.all(8.0),
            itemCount: previousCard.length,
            itemBuilder: (context, index) {
              print("Previous Card: ${previousCard.length}");
              return _buildPrevious(context, index);
            },
            separatorBuilder: (context, index) => const SizedBox(height: 10.0),
          ),
        ]),
      ),
    );
  }

  Widget _buildCurrent(context, int index) {
    Map current = currentCard[index];
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Card(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: InkWell(
                  splashColor: AppColors.animationBlueColor,
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => BlogPage()),
                    // );
                    debugPrint('Card tapped.');
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: "groundImage",
                        child: Image(
                          image: NetworkImage("${current['image']}"),
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        "${current['date']}",
                        style: TextStyle(
                          color: AppColors.animationGreenColor,
                          fontSize: 16,
                        ),
                      ),
                      ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        title: Text("${current['groundName']}",
                            style: TextStyle(
                                fontSize: 24,
                                color: AppColors.animationBlueColor,
                                fontWeight: FontWeight.bold)),
                        subtitle: Text(
                          "${current['slot']}",
                          style: TextStyle(
                              fontSize: 20,
                              color: AppColors.blackColor.withOpacity(0.8)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.blackColor.withOpacity(0.2),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: IconButton(
                    highlightColor: AppColors.animationBlueColor,
                    icon: Icon(
                      Icons.clear,
                      color: AppColors.khakiColor,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Cancel Booking"),
                            content: Text(
                                "Are you sure you want to cancel the booking?"),
                            actions: [
                              TextButton(
                                child: Text(
                                  "No",
                                  style: TextStyle(
                                      color: AppColors.animationBlueColor),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text(
                                  "Yes",
                                  style: TextStyle(
                                      color: AppColors.animationBlueColor),
                                ),
                                onPressed: () {
                                  // cancel booking functionality here
                                  debugPrint('Booking cancelled.');
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPrevious(context, int index) {
    Map previous = previousCard[index];
    // final String sample = images[2];
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
              splashColor: AppColors.animationBlueColor,
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => BlogPage()),
                // );
                debugPrint('Card tapped.');
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: "groundImage",
                    child: Image(
                      image: NetworkImage("${previous['image']}"),
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "${previous['date']}",
                    style: TextStyle(
                      color: AppColors.animationGreenColor,
                      fontSize: 16,
                    ),
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    title: Text("${previous['groundName']}",
                        style: TextStyle(
                            fontSize: 24,
                            color: AppColors.animationBlueColor,
                            fontWeight: FontWeight.bold)),
                    subtitle: Text(
                      "${previous['slot']}",
                      style: TextStyle(
                          fontSize: 20,
                          color: AppColors.blackColor.withOpacity(0.8)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
