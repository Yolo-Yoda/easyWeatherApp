import Foundation

struct WeatherModel: Codable{
    var cod: String = ""
    var message: Double = 0.0
    var cnt: Double = 0.0
    var list: [ListWeatherModel] = []
    var city: CityWeatherModel = CityWeatherModel()
}
