class Slot {
  String? id;
  String? Time;
  // String? endTime;

  Slot({
    required this.id,
    required this.Time,
    // required this.endTime,
  });

  static List<Slot> slotsList() {
    return [
      Slot(id: '01', Time: "8:00"),
      Slot(id: '02', Time: "9:00"),
      Slot(id: '03', Time: "10:00"),
      Slot(id: '04', Time: "11:00"),
    ];
  }
}
