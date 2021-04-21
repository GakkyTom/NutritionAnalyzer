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

class SearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var presenter: SearchPresentation!

    var data: [Nutrition] = []
    let cellIdentifier = "NutritionTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        presenter.viewDidLoad()
    }

    private func setupAppearance() {
    }

    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
}

extension SearchViewController: SearchView {
    func updateTableView(data: [Nutrition]) {
        self.data = data
        tableView.reloadData()
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
