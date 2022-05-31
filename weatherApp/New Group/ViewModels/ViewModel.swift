import Foundation


class ViewModel {
    
    // MARK: - Public properties
    
    
    
    var weatherData: Box<WeatherModel?> = Box(with: AppSettings.shared.weatherModel)
    
    // MARK: - Private properties
    
    private var apiKey = "481ffd2561d75636d6744846d09ab48a"
    
    // MARK: - Public methods
    
    func getData(city: String) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/forecast"
        urlComponents.queryItems = [URLQueryItem(name: "q", value: city),
                                    URLQueryItem(name: "appid", value: apiKey),
                                    URLQueryItem(name: "units", value: "metric")]
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        let task = URLSession(configuration: .default)
        task.dataTask(with: request) { (data, response, error) in
            if error == nil {
                let decoder = JSONDecoder()
                var decoderWeatherModel: WeatherModel?
                
                if data != nil {
                    decoderWeatherModel = try? decoder.decode(WeatherModel.self, from: data!)
                }
                DispatchQueue.global().async {
                    AppSettings.shared.weatherModel = decoderWeatherModel ?? WeatherModel()
                    self.weatherData.value = decoderWeatherModel
                }
            } else {
                print("Error: \(String(describing: error?.localizedDescription))")
            }
        }.resume()
    }
    
    
    
}
