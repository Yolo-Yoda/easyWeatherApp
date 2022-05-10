import Foundation

struct ListWeatherModel: Codable{
    var dt: Double = 0.0
    var main: MainModel = MainModel()
    var weather: [MainWeatherModel] = []
    var wind: WindWeatherModel = WindWeatherModel()
    var dt_txt: String = ""
}
