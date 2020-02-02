import 'package:clima_app/services/weather.dart';
import 'package:clima_app/utilities/constants.dart';
import 'package:flutter/material.dart';

class LocationScreen extends StatefulWidget {
  var decodeData;

  LocationScreen(this.decodeData);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String cityName;
  int temperature;
  int condition;
  WeatherModel weatherModel = new WeatherModel();
  String message;
  String weatherIcon;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI(widget.decodeData);
  }

  void updateUI(var decodedData) {
    var temp = decodedData['main']['temp'];
    temperature = temp.toInt();
    message = weatherModel.getMessage(temperature);
    var cond = decodedData['weather'][0]['id'];
    condition = cond.toInt();
    weatherIcon = weatherModel.getWeatherIcon(condition);
    var city = decodedData['name'];
    cityName = city.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        var decodedData = weatherModel.getLocation();
                        updateUI(decodedData);
                      },
                      child: Icon(
                        Icons.near_me,
                        size: 40.0,
                      ),
                    ),
                    FlatButton(
                      onPressed: () {},
                      child: Icon(
                        Icons.location_city,
                        size: 40.0,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        weatherIcon,
                        style: kConditionTextStyle,
                      ),
                      Text(
                        '$temperature°',
                        style: kTempTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  "$message in $cityName",
                  textAlign: TextAlign.center,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
