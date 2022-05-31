
import UIKit

class WeatherTableViewCell: UITableViewCell {
   
    // MARK: - IBOutlets
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var iconWeather: UIImageView!
    
    // MARK: - Override methods
    
    override var reuseIdentifier: String? {
        return "WeatherCell"
    }
   
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Public methods
    
    public func fill(with weather: WeatherModel?, for rowNumber: Int) {
        DispatchQueue.main.async { [weak self] in
            guard let weatherList = weather?.list[rowNumber] else { return }
            self?.cityLabel.text = "City: \(weather?.city.name ?? ""), \(WeatherCondition.weatherId[weatherList.weather[0].id ] ?? "")"
            self?.tempLabel.text = "Temp: \(weatherList.main.temp)"
            self?.humidityLabel.text = "Humidity: \(weatherList.main.humidity)"
            self?.windSpeedLabel.text = "Wind speed: \(weatherList.wind.speed)"
            self?.dataLabel.text = "Data: \(weatherList.dt_txt.description)"
            self?.iconWeather.image = UIImage(named: "\(weatherList.weather[0].icon)")
        }
    }
}
