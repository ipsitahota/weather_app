import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/constraints.dart';
import 'package:weather_app/items/weather_item.dart';

class DetailPage extends StatefulWidget {
  final dailyForecastWeather;

  const DetailPage({super.key, this.dailyForecastWeather});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final Constants _constants = Constants();

  double getResponsiveSize(double baseSize, Size size) {
    // Adjust the base size according to the screen size
    return baseSize * (size.width / 375.0); // Assuming base screen width is 375
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var weatherData = widget.dailyForecastWeather;
    print(weatherData);

    //function to get weather
    Map getForecastWeather(int index) {
      int maxWindSpeed = weatherData[index]["day"]["maxwind_kph"].toInt();
      int avgHumidity = weatherData[index]["day"]["avghumidity"].toInt();
      int chanceOfRain =
          weatherData[index]["day"]["daily_chance_of_rain"].toInt();

      var parsedDate = DateTime.parse(weatherData[index]["date"]);
      var forecastDate = DateFormat('EEEE, d MMMM').format(parsedDate);

      String weatherName = weatherData[index]["day"]["condition"]["text"];
      String weatherIcon =
          weatherName.replaceAll(' ', '').toLowerCase() + ".png";

      int minTemperature = weatherData[index]["day"]["mintemp_c"].toInt();
      int maxTemperature = weatherData[index]["day"]["maxtemp_c"].toInt();

      var forecastData = {
        'maxWindSpeed': maxWindSpeed,
        'avgHumidity': avgHumidity,
        'chanceOfRain': chanceOfRain,
        'forecastDate': forecastDate,
        'weatherName': weatherName,
        'weatherIcon': weatherIcon,
        'minTemperature': minTemperature,
        'maxTemperature': maxTemperature
      };
      print(weatherData[index]);
      return forecastData;
    }

    return Scaffold(
      backgroundColor: _constants.primaryColor,
      appBar: AppBar(
        title: const Text('Forecasts',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: _constants.primaryColor,
        elevation: 0.0,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: getResponsiveSize(8.0, size)),
           
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              height: size.height * .80,
              width: size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -getResponsiveSize(50, size),
                    right: getResponsiveSize(20, size),
                    left: getResponsiveSize(20, size),
                    child: Container(
                      height: getResponsiveSize(300, size),
                      width: size.width * .7,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.center,
                            colors: [
                              Color(0xffa9c1f5),
                              Color(0xff6696f5),
                            ]),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(.1),
                            offset: const Offset(0, 25),
                            blurRadius: 3,
                            spreadRadius: -10,
                          ),
                        ],
                        borderRadius:
                            BorderRadius.circular(getResponsiveSize(15, size)),
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
//-----------------------------------------------------------------------------------------------------------------------
//
                          Positioned(
                            child: Image.asset("assets/" +
                                getForecastWeather(0)["weatherIcon"]),
                            width: getResponsiveSize(150, size),
                          ),
                          Positioned(
                              top: getResponsiveSize(150, size),
                              left: getResponsiveSize(30, size),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    bottom: getResponsiveSize(10, size)),
                                child: Text(
                                  getForecastWeather(0)["weatherName"],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: getResponsiveSize(20, size)),
                                ),
                              )),
                          Positioned(
                            bottom: getResponsiveSize(20, size),
                            left: getResponsiveSize(20, size),
                            child: Container(
                              width: size.width * .8,
                              padding: EdgeInsets.symmetric(
                                  horizontal: getResponsiveSize(20, size)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  WeatherItem(
                                    value:
                                        getForecastWeather(0)["maxWindSpeed"],
                                    unit: "km/h",
                                    imageUrl: "assets/windspeed.png",
                                  ),
                                  WeatherItem(
                                    value: getForecastWeather(0)["avgHumidity"],
                                    unit: "%",
                                    imageUrl: "assets/humidity.png",
                                  ),
                                  WeatherItem(
                                    value:
                                        getForecastWeather(0)["chanceOfRain"],
                                    unit: "%",
                                    imageUrl: "assets/lightrain.png",
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: getResponsiveSize(20, size),
                            right: getResponsiveSize(20, size),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  getForecastWeather(0)["maxTemperature"]
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: getResponsiveSize(80, size),
                                    fontWeight: FontWeight.bold,
                                    foreground: Paint()
                                      ..shader = _constants.shader,
                                  ),
                                ),
                                Text(
                                  'o',
                                  style: TextStyle(
                                    fontSize: getResponsiveSize(40, size),
                                    fontWeight: FontWeight.bold,
                                    foreground: Paint()
                                      ..shader = _constants.shader,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: getResponsiveSize(310, size),
                            left: 0,
                            child: SizedBox(
                              height: getResponsiveSize(400, size),
                              width: size.width * .9,
                              child: ListView(
                                physics: const BouncingScrollPhysics(),
                                children: [
                                  Card(
                                    elevation: 3.0,
                                    margin: EdgeInsets.only(
                                        bottom: getResponsiveSize(10, size)),
                                    child: Padding(
                                      padding: EdgeInsets.all(
                                          getResponsiveSize(8.0, size)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                getForecastWeather(
                                                    0)["forecastDate"],
                                                style: TextStyle(
                                                  color: Color(0xff6696f5),
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: getResponsiveSize(
                                                      16, size),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        getForecastWeather(0)[
                                                                "minTemperature"]
                                                            .toString(),
                                                        style: TextStyle(
                                                          color: _constants
                                                              .greyColor,
                                                          fontSize:
                                                              getResponsiveSize(
                                                                  30, size),
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      Text(
                                                        '°',
                                                        style: TextStyle(
                                                          color: _constants
                                                              .greyColor,
                                                          fontSize:
                                                              getResponsiveSize(
                                                                  30,
                                                                  size), // Adjust size as needed
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        getForecastWeather(0)[
                                                                "maxTemperature"]
                                                            .toString(),
                                                        style: TextStyle(
                                                          color: _constants
                                                              .blackColor,
                                                          fontSize:
                                                              getResponsiveSize(
                                                                  30, size),
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      Text(
                                                        '°',
                                                        style: TextStyle(
                                                          color: _constants
                                                              .blackColor,
                                                          fontSize:
                                                              getResponsiveSize(
                                                                  30,
                                                                  size), // Adjust size as needed
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: getResponsiveSize(10, size),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    'assets/' +
                                                        getForecastWeather(
                                                            0)["weatherIcon"],
                                                    width: getResponsiveSize(
                                                        30, size),
                                                  ),
                                                  SizedBox(
                                                    width: getResponsiveSize(
                                                        5, size),
                                                  ),
                                                  Text(
                                                    getForecastWeather(
                                                        0)["weatherName"],
                                                    style: TextStyle(
                                                      fontSize:
                                                          getResponsiveSize(
                                                              16, size),
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    getForecastWeather(0)[
                                                                "chanceOfRain"]
                                                            .toString() +
                                                        "%",
                                                    style: TextStyle(
                                                      fontSize:
                                                          getResponsiveSize(
                                                              18, size),
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: getResponsiveSize(
                                                        5, size),
                                                  ),
                                                  Image.asset(
                                                    'assets/lightrain.png',
                                                    width: getResponsiveSize(
                                                        30, size),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Card(
                                    elevation: 3.0,
                                    margin: EdgeInsets.only(
                                        bottom: getResponsiveSize(10, size)),
                                    child: Padding(
                                      padding: EdgeInsets.all(
                                          getResponsiveSize(8.0, size)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                getForecastWeather(
                                                    1)["forecastDate"],
                                                style: TextStyle(
                                                  color: Color(0xff6696f5),
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: getResponsiveSize(
                                                      16, size),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        getForecastWeather(1)[
                                                                "minTemperature"]
                                                            .toString(),
                                                        style: TextStyle(
                                                          color: _constants
                                                              .greyColor,
                                                          fontSize:
                                                              getResponsiveSize(
                                                                  30, size),
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      Text(
                                                        '°',
                                                        style: TextStyle(
                                                          color: _constants
                                                              .greyColor,
                                                          fontSize:
                                                              getResponsiveSize(
                                                                  30,
                                                                  size), // Adjust size as needed
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        getForecastWeather(1)[
                                                                "maxTemperature"]
                                                            .toString(),
                                                        style: TextStyle(
                                                          color: _constants
                                                              .blackColor,
                                                          fontSize:
                                                              getResponsiveSize(
                                                                  30, size),
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      Text(
                                                        '°',
                                                        style: TextStyle(
                                                          color: _constants
                                                              .blackColor,
                                                          fontSize:
                                                              getResponsiveSize(
                                                                  30,
                                                                  size), // Adjust size as needed
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: getResponsiveSize(10, size),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    'assets/' +
                                                        getForecastWeather(
                                                            1)["weatherIcon"],
                                                    width: getResponsiveSize(
                                                        30, size),
                                                  ),
                                                  SizedBox(
                                                    width: getResponsiveSize(
                                                        5, size),
                                                  ),
                                                  Text(
                                                    getForecastWeather(
                                                        1)["weatherName"],
                                                    style: TextStyle(
                                                      fontSize:
                                                          getResponsiveSize(
                                                              16, size),
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    getForecastWeather(1)[
                                                                "chanceOfRain"]
                                                            .toString() +
                                                        "%",
                                                    style: TextStyle(
                                                      fontSize:
                                                          getResponsiveSize(
                                                              18, size),
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: getResponsiveSize(
                                                        5, size),
                                                  ),
                                                  Image.asset(
                                                    'assets/lightrain.png',
                                                    width: getResponsiveSize(
                                                        30, size),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Card(
                                    elevation: 3.0,
                                    margin: EdgeInsets.only(
                                        bottom: getResponsiveSize(20, size)),
                                    child: Padding(
                                      padding: EdgeInsets.all(
                                          getResponsiveSize(8.0, size)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                getForecastWeather(
                                                    2)["forecastDate"],
                                                style: TextStyle(
                                                  color: Color(0xff6696f5),
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: getResponsiveSize(
                                                      16, size),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        getForecastWeather(2)[
                                                                "minTemperature"]
                                                            .toString(),
                                                        style: TextStyle(
                                                          color: _constants
                                                              .greyColor,
                                                          fontSize:
                                                              getResponsiveSize(
                                                                  30, size),
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      Text(
                                                        '°',
                                                        style: TextStyle(
                                                          color: _constants
                                                              .greyColor,
                                                          fontSize:
                                                              getResponsiveSize(
                                                                  30,
                                                                  size), // Adjust size as needed
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        getForecastWeather(2)[
                                                                "maxTemperature"]
                                                            .toString(),
                                                        style: TextStyle(
                                                          color: _constants
                                                              .blackColor,
                                                          fontSize:
                                                              getResponsiveSize(
                                                                  30, size),
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      Text(
                                                        '°',
                                                        style: TextStyle(
                                                          color: _constants
                                                              .blackColor,
                                                          fontSize:
                                                              getResponsiveSize(
                                                                  30,
                                                                  size), // Adjust size as needed
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: getResponsiveSize(10, size),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    'assets/' +
                                                        getForecastWeather(
                                                            2)["weatherIcon"],
                                                    width: getResponsiveSize(
                                                        30, size),
                                                  ),
                                                  SizedBox(
                                                    width: getResponsiveSize(
                                                        5, size),
                                                  ),
                                                  Text(
                                                    getForecastWeather(
                                                        2)["weatherName"],
                                                    style: TextStyle(
                                                      fontSize:
                                                          getResponsiveSize(
                                                              16, size),
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    getForecastWeather(2)[
                                                                "chanceOfRain"]
                                                            .toString() +
                                                        "%",
                                                    style: TextStyle(
                                                      fontSize:
                                                          getResponsiveSize(
                                                              18, size),
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: getResponsiveSize(
                                                        5, size),
                                                  ),
                                                  Image.asset(
                                                    'assets/lightrain.png',
                                                    width: getResponsiveSize(
                                                        30, size),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
