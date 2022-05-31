import Foundation
import UIKit

class AppSettings {
    
    public static var shared = AppSettings()
    
    private init() { }
    
    var weatherModel: WeatherModel {
        get {
            guard let data = UserDefaults.standard.data(forKey: UserDefaultsKeys.weatherModel.rawValue)
            else { return WeatherModel() }
            let decoder = JSONDecoder()
            let decodedWeatherModel = try? decoder.decode(WeatherModel.self, from: data)
            return decodedWeatherModel ?? WeatherModel()
        }
        set (newWeatherModel) {
            let encoder = JSONEncoder()
            let encodedData = try? encoder.encode(newWeatherModel)
            UserDefaults.standard.set(encodedData, forKey: UserDefaultsKeys.weatherModel.rawValue)
        }
    }
}
