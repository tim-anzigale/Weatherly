class WeatherModel {
  final double lat;
  final double lon;
  final String timezone;
  final int timezoneOffset;
  final CurrentWeather current;
  final List<MinutelyForecast>? minutely;
  final List<HourlyForecast>? hourly;
  final List<DailyForecast>? daily;
  final List<WeatherAlert>? alerts;

  WeatherModel({
    required this.lat,
    required this.lon,
    required this.timezone,
    required this.timezoneOffset,
    required this.current,
    this.minutely,
    this.hourly,
    this.daily,
    this.alerts,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      lat: json['lat'],
      lon: json['lon'],
      timezone: json['timezone'],
      timezoneOffset: json['timezone_offset'],
      current: CurrentWeather.fromJson(json['current']),
      minutely: json['minutely'] != null
          ? List<MinutelyForecast>.from(
              json['minutely'].map((x) => MinutelyForecast.fromJson(x)))
          : null,
      hourly: json['hourly'] != null
          ? List<HourlyForecast>.from(
              json['hourly'].map((x) => HourlyForecast.fromJson(x)))
          : null,
      daily: json['daily'] != null
          ? List<DailyForecast>.from(
              json['daily'].map((x) => DailyForecast.fromJson(x)))
          : null,
      alerts: json['alerts'] != null
          ? List<WeatherAlert>.from(
              json['alerts'].map((x) => WeatherAlert.fromJson(x)))
          : null,
    );
  }
}

class CurrentWeather {
  final int dt;
  final int sunrise;
  final int sunset;
  final double temp;
  final double feelsLike;
  final int pressure;
  final int humidity;
  final double dewPoint;
  final int clouds;
  final int visibility;
  final double windSpeed;
  final int windDeg;
  final List<WeatherCondition> weather;

  CurrentWeather({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.clouds,
    required this.visibility,
    required this.windSpeed,
    required this.windDeg,
    required this.weather,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      dt: json['dt'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
      temp: json['temp'].toDouble(),
      feelsLike: json['feels_like'].toDouble(),
      pressure: json['pressure'],
      humidity: json['humidity'],
      dewPoint: json['dew_point'].toDouble(),
      clouds: json['clouds'],
      visibility: json['visibility'],
      windSpeed: json['wind_speed'].toDouble(),
      windDeg: json['wind_deg'],
      weather: List<WeatherCondition>.from(
          json['weather'].map((x) => WeatherCondition.fromJson(x))),
    );
  }
}

class WeatherCondition {
  final int id;
  final String main;
  final String description;
  final String icon;

  WeatherCondition({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory WeatherCondition.fromJson(Map<String, dynamic> json) {
    return WeatherCondition(
      id: json['id'],
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
    );
  }
}

class MinutelyForecast {
  final int dt;
  final double precipitation;

  MinutelyForecast({required this.dt, required this.precipitation});

  factory MinutelyForecast.fromJson(Map<String, dynamic> json) {
    return MinutelyForecast(
      dt: json['dt'],
      precipitation: json['precipitation'].toDouble(),
    );
  }
}

class HourlyForecast {
  final int dt;
  final double temp;
  final double feelsLike;
  final int pressure;
  final int humidity;
  final double dewPoint;
  final int clouds;
  final int visibility;
  final double windSpeed;
  final int windDeg;
  final double pop;
  final List<WeatherCondition> weather;

  HourlyForecast({
    required this.dt,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.clouds,
    required this.visibility,
    required this.windSpeed,
    required this.windDeg,
    required this.pop,
    required this.weather,
  });

  factory HourlyForecast.fromJson(Map<String, dynamic> json) {
    return HourlyForecast(
      dt: json['dt'],
      temp: json['temp'].toDouble(),
      feelsLike: json['feels_like'].toDouble(),
      pressure: json['pressure'],
      humidity: json['humidity'],
      dewPoint: json['dew_point'].toDouble(),
      clouds: json['clouds'],
      visibility: json['visibility'],
      windSpeed: json['wind_speed'].toDouble(),
      windDeg: json['wind_deg'],
      pop: json['pop'].toDouble(),
      weather: List<WeatherCondition>.from(
          json['weather'].map((x) => WeatherCondition.fromJson(x))),
    );
  }
}

class DailyForecast {
  final int dt;
  final int sunrise;
  final int sunset;
  final double tempDay;
  final double tempMin;
  final double tempMax;
  final double tempNight;
  final double feelsLikeDay;
  final int pressure;
  final int humidity;
  final double dewPoint;
  final double windSpeed;
  final int windDeg;
  final int clouds;
  final double pop;
  final List<WeatherCondition> weather;

  DailyForecast({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.tempDay,
    required this.tempMin,
    required this.tempMax,
    required this.tempNight,
    required this.feelsLikeDay,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.windSpeed,
    required this.windDeg,
    required this.clouds,
    required this.pop,
    required this.weather,
  });

  factory DailyForecast.fromJson(Map<String, dynamic> json) {
    return DailyForecast(
      dt: json['dt'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
      tempDay: json['temp']['day'].toDouble(),
      tempMin: json['temp']['min'].toDouble(),
      tempMax: json['temp']['max'].toDouble(),
      tempNight: json['temp']['night'].toDouble(),
      feelsLikeDay: json['feels_like']['day'].toDouble(),
      pressure: json['pressure'],
      humidity: json['humidity'],
      dewPoint: json['dew_point'].toDouble(),
      windSpeed: json['wind_speed'].toDouble(),
      windDeg: json['wind_deg'],
      clouds: json['clouds'],
      pop: json['pop'].toDouble(),
      weather: List<WeatherCondition>.from(
          json['weather'].map((x) => WeatherCondition.fromJson(x))),
    );
  }
}

class WeatherAlert {
  final String senderName;
  final String event;
  final int start;
  final int end;
  final String description;

  WeatherAlert({
    required this.senderName,
    required this.event,
    required this.start,
    required this.end,
    required this.description,
  });

  factory WeatherAlert.fromJson(Map<String, dynamic> json) {
    return WeatherAlert(
      senderName: json['sender_name'],
      event: json['event'],
      start: json['start'],
      end: json['end'],
      description: json['description'],
    );
  }

}


