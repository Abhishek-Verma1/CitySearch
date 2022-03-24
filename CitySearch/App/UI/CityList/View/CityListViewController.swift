//
//  CityListViewController.swift
//  CitySearch
//
//  Created by Abhishek Verma on 23/02/2022.
//

import UIKit

class CityListViewController: UIViewController {
    
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var waitIndicator: UIActivityIndicatorView!
    var viewModel: CityListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.bindUI()
        self.title = self.viewModel.title
        self.viewModel.viewDidLoad()
        self.viewModel.cityView = self
    }
    
    private func bindUI(){
        self.viewModel.showData = { [weak self] in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        self.viewModel.showLoader = {
            DispatchQueue.main.async {
                self.waitIndicator.startAnimating()
                self.searchBar.isHidden = true
            }
        }
        
        self.viewModel.hideLoader = {
            DispatchQueue.main.async {
                self.waitIndicator.stopAnimating()
                self.searchBar.isHidden = false
                if let error = self.viewModel.alertMessage {
                    self.showAlert(error)
                    self.searchBar.isHidden = true
                }
            }
        }
    }
    
    
}

extension CityListViewController: CityView {
    func reload() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension CityListViewController {
    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension CityListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cell")
        
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = viewModel.getTitle(at: indexPath.row)
        cell.detailTextLabel?.text = viewModel.getSubTitle(at: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        self.viewModel.didTapOnCity(of: indexPath.row)
    }
}

extension CityListViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
        viewModel.filter("")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let keyword = searchBar.text else { return }
        viewModel.filter(keyword)
    }
}
