class InspectionModel {
  // class properties
  int _id;
  String _name;
  String _date;
  String _desc;

  // Constructor
  InspectionModel(this._name, this._date, [this._desc]);
  InspectionModel.withId(this._id, this._name, this._date, [this._desc]);

  // getters
  int get id => _id;
  String get name => _name;
  String get date => _date;
  String get description => _desc;

  // setters
  set name(String newName) {
    if (newName.length <= 255) {
      _name = newName;
    }
  }

  set date(String newDate) {
    if (newDate.length <= 255) {
      _date = newDate;
    }
  }

  set description(String newDescription) {
    if (newDescription.length <= 255) {
      _desc = newDescription;
    }
  }

  Map<String, dynamic> toMap() {
    var inspectionMap = Map<String, dynamic>();
    inspectionMap['name'] = _name;
    inspectionMap['date'] = _date;
    inspectionMap['description'] = _desc;
    if (_id != null) {
      inspectionMap['id'] = _id;
    }
    return inspectionMap;
  }
}
