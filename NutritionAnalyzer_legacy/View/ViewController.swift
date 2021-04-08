//
//  ViewController.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/04/05.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var foodTextField: UITextField!
    let model = NutritionModel()
    var data: [Nutrition] = []

    var addData: [Nutrition] = []
    let cellIdentifier = "NutritionTableViewCell"

    @IBAction func onTapSearchButton(_ sender: Any) {
        if let foodName = self.foodTextField.text {
            data = model.getFoodBy(foodName)
            tableView.reloadData()
        }
    }
    @IBAction func onTapAddButton(_ sender: Any) {
        model.create()
        model.fetch()
    }

    @IBAction func onTapMoveButton(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        model.initializeDB()

        setupTableView()
        refreshMasterData()
    }

    func refreshMasterData() {
        self.model.refresh()
        self.data = model.dataSource
    }

    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NutritionTableViewCell", for: indexPath) as! NutritionTableViewCell
        cell.setupCell(nutrition: data[indexPath.row])

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = NutritionDetailViewController.getViewController(data: data[indexPath.row])
        self.present(vc, animated: true, completion: nil)
    }
}
