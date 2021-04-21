//
//  SearchViewController.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/04/20.
//

import UIKit

protocol SearchView: AnyObject {
    func updateTableView(data: [Nutrition])
}

class SearchViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBoxTextField: UITextField!

    var presenter: SearchPresentation!

    var data: [Nutrition] = []
    let cellIdentifier = "NutritionTableViewCell"
    private var tapGestureRecognizer : UITapGestureRecognizer!

    @IBAction func searchButtonTapped(_ sender: Any) {
        if let foodName = self.searchBoxTextField.text {
            self.searchBoxTextField.resignFirstResponder()
            presenter.searchButtonTapped(foodName)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setGestureRecognizer()
        setupAppearance()
        presenter.viewDidLoad()
    }

    private func setupAppearance() {
        self.searchBoxTextField.delegate = self
    }

    private func setGestureRecognizer() {
        self.tapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(self.gestureRecognizerAction))
        self.tapGestureRecognizer.delegate = self
    }

    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }

    @objc func gestureRecognizerAction(_ sender: UITapGestureRecognizer){
        self.searchBoxTextField.resignFirstResponder()
    }
}

extension SearchViewController: SearchView {
    func updateTableView(data: [Nutrition]) {
        self.data = data
        tableView.reloadData()
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.searchBoxTextField.resignFirstResponder()
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.view.addGestureRecognizer(tapGestureRecognizer)
        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        self.view.removeGestureRecognizer(tapGestureRecognizer)
        return true
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NutritionTableViewCell", for: indexPath) as! NutritionTableViewCell
        cell.setupCell(nutrition: data[indexPath.row], actual: 5.5, planned: 8.0, percentage: 0.8)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRow(food: data[indexPath.row])

        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return NutritionTableViewCell.cellHeight
    }
}
