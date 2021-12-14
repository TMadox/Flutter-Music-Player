import 'dart:convert';

class Songmetadata {
  String? title;
  String? artist;
  String? track;
  String? album;
  String? discNumber;
  String? beatsPerMinute;
  String? year;
  String? length;
  String? albumArtist;
  String? image;
  String? path;
  String? dateAdded;
  Songmetadata(
      {required this.title,
      required this.artist,
      required this.track,
      required this.album,
      required this.discNumber,
      required this.beatsPerMinute,
      required this.year,
      required this.length,
      required this.albumArtist,
      required this.image,
      required this.dateAdded,
      required this.path});
  factory Songmetadata.fromMap(Map<String, dynamic> map) {
    return Songmetadata(
        title: map['Title'] ?? "",
        artist: map['Artist'] ?? "",
        track: map['Track'] ?? "",
        album: map['Album'] ?? "",
        discNumber: map['TPOS'] ?? "",
        beatsPerMinute: map['BPM'] ?? "",
        year: map['Year'] ?? "",
        length: map['Length'] ?? "",
        albumArtist: map['TPE2'] ?? "",
        image: map['APIC']["base64"],
        path: map["path"],
        dateAdded: map["dateAdded"]);
  }

  Map<String, dynamic> toMap() {
    return {
      'Title ': title,
      'Artist': artist,
      'Track': track,
      'Album': album,
      'TPOS': discNumber,
      'BPM': beatsPerMinute,
      'Year': year,
      'Length': length,
      'TPE2': albumArtist,
      'APIC': {'base64': image},
      'path': path,
      'dateAdded': dateAdded,
    };
  }

  String toJson() => json.encode(toMap());

  factory Songmetadata.fromJson(String source) =>
      Songmetadata.fromMap(json.decode(source));
}
