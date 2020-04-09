//todo: do this with json_serializable; currently using json2dart
//todo: implement mock

/// Represents the last read position within a user's timelines.
/// https://docs.joinmastodon.org/entities/marker/
class Marker {
  /// Information about the user's position in the home timeline
  Position home;

  /// Information about the user's position in their notifications
  Position notifications;

  Marker({this.home, this.notifications});

  Marker.fromJson(Map<String, dynamic> json) {
    home = json['home'] != null ? new Position.fromJson(json['home']) : null;
    notifications = json['notifications'] != null
        ? new Position.fromJson(json['notifications'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.home != null) {
      data['home'] = this.home.toJson();
    }
    if (this.notifications != null) {
      data['notifications'] = this.notifications.toJson();
    }
    return data;
  }
}

/// Timeline position information
class Position {
  /// The ID of the most recently viewed entity
  String lastReadId;

  /// The timestamp of when the marker was set
  String updatedAt;

  /// Used for locking to prevent write conflicts
  int version;

  Position({this.lastReadId, this.version, this.updatedAt});

  Position.fromJson(Map<String, dynamic> json) {
    lastReadId = json['last_read_id'];
    version = json['version'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['last_read_id'] = this.lastReadId;
    data['version'] = this.version;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
