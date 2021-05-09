//
//  DetailViewController.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/04/20.
//

import UIKit

protocol DetailView: AnyObject {
    func updateLabels(foodDetail: FoodDetail)
    func updateData(foodDetail: FoodDetail)
    func closeDetail()
    func updateNutritions(nutritions: [Nutrition])
    func setupTableView()
    func setupKeyboard()
    func setupGestureRecognizer()
}

class DetailViewController: UIViewController, UIGestureRecognizerDelegate {

    var presenter: DetailPresentation!
    var foodDetail: FoodDetail!
    private let cellIdentifier = "DetailTableViewCell"
    private var tapGestureRecognizer : UITapGestureRecognizer!

    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var calcFieldView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var gramTextField: UITextField!
    @IBOutlet weak var eatDatePicker: UIDatePicker!

    @IBAction func calcButtonTapped(_ sender: Any) {
        if let gramString = gramTextField.text,
           let gramDouble = Double(gramString) {
            presenter.calcButtonTapped(foodQt: gramDouble)
        }

        self.gramTextField.resignFirstResponder()
    }

    @IBAction func addButtonTapped(_ sender: Any) {

        let foodQt: Double = gramTextField.text! == "" ? 100 : Double(gramTextField.text!)!

        presenter.addButtonTapped(foodDetail: foodDetail, foodQt: foodQt, eatDate: eatDatePicker.date)
    }

    //
    // MARK: override method
    //

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()


    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
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
    func updateLabels(foodDetail: FoodDetail) {
        self.foodNameLabel.text = foodDetail.foodName
    }

    func updateData(foodDetail: FoodDetail) {
        self.foodDetail = foodDetail
    }

    func closeDetail() {
        self.navigationController?.popViewController(animated: true)
    }

    func updateNutritions(nutritions: [Nutrition]) {
        foodDetail.nutritions = nutritions
        tableView.reloadData()
    }

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }

    func setupKeyboard() {
        self.gramTextField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func setupGestureRecognizer() {
        self.tapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(self.gestureRecognizerAction))
        self.tapGestureRecognizer.delegate = self
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        foodDetail.nutritions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! DetailTableViewCell
        cell.setupCell(nutrition: foodDetail.nutritions[indexPath.row])

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
