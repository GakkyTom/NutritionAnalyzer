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

/**
 * 基本的にUIの初期セットアップのみ
 * イベントは全部presenterが処理する
 */
class SearchViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var tableView: UITableView!

    var presenter: SearchPresentation!

    var data: [Nutrition] = []
    let cellIdentifier = "SearchResultTableViewCell"

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "食材名を入力"
        searchBar.delegate = self

        return searchBar
    }()

    private var tapGestureRecognizer : UITapGestureRecognizer!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupGestureRecognizer()
        setupNavigationBar()
        presenter.viewDidLoad()
    }

    private func setupNavigationBar() {
        navigationItem.titleView = searchBar
    }

    private func setupGestureRecognizer() {
        self.tapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(self.gestureRecognizerAction))
        self.tapGestureRecognizer.delegate = self
    }

    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }

    @objc func gestureRecognizerAction(_ sender: UITapGestureRecognizer){
        self.searchBar.resignFirstResponder()
    }
}

extension SearchViewController: SearchView {
    func updateTableView(data: [Nutrition]) {
        self.data = data
        tableView.reloadData()
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let foodName = searchBar.text else { return }

        presenter.searchButtonTapped(foodName)

        searchBar.resignFirstResponder()
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        self.view.removeGestureRecognizer(tapGestureRecognizer)
        return true
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SearchResultTableViewCell
        cell.setupCell(nutrition: data[indexPath.row])

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
