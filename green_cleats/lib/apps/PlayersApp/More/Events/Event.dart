class Event {
  String? eventId;
  String? event_title;
  String? event_description;
  String? event_date;
  String? event_date_posted;
  String? pictureURL;

  Event({
    this.eventId,
    this.event_title,
    this.event_description,
    this.event_date,
    this.event_date_posted,
    this.pictureURL,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      eventId: json['_id'],
      event_title: json['event_title'],
      event_description: json['event_description'],
      event_date: json['event_date'],
      event_date_posted: json['event_date_posted'],
      pictureURL: json['picture_url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = eventId;
    data['event_title'] = event_title;
    data['event_description'] = event_description;
    data['event_date'] = event_date;
    data['event_date_posted'] = event_date_posted;
    data['picture_url'] = pictureURL;
    return data;
  }
}
