import 'package:flutter/material.dart';
import 'package:green_cleats/apps/PlayersApp/trainerBooking/trainer_checkout.dart';
import 'package:green_cleats/utils/colors.dart';

import 'trainer_page.dart';

class TrainerDetailsPage extends StatefulWidget {
  var trainer;

  var player_id;

  TrainerDetailsPage({
    super.key,
    required this.player_id,
    required this.trainer,
  });

  @override
  _TrainerDetailsPageState createState() => _TrainerDetailsPageState();
}

class _TrainerDetailsPageState extends State<TrainerDetailsPage> {
  List _packages = [];

  int _currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    _packages = widget.trainer["data"];
  }

  Widget _buildAboutView() {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: ListView(
        shrinkWrap: true,
        children: [
          Text(
            'Description',
            style: TextStyle(
                color: AppColors.animationBlueColor,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.all(6.0),
            child: Text(
              "${widget.trainer['description']}",
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Contact Details',
            style: TextStyle(
                color: AppColors.animationBlueColor,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    text: 'Email: ',
                    style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                    children: [
                      TextSpan(
                        text: "${widget.trainer['email_address']}",
                        style: TextStyle(
                            color: AppColors.animationBlueColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Text.rich(
                  TextSpan(
                    text: 'Phone: ',
                    style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                    children: [
                      TextSpan(
                        text: "${widget.trainer['contact_number']}",
                        style: TextStyle(
                            color: AppColors.animationBlueColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Location',
            style: TextStyle(
                color: AppColors.animationBlueColor,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.all(6.0),
            child: Text(
              "${widget.trainer['location']}",
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPackagesView() {
    return Expanded(
      child: ListView.builder(
        itemCount: _packages.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return PackageDetail(
                      trainerId: widget.trainer["trainer_id"],
                      playerId: widget.player_id,
                      trainerName: widget.trainer["full_name"],
                      trainerCategory: widget.trainer["profession_category"],
                      trainerContactNumber: widget.trainer["contact_number"],
                      packageName: _packages[index]['package_name']!,
                      packagePrice:
                          _packages[index]['package_price']!.toString(),
                      packageDescription: _packages[index]
                          ['package_description']!,
                      packageImageUrl: widget.trainer['picture_url']!,
                      packageId: _packages[index]['_id']!,
                    );
                  },
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                borderOnForeground: true,
                color: AppColors.animationBlueColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            widget.trainer['picture_url']!,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _packages[index]['package_name']!,
                            style: TextStyle(
                              color: AppColors.khakiColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _packages[index]['package_price']!.toString(),
                            style: TextStyle(
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _packages[index]['package_description']!,
                            style: TextStyle(
                              color: AppColors.whiteColor,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.animationBlueColor,
        title: const Text("Trainer Profile"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => Dialog(
                  child: Image.network(
                    widget.trainer["picture_url"],
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
            child: SizedBox(
              height: 200,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      widget.trainer["picture_url"],
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    child: Text(
                      widget.trainer["full_name"],
                      style: TextStyle(
                        backgroundColor:
                            AppColors.animationBlueColor.withOpacity(0.5),
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // SizedBox(height: 16),
          Container(
            color: AppColors.animationBlueColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _currentIndex = 0;
                      });
                    },
                    child: Text(
                      "Info",
                      style: TextStyle(
                        fontSize: _currentIndex == 0 ? 20 : 18,
                        fontWeight: FontWeight.bold,
                        color: _currentIndex == 0
                            ? AppColors.whiteColor
                            : AppColors.backgroundColor,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _currentIndex = 1;
                      });
                    },
                    child: Text(
                      "Packages",
                      style: TextStyle(
                        fontSize: _currentIndex == 1 ? 20 : 18,
                        fontWeight: FontWeight.bold,
                        color: _currentIndex == 1
                            ? AppColors.whiteColor
                            : AppColors.backgroundColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _currentIndex == 0
              ? Expanded(
                  child: _buildAboutView(),
                )
              : _buildPackagesView(),
        ],
      ),
    );
  }
}

class PackageDetail extends StatelessWidget {
  final String playerId;
  final String packageName;
  final String packagePrice;
  final String packageDescription;
  final String packageImageUrl;
  final String trainerName;
  final String trainerContactNumber;
  final String trainerCategory;
  final String trainerId;
  final String packageId;

  PackageDetail({
    required this.playerId,
    required this.trainerId,
    required this.trainerName,
    required this.trainerCategory,
    required this.trainerContactNumber,
    required this.packageId,
    required this.packageName,
    required this.packagePrice,
    required this.packageDescription,
    required this.packageImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.animationBlueColor,
        title: Text(packageName),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 250,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(packageImageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      packageName,
                      style: TextStyle(
                        color: AppColors.khakiColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      packagePrice,
                      style: TextStyle(
                        color: AppColors.animationBlueColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Divider(
                  thickness: 1.0,
                  color: AppColors.animationBlueColor.withOpacity(0.08),
                  height: 32.0,
                ),
                const SizedBox(height: 8),
                Text(
                  packageDescription,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.transparent,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: SizedBox(
            width: 60,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TrainerCheckout(
                            packageId: packageId,
                            player_id: playerId,
                            trainer_id: trainerId,
                            packageName: packageName,
                            packagePrice: packagePrice,
                            trainerName: trainerName,
                            trainerCategory: trainerCategory,
                            trainerContactNumber: trainerContactNumber,
                          )),
                );
              },
              child: Text(
                'Book Me :)',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: AppColors.animationBlueColor,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
