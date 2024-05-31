// file to easily configure some settings of the application
const String weatherAPIURL =
    "https://api.weatherapi.com/v1/forecast.json"; // weather api url
const Duration updateDuration = Duration(
    seconds:
        30); // duration at with weather data is refreshed while in foreground

const String locationListURL =
    "https://api.npoint.io/9106e4584b96ac9d145b"; // url for locationlist stored in json keeper
