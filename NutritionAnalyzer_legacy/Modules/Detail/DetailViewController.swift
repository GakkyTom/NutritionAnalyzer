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
    @IBOutlet weak var calcFieldView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var calcTextField: UITextField!

    @IBAction func calcButtonTapped(_ sender: Any) {
        presenter.calcButtonTapped()
    }

    @IBAction func addButtonTapped(_ sender: Any) {
        presenter.addButtonTapped()
    }
    
    var presenter: DetailPresentation!
    var food: Food!
    var calcedFood: Food!
    let cellIdentifier = "DetailTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()

        setupTableView()
        setupKeyboard()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }

    private func setupKeyboard() {
        self.calcTextField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            } else {
                let suggestionHeight = self.view.frame.origin.y + keyboardSize.height
                self.view.frame.origin.y -= suggestionHeight
            }
        }
    }

    private func calcNutritions(inputVal: Float) {
        calcedFood.nutritions = food.nutritions.map {
            Nutrition(nutritionName: $0.nutritionName, value: $0.value * inputVal / 100)
        }
    }

    @objc func keyboardWillHide() {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

extension DetailViewController: DetailView {
    func updateLabels(food: Food) {
        self.foodNameLabel.text = food.foodName
    }

    func updateData(food: Food) {
        self.food = food
        self.calcedFood = food
    }

    func closeDetail() {
        self.dismiss(animated: true, completion: nil)
    }

    func calcNutrition() {
        self.calcNutritions(inputVal: Float(self.calcTextField.text!)!)
        tableView.reloadData()
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        calcedFood.nutritions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! DetailTableViewCell
        cell.setupCell(nutrition: calcedFood.nutritions[indexPath.row])

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return DetailTableViewCell.cellHeight
    }
}

extension DetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
