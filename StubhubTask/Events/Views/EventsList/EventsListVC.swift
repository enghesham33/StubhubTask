//
//  EventsListVC.swift
//  StubhubTask
//
//  Created by Hesham Donia on 06/08/2022.
//

import UIKit

class EventsListVC: BaseVC {
    
    let viewModel = EventsInjector.provideEventsViewModel()
    
    class func buildVC() -> EventsListVC {
        let storyboard = UIStoryboard(name: StoryboardType.Events.rawValue, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: EventsListVC.self)) as! EventsListVC
        return vc
    }

    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var andButton: UIButton!
    @IBOutlet weak var orButton: UIButton!
    @IBOutlet weak var eventsTableView: UITableView! {
        didSet {
            
            let nib = UINib(nibName: String(describing: EventCell.self), bundle: nil)
            eventsTableView.register(nib, forCellReuseIdentifier: String(describing: EventCell.self))
            
            eventsTableView.dataSource = self
            eventsTableView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.eventsList.bind { [weak self] _ in
            self?.eventsTableView.reloadData()
        }
        
        viewModel.filteredEventsList.bind { [weak self] _ in
            self?.eventsTableView.reloadData()
        }
        
        viewModel.loading.bind { [weak self] isLoading in
            if isLoading {
                self?.showLoader()
            } else {
                self?.hideLoader()
            }
        }
        
        viewModel.error.bind { [weak self] error in
            self?.showErrorMessage(text: error)
        }
        
        viewModel.getEvents()
    }
    
    @IBAction func applyFilterButtonPressed(_ sender: Any) {
        viewModel.applyFilters(city: cityNameTextField.text ?? "", price: priceTextField.text ?? "")
    }
    
    @IBAction func clearFilterButtonPressed(_ sender: Any) {
        viewModel.clearFilter()
        priceTextField.text = ""
        cityNameTextField.text = ""
    }
    
    @IBAction func andButtonPressed(_ sender: Any) {
        viewModel.filterOperation = .AND
        changeButtonsColors()
    }
    
    @IBAction func orButtonPressed(_ sender: Any) {
        viewModel.filterOperation = .OR
        changeButtonsColors()
    }
    
    private func changeButtonsColors() {
        if viewModel.filterOperation == .AND {
            orButton.setTitleColor(.blue, for: .normal)
            orButton.backgroundColor = .white
            
            andButton.setTitleColor(.white, for: .normal)
            andButton.backgroundColor = .blue
        } else {
            andButton.setTitleColor(.blue, for: .normal)
            andButton.backgroundColor = .white
            
            orButton.setTitleColor(.white, for: .normal)
            orButton.backgroundColor = .blue
        }
    }
}

extension EventsListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.isFilterApplied {
            return viewModel.filteredEventsList.value.count
        } else {
            return viewModel.eventsList.value.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EventCell.self), for: indexPath) as? EventCell {
            cell.event = viewModel.isFilterApplied ? viewModel.filteredEventsList.value[indexPath.row] : viewModel.eventsList.value[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
}
