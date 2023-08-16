import 'package:flutter/material.dart';
import 'package:green_cleats/api/apis.dart';
import 'package:green_cleats/apps/PlayersApp/More/Events/Event.dart';
import 'package:green_cleats/apps/PlayersApp/More/Events/event_page.dart';
import 'package:green_cleats/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';

// Define the Event class.
// class Event {
//   final String id;
//   final String name;
//   final String description;
//   final String imageUrl;
//   final DateTime date;

//   Event({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.imageUrl,
//     required this.date,
//   });
// }

// Define the EventsPage widget.
class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  // Define the list of events.
  List<Event> _events = [];
  // final List<Event> _events = [
  //   Event(
  //     id: '1',
  //     name: 'Concert',
  //     description:
  //         'Enjoy a night of live music with your favorite band. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
  //     imageUrl: 'https://picsum.photos/id/1019/600/400',
  //     date: DateTime.now().add(Duration(days: 1)),
  //   ),
  //   Event(
  //     id: '2',
  //     name: 'Comedy Show',
  //     description: 'Laugh out loud with the funniest comedians in town.',
  //     imageUrl: 'https://picsum.photos/id/1020/600/400',
  //     date: DateTime.now().add(Duration(days: 2)),
  //   ),
  //   Event(
  //     id: '3',
  //     name: 'Art Exhibit',
  //     description:
  //         'Discover the latest works of art from up-and-coming artists.',
  //     imageUrl: 'https://picsum.photos/id/1021/600/400',
  //     date: DateTime.now().add(Duration(days: 3)),
  //   ),
  //   Event(
  //     id: '4',
  //     name: 'Film Festival',
  //     description: 'Watch the best films from around the world.',
  //     imageUrl: 'https://picsum.photos/id/1022/600/400',
  //     date: DateTime.now().add(Duration(days: 4)),
  //   ),
  //   Event(
  //     id: '5',
  //     name: 'Food Festival',
  //     description: 'Sample the most delicious dishes from local chefs.',
  //     imageUrl: 'https://picsum.photos/id/1023/600/400',
  //     date: DateTime.now().add(Duration(days: 5)),
  //   ),
  //   Event(
  //     id: '6',
  //     name: 'Book Club',
  //     description:
  //         'Join fellow book lovers for a discussion on the latest novel.',
  //     imageUrl: 'https://picsum.photos/id/1024/600/400',
  //     date: DateTime.now().add(Duration(days: 6)),
  //   ),
  // ];

  // Define the list of filtered events.
  List<Event> _filteredEvents = [];

  // Define the text controller for the search bar.
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // _events = fetchEvents() as List<Event>;
    // Initialize the list of filtered events to the full list of events.
    _filteredEvents = _events;
  }

  @override
  void dispose() {
    // Dispose of the text controller when the widget is disposed.
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.animationBlueColor,
        title: Text('Events'),
      ),
      body: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: TextField(  
          //     controller: _searchController,
          //     decoration: InputDecoration(
          //       labelText: 'Search',
          //       hintText: 'Search',
          //       prefixIcon:
          //           Icon(Icons.search, color: AppColors.animationBlueColor),
          //       border: OutlineInputBorder(
          //         borderSide: BorderSide(color: AppColors.animationBlueColor),
          //         borderRadius: BorderRadius.all(Radius.circular(15.0)),
          //       ),
          //     ),
          //     onChanged: (value) {
          //       // Update the list of filtered events based on the search query.
          //       setState(() {
          //         _filteredEvents = _events
          //             .where((event) => "${event.event_title}"
          //                 .toLowerCase()
          //                 .contains(value.toLowerCase()))
          //             .toList();
          //       });
          //     },
          //   ),
          // ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<List<Event>>(
                future: fetchEvents(),
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, int index) {
                        Event event = snapshot.data![index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EventPage(event: event),
                              ),
                            );
                          },
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  height: 100,
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot.data![index].pictureURL
                                        .toString(),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data![index].event_title
                                            .toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        DateFormat('EEEE, MMM d, yyyy')
                                            .format(DateTime(1)),
                                        style: TextStyle(
                                          color: AppColors.animationGreenColor,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                          snapshot
                                              .data![index].event_description
                                              .toString(),
                                          overflow: TextOverflow.ellipsis),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
