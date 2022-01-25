class Notes {
  int _id;
  String _title;
  String _desc;
  String _date;

  Notes(this._title, this._date, [this._desc]);

  Notes.withId(this._id, this._title, this._date, [this._desc]);

  int get id => _id;

  String get title => _title;

  String get desc => _desc;

  String get date => _date;

  set title(String newTitle) {
    if (newTitle.length <= 255) {
      this._title = newTitle;
    }
  }

  set desc(String newDesc) {
    if (newDesc.length <= 255) {
      this._desc = newDesc;
    }
  }

  set date(String newDate) {
    this._date = newDate;
  }

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['desc'] = _desc;
    map['date'] = _date;

    return map;
  }

  // Extract a Note object from a Map object
  Notes.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._desc = map['desc'];
    this._date = map['date'];
  }
}
