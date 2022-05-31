import UIKit

class ViewController: UIViewController, UISearchResultsUpdating{
    
    // MARK: - Public properties
    
    let viewModel = ViewModel()
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        setupBinds()
        setupViewControllerBar()
    }
    
    
    // MARK: - Public methods
    
    func updateSearchResults(for searchController: UISearchController) {
        let city = searchController.searchBar.text!
        viewModel.getData(city: city)
    }
    
    // MARK: - Private methods
    
    private func setupBinds() {
        viewModel.weatherData.bind { [weak self] newWeather in
            guard newWeather != nil else {return}
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    private func setupDelegates() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: "WeatherTableViewCell", bundle: nil), forCellReuseIdentifier: "WeatherCell")
    }
    
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.weatherData.value?.list.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as? WeatherTableViewCell else { return UITableViewCell() }
        guard viewModel.weatherData.value?.list.count ?? 0 > 0 else { return cell}
        cell.fill(with: self.viewModel.weatherData.value, for: indexPath.row)
        let numberOfRow = indexPath.row
        if numberOfRow % 2 == 0 {
            cell.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        }else{
            cell.backgroundColor = UIColor.lightGray.withAlphaComponent(0.8)
        }
        return cell
    }
}


