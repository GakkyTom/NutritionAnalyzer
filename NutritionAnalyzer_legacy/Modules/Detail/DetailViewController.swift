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
    func closeDetail()
    func updateNutritions(nutritions: [Nutrition])
}

class DetailViewController: UIViewController, UIGestureRecognizerDelegate {

    var presenter: DetailPresentation!
    var food: Food!
    private let cellIdentifier = "DetailTableViewCell"
    private var tapGestureRecognizer : UITapGestureRecognizer!

    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var calcFieldView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var gramTextField: UITextField!
    @IBOutlet weak var eatDatePicker: UIDatePicker!

    @IBAction func calcButtonTapped(_ sender: Any) {
        if let gramString = gramTextField.text,
           let gramFloat = Float(gramString) {
            presenter.calcButtonTapped(foodQt: gramFloat)
        }

        self.gramTextField.resignFirstResponder()
    }

    @IBAction func addButtonTapped(_ sender: Any) {

        let foodQt: Float = gramTextField.text! == "" ? 100 : Float(gramTextField.text!)!

        presenter.addButtonTapped(food: food, foodQt: foodQt, eatDate: eatDatePicker.date)
    }

    //
    // MARK: override method
    //

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()

        setupTableView()
        setupKeyboard()
        setupGestureRecognizer()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    //
    // MARK: private method
    //

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }

    private func setupKeyboard() {
        self.gramTextField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func setupGestureRecognizer() {
        self.tapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(self.gestureRecognizerAction))
        self.tapGestureRecognizer.delegate = self
    }

    //
    // MARK: @objc method
    //

    @objc func gestureRecognizerAction(_ sender: UITapGestureRecognizer){
        self.gramTextField.resignFirstResponder()
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

    @objc func keyboardWillHide() {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
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
        self.navigationController?.popViewController(animated: true)
    }

    func updateNutritions(nutritions: [Nutrition]) {
        food.nutritions = nutritions
        tableView.reloadData()
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

extension DetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        self.view.removeGestureRecognizer(tapGestureRecognizer)
    }
}
