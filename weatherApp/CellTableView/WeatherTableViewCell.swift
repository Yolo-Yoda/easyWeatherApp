
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
    
    func fillWeatherCell(_ city: String,
                         _ temp: Double,
                         _ humidity: Double,
                         _ windSpeed: Double,
                         _ data: String,
                         _ icon: String,
                         _ description: Int) {
        cityLabel.text = "City: \(city), \(WeatherCondition.weatherId[description] ?? "")"
        tempLabel.text = "Temp: \(temp)"
        humidityLabel.text = "Humidity: \(humidity)"
        windSpeedLabel.text = "Wind speed: \(windSpeed)"
        dataLabel.text = "Data: \(data)"
        iconWeather.image = UIImage(named: "\(icon)")
    }
    
}
