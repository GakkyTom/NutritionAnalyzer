//
//  HomeViewController.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/04/20.
//

import UIKit

protocol HomeView: AnyObject {
    func setupLabels(periodLabel: String)
    func setupDatePicker()
}

class HomeViewController: UIViewController {
    var presenter: HomePresentation!

    private let cellIdentifier = "DetailTableViewCell"
    private let FONT_NAME_HIRAGINOKAKU_BOLD = "HiraKakuProN-W6"
    private var datePickerGestureRecognizer = UITapGestureRecognizer()
    private let datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = UIDatePicker.Mode.date
        if #available(iOS 13.4, *) {
            dp.preferredDatePickerStyle = UIDatePickerStyle.wheels
        }
        dp.locale = .current
        return dp
    }()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var hiddenTextField: UITextField!

    @IBAction func onTapChangePeriod(_ sender: Any) {
        self.hiddenTextField.becomeFirstResponder()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }

    //
    // MARK: @objc
    //

    @objc func hideDatePicker(gesture : UITapGestureRecognizer) {
        self.view.gestureRecognizers?.removeAll()
        self.hiddenTextField.resignFirstResponder()
    }

    @objc func dateChange() {
        presenter.refreshView(periodStart: self.datePicker.date)

        self.view.removeGestureRecognizer(self.datePickerGestureRecognizer)

        self.hiddenTextField.endEditing(true)
    }

    @objc func cancelled() {
        self.view.removeGestureRecognizer(self.datePickerGestureRecognizer)

        self.hiddenTextField.endEditing(true)
    }

    //
    // MARK: private method
    //

    private func addDatePickerGestureRecognizer() {
        // ダイアログの外タップで、ダイアログ閉じる用GestureRecognizer
        self.datePickerGestureRecognizer = UITapGestureRecognizer.init(target: self,
                                                                       action: #selector(self.hideDatePicker(gesture:)))
        self.view.addGestureRecognizer(self.datePickerGestureRecognizer)
    }
}

extension HomeViewController: HomeView {
    // view側では、Presenterから必要な情報をもらってViewにセットするだけ
    func setupLabels(periodLabel: String) {
        self.title = "Home"
        self.periodLabel.text = periodLabel
    }

    func setupDatePicker() {
        // 隠しているTextFieldViewにフォーカスを当ててDatePickerを表示する
        self.hiddenTextField.inputView = datePicker

        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 40))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(title: "変更", style: .done, target: self, action: #selector(dateChange))
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelled))
        toolbar.setItems([cancelItem, spacelItem, doneItem], animated: true)

        self.hiddenTextField.inputAccessoryView = toolbar

        self.addDatePickerGestureRecognizer()
    }

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.getUserNutritions().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! HomeTableViewCell
        cell.setupCell(nutrition: presenter.getUserNutritionOf(indexPath.row))

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return DetailTableViewCell.cellHeight
    }
}
