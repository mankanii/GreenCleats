class Player {
  String? playerId;
  String? playerName;
  // String? playerEmail;
  // int? playerContactNumber;
  // String? playerDOB;
  // String? playerGender;
  // String? playerPosition;
  // String? playerDescription;
  // String? playerAchievement;
  // String? playerExperience;
  // String? playerAge;
  // String? playerTeamId;
  String? playerPicturePublicId;
  String? pictureURL;

  Player({
    this.playerId,
    this.playerName,
    // this.playerEmail,
    // this.playerContactNumber,
    // this.playerDOB,
    // this.playerGender,
    // this.playerPosition,
    // this.playerDescription,
    // this.playerAchievement,
    // this.playerExperience,
    // this.playerAge,
    // this.playerTeamId,
    this.playerPicturePublicId,
    this.pictureURL,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      playerId: json['player_id'],
      playerName: json['name'],
      // playerEmail: json['email_address'],
      // playerContactNumber: json['contact_number'],
      // playerDOB: json['date_of_birth'],
      // playerGender: json['gender'],
      // playerPosition: json['position'],
      // playerDescription: json['description'],
      // playerAchievement: json['achievements'],
      // playerExperience: json['experience'],
      // playerAge: json['age'],
      // playerTeamId: json['team_id'],
      playerPicturePublicId: json['picture_public_id'],
      pictureURL: json['picture_url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['player_id'] = playerId;
    data['name'] = playerName;
    // data['email_address'] = playerEmail;
    // data['contact_number'] = playerContactNumber;
    // data['date_of_birth'] = playerDOB;
    // data['gender'] = playerGender;
    // data['position'] = playerPosition;
    // data['description'] = playerDescription;
    // data['achievements'] = playerAchievement;
    // data['experience'] = playerExperience;
    // data['age'] = playerAge;
    // data['team_id'] = playerTeamId;
    data['picture_public_id'] = playerPicturePublicId;
    data['picture_url'] = pictureURL;
    return data;
  }
}
