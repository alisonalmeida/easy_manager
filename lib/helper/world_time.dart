// To parse this JSON data, do
//
//     final worldTime = worldTimeFromJson(jsonString);

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

WorldTime worldTimeFromJson(String str) => WorldTime.fromJson(json.decode(str));

String worldTimeToJson(WorldTime data) => json.encode(data.toJson());

class WorldTime {
  WorldTime({
    this.abbreviation,
    this.clientIp,
    this.datetime,
    this.dayOfWeek,
    this.dayOfYear,
    this.dst,
    this.dstFrom,
    this.dstOffset,
    this.dstUntil,
    this.rawOffset,
    this.timezone,
    this.unixtime,
    this.utcDatetime,
    this.utcOffset,
    this.weekNumber,
  });

  String? abbreviation;
  String? clientIp;
  DateTime? datetime;
  int? dayOfWeek;
  int? dayOfYear;
  bool? dst;
  dynamic dstFrom;
  int? dstOffset;
  dynamic dstUntil;
  int? rawOffset;
  String? timezone;
  int? unixtime;
  DateTime? utcDatetime;
  String? utcOffset;
  int? weekNumber;

  factory WorldTime.fromJson(Map<String, dynamic> json) => WorldTime(
        abbreviation: json["abbreviation"],
        clientIp: json["client_ip"],
        datetime: DateTime.parse(json["datetime"]),
        dayOfWeek: json["day_of_week"],
        dayOfYear: json["day_of_year"],
        dst: json["dst"],
        dstFrom: json["dst_from"],
        dstOffset: json["dst_offset"],
        dstUntil: json["dst_until"],
        rawOffset: json["raw_offset"],
        timezone: json["timezone"],
        unixtime: json["unixtime"],
        utcDatetime: DateTime.parse(json["utc_datetime"]),
        utcOffset: json["utc_offset"],
        weekNumber: json["week_number"],
      );

  Map<String, dynamic> toJson() => {
        "abbreviation": abbreviation,
        "client_ip": clientIp,
        "datetime": datetime!.toIso8601String(),
        "day_of_week": dayOfWeek,
        "day_of_year": dayOfYear,
        "dst": dst,
        "dst_from": dstFrom,
        "dst_offset": dstOffset,
        "dst_until": dstUntil,
        "raw_offset": rawOffset,
        "timezone": timezone,
        "unixtime": unixtime,
        "utc_datetime": utcDatetime!.toIso8601String(),
        "utc_offset": utcOffset,
        "week_number": weekNumber,
      };

  @override
  String toString() {
    return 'WorldTime(abbreviation: $abbreviation, clientIp: $clientIp, datetime: $datetime, dayOfWeek: $dayOfWeek, dayOfYear: $dayOfYear, dst: $dst, dstFrom: $dstFrom, dstOffset: $dstOffset, dstUntil: $dstUntil, rawOffset: $rawOffset, timezone: $timezone, unixtime: $unixtime, utcDatetime: $utcDatetime, utcOffset: $utcOffset, weekNumber: $weekNumber)';
  }

  static Future _getDataFromAPI() async {
    try {
      http.Response response = await http.get(
          Uri.parse('https://worldtimeapi.org/api/timezone/America/Boa_Vista'));

      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body);

        return map;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future getDateFormatted() async {
    try {
      dynamic v = await WorldTime._getDataFromAPI();
      WorldTime x = WorldTime.fromJson(v);
      DateFormat dateFormat = DateFormat('yyyMMddHHmmss');
      String formattedDate = dateFormat.format(x.datetime!.toLocal());
      return formattedDate;
    } catch (e) {
      throw Exception(e);
    }
  }
}
