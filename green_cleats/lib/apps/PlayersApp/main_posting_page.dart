import 'dart:io';

import 'package:flutter/material.dart';
import 'package:green_cleats/api/apis.dart';
import 'package:green_cleats/apps/PlayersApp/Chat/chat_home.dart';
import 'package:green_cleats/apps/PlayersApp/playerProfile/player_profile_view.dart';
import 'package:green_cleats/apps/PlayersApp/team/team.dart';
import 'package:green_cleats/utils/colors.dart';
import 'package:green_cleats/utils/utils.dart';
import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

// class Post {
//   String? postId;
//   final String ownerName;
//   final String text;
//   String? imageUrl;
//   final String ownerProfileImage;
//   // int likes;
//   // bool liked;
//   final String ownerId;

//   Post({
//     this.postId,
//     required this.ownerName,
//     required this.text,
//     this.imageUrl,
//     required this.ownerProfileImage,
//     // required this.likes,
//     // required this.liked,
//     required this.ownerId,
//   });

// void toggleLiked() {
//   if (liked) {
//     likes--;
//   } else {
//     likes++;
//   }
//   liked = !liked;
// }
// }

class MainPostingPage extends StatefulWidget {
  final String player_id;

  var player_name;

  MainPostingPage(
      {super.key, required this.player_id, required this.player_name});

  @override
  _MainPostingPageState createState() => _MainPostingPageState();
}

