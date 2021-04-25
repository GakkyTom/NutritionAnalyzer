//
//  DetailViewController.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/04/20.
//

import UIKit

protocol DetailView: AnyObject {
    func updateLabels(food: Food)
    func updateData(food: Food)
    func calcNutrition()
    func closeDetail()
}

class DetailViewController: UIViewController {
    @IBOutlet weak var foodNameLabel: UILabel!

    @IBOutlet weak var tableView: UITableView!
    @IBAction func calcButtonTapped(_ sender: Any) {
        presenter.calcButtonTapped()
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        presenter.addButtonTapped()
    }
    
    var presenter: DetailPresentation!
    var food: Food!
    let cellIdentifier = "DetailTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()

        setupTableView()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
}

extension DetailViewController: DetailView {
    func updateLabels(food: Food) {
        self.foodNameLabel.text = food.foodName
    }
    func updateData(food: Food) {
        self.food = food
    }

    func closeDetail() {
        self.dismiss(animated: true, completion: nil)
    }

    func calcNutrition() {

    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        food.nutritions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! DetailTableViewCell
        cell.setupCell(nutrition: food.nutritions[indexPath.row])

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return DetailTableViewCell.cellHeight
    }
}
