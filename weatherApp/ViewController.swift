import UIKit

class ViewController: UIViewController, UISearchResultsUpdating{
    
    // MARK: - Public properties
    
    var weatherData = AppSettings.shared.weatherModel {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var dataIsReady: Bool = false
    var apiKey = "481ffd2561d75636d6744846d09ab48a"
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllerBar()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: "WeatherTableViewCell", bundle: nil), forCellReuseIdentifier: "WeatherCell")
    }
    
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
                    self.weatherData = AppSettings.shared.weatherModel
                }
            } else {
                print("Error: \(String(describing: error?.localizedDescription))")
            }
        }.resume()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let city = searchController.searchBar.text!
        getData(city: city)
    }
    
    // MARK: - Private methods
    
    fileprivate func setupViewControllerBar () {
        self.navigationItem.title = "Weather App"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Enter the city"
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

// MARK: - Public Extension

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Public methods of extension
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weatherData.list.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as? WeatherTableViewCell else { return UITableViewCell() }
        guard weatherData.list.count > 0 else { return cell}
        cell.fillWeatherCell(self.weatherData.city.name ,
                             self.weatherData.list[indexPath.row].main.temp ,
                             self.weatherData.list[indexPath.row].main.humidity ,
                             self.weatherData.list[indexPath.row].wind.speed,
                             self.weatherData.list[indexPath.row].dt_txt.description,
                             self.weatherData.list[indexPath.row].weather[0].icon,
                             self.weatherData.list[indexPath.row].weather[0].id)
        let numberOfRow = indexPath.row
        if numberOfRow % 2 == 0 {
            cell.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        }else{
            cell.backgroundColor = UIColor.lightGray.withAlphaComponent(0.8)
        }
        return cell
    }
}


