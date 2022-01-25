class HoneyModel {
  // class properties
  int _id;
  String _type;
  String _date;
  int _amount;
  String _price;
  int _percent;

  // Constructor
  HoneyModel(this._type, this._date, this._amount, this._price, this._percent);
  HoneyModel.withId(this._id, this._type, this._date, this._amount, this._price,
      this._percent);

  // getters
  int get id => _id;
  String get type => _type;
  String get date => _date;
  int get amount => _amount;
  String get price => _price;
  int get percent => _percent;

  // setters
  set type(String newType) {
    if (newType.length <= 255) {
      _type = newType;
    }
  }

  set date(String newDate) {
    if (newDate.length <= 255) {
      _date = newDate;
    }
  }

  set amount(int newAnount) {
    _amount = newAnount;
  }

  set price(String newPrice) {
    if (newPrice.length <= 255) {
      _price = newPrice;
    }
  }

  set percent(int newPercent) {
    _percent = newPercent;
  }

  Map<String, dynamic> toMap() {
    var honeyMap = Map<String, dynamic>();
    honeyMap['type'] = _type;
    honeyMap['date'] = _date;
    honeyMap['amount'] = _amount;
    honeyMap['price'] = _price;
    honeyMap['percent'] = _percent;
    if (_id != null) {
      honeyMap['id'] = _id;
    }
    return honeyMap;
  }
}