class _MainPostingPageState extends State<MainPostingPage> {
  var _posts = [];
  File? _imageFile;
  XFile? pickedFile;
  TextEditingController _textController = TextEditingController();
  TextEditingController _commentController = TextEditingController();

  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    fetchposts().then((response) {
      setState(() {
        _posts = json.decode(response.body)["data"];
        print(" Length = ${_posts.length} $_posts");
      });
    });
  }

  // Future<List<Post>> _fetchPosts() async {
  //   return Future.delayed(Duration(seconds: 1), () {
  //     return dummyPosts;
  //   });
  // }

  // Future<void> _addPost() async {
  //   // Create a new post object
  //   final newPost = Post(
  //     postId: "",
  //     ownerName: "Aadesh",
  //     text: _textController.text,
  //     imageUrl: _imageFile?.path ?? '',
  //     ownerProfileImage: "",
  //     likes: 0,
  //     liked: false,
  //     ownerId: widget.player_id
  //   );

  //   // if (_imageFile != null) {
  //   //   newPost.imageUrl = '';
  //   // }

  //   // dummyPosts.add(newPost);

  //   setState(() {
  //     _textController.clear();
  //     _imageFile = null;
  //     // _posts = _fetchPosts();
  //   });
  // }

  // void _likePost(Post post) {
  //   post.toggleLiked();
  //   setState(() {
  //     // _posts = Future.value(dummyPosts);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 26,
                        backgroundImage: AssetImage('assets/images/pic.jpg'),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _textController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppColors.whiteColor,
                                hintText: 'Write something...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: BorderSide(
                                    color: AppColors.animationGreenColor,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            if (_imageFile != null)
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    // _imageFile = null;
                                  });
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 150.0,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(_imageFile!.path),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: IconButton(
                                        icon: Icon(Icons.close),
                                        onPressed: () {
                                          setState(() {
                                            _imageFile = null;
                                          });
                                        },
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppColors.animationGreenColor)),
                        onPressed: () async {
                          String imageToBase64 = "";
                          pickedFile == null
                              ? ""
                              : imageToBase64 =
                                  await convertToBase64(pickedFile);
                          print("Posted the post");
                          uploadPost(_textController.text, imageToBase64,
                                  widget.player_id)
                              .then((res) {
                            print("response  = $res");
                            var response = res["post"];
                            setState(() {
                              var post = {
                                '_id': response["_id"],
                                'post_owner_id': response["post_owner_id"],
                                'post_content': response["post_content"],
                                'post_image_url': response["post_image_url"],
                                'post_public_id': response["post_public_id"],
                                'playerData': {
                                  'name': widget.player_name,
                                  'picture_url': trainerLocalImage,
                                },
                                'post_date': response["post_date"]
                              };
                              _posts.add(post);
                              _textController.clear();
                              _imageFile = null;
                              pickedFile = null;
                            });
                          });
                        },
                        child: Text(
                          'POST',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      IconButton(
                        // onPressed: () async {
                        //   final pickedImage = await ImagePicker()
                        //       .getImage(source: ImageSource.gallery);
                        //   if (pickedImage != null) {
                        //     setState(() {
                        //       _imageFile = File(pickedImage.path);
                        //     });
                        //   }
                        // },
                        onPressed: () async {
                          print("Posted Clicked");
                          pickedFile = await picker.pickImage(
                              source: ImageSource.gallery);
                          if (pickedFile != null) {
                            setState(() {
                              _imageFile = File(pickedFile!.path);
                            });
                          }
                        },
                        icon: Icon(
                          Icons.image_outlined,
                          size: 26,
                          color: AppColors.animationGreenColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 2.0),
              Divider(color: AppColors.animationGreenColor),
              Expanded(

                  // child: FutureBuilder<List<Post>>(
                  //   future: _posts,
                  //   builder:
                  //       (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
                  //     if (snapshot.hasData) {
                  //       return
                  child: ListView.builder(
                itemCount: _posts.length,
                itemBuilder: (BuildContext context, int index) {
                  final post = _posts[index];
                  print("$index. $post");
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.only(top: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              PopupMenuButton<String>(
                                itemBuilder: (BuildContext context) {
                                  return [
                                    PopupMenuItem(
                                      child: ListTile(
                                        leading: Icon(Icons.person),
                                        title: Text('View Profile'),
                                      ),
                                      value: "View Profile",
                                    ),
                                    PopupMenuItem(
                                      child: ListTile(
                                        leading: Icon(Icons.message),
                                        title: Text('Message'),
                                      ),
                                      value: "Message",
                                    ),
                                  ];
                                },
                                onSelected: (value) {
                                  if (value == "View Profile") {
                                    _navigateToProfile(post["post_owner_id"]);
                                  } else if (value == "Message") {
                                    _navigateToMessage(post["post_owner_id"]);
                                  }
                                },
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: AppColors.khakiColor,
                                  backgroundImage:
                                      // NetworkImage(post.profileImage),
                                      NetworkImage(post["playerData"]
                                              ["picture_url"] ??
                                          trainerLocalImage),
                                ),
                              ),
                              SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    post["playerData"]["name"],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  // Text(
                                  //   '{post.position} | {post.team}',
                                  //   style: TextStyle(
                                  //     color: Colors.grey,
                                  //     fontSize: 14,
                                  //   ),
                                  // ),
                                ],
                              ),
                              Expanded(
                                child: SizedBox(),
                              ),
                              // IconButton(
                              //   icon: Icon(
                              //     post.liked
                              //         ? Icons.sports_soccer
                              //         : Icons.sports_soccer,
                              //     color: post.liked
                              //         ? AppColors.animationGreenColor
                              //         : Colors.grey,
                              //   ),
                              //   onPressed: () => _likePost(post),
                              // ),
                              SizedBox(width: 4),
                              // Text(
                              //   "post.likes.toString()",
                              //   style: TextStyle(
                              //     color: Colors.grey,
                              //     fontSize: 14,
                              //   ),
                              // ),
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            post["post_content"],
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          if (post["post_image_url"] != null)
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      child: Image.network(
                                        post["post_image_url"]!,
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  },
                                );
                              },
                              child: SizedBox(
                                height: 200.0,
                                width: double.infinity,
                                child: Image.network(
                                  post["post_image_url"]!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          SizedBox(
                            height: 4,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '1 hour ago',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(width: 5),
                              Icon(Icons.public, size: 16, color: Colors.grey),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
                  // } else if (snapshot.hasError) {
                  //   return Text('Failed to load posts');
                  // } else {
                  //   return Center(child: CircularProgressIndicator());
                  // }
                  )
            ])));
  }

  void _navigateToProfile(String playerId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlayerProfileView(player_id: playerId),
      ),
    );
  }

  void _navigateToMessage(String playerId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatHome(player_id: playerId),
      ),
    );
  }
}
