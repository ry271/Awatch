class UserPost {
  String _name;
  String _img;
  String _username;
  String _post;

  UserPost(this._name, this._img, this._username, this._post);

  String get name {
    return _name;
  }

  String get img {
    return _img;
  }

  String get username {
    return _username;
  }

  String get post {
    return _post;
  }

  set name(String value) {
    _name = value;
  }

  set img(String value) {
    _img = value;
  }

  set username(String value) {
    _username = value;
  }

  set post(String value) {
    _post = value;
  }
}
