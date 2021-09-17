/// typeTemplate : "1"
/// ext : {"message":"adf"}

class IMMessage {
  String? _typeTemplate;
  Ext? _ext;

  String? get typeTemplate => _typeTemplate;
  Ext? get ext => _ext;

  IMMessage({String? typeTemplate, Ext? ext}) {
    _typeTemplate = typeTemplate;
    _ext = ext;
  }

  IMMessage.fromJson(dynamic json) {
    _typeTemplate = json['typeTemplate'];
    _ext = json['ext'] != null ? Ext.fromJson(json['ext']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['typeTemplate'] = _typeTemplate;
    if (_ext != null) {
      map['ext'] = _ext?.toJson();
    }
    return map;
  }
}

/// message : "adf"

class Ext {
  String? _message;

  String? get message => _message;

  Ext({String? message}) {
    _message = message;
  }

  Ext.fromJson(dynamic json) {
    _message = json['message'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['message'] = _message;
    return map;
  }
}
