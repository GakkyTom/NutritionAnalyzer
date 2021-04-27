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


    @objc func hideDatePicker(gesture : UITapGestureRecognizer) {
        self.view.gestureRecognizers?.removeAll()
        self.hiddenTextField.resignFirstResponder()
    }

    @objc func dateChange() {
        presenter.refreshView(periodStart: self.datePicker.date)

        // DatePicker初期化
        self.hiddenTextField.text = ""
        self.datePicker.date = Date()

        self.view.removeGestureRecognizer(self.datePickerGestureRecognizer)

        self.hiddenTextField.endEditing(true)
    }

    @objc func cancelled() {
        // DatePicker初期化
        self.hiddenTextField.text = ""
        self.datePicker.date = Date()

        self.view.removeGestureRecognizer(self.datePickerGestureRecognizer)

        self.hiddenTextField.endEditing(true)
    }

    private func addDatePickerGestureRecognizer() {
        // ダイアログの外タップで、ダイアログ閉じる用GestureRecognizer
        self.datePickerGestureRecognizer = UITapGestureRecognizer.init(target: self,
                                                                       action: #selector(self.hideDatePicker(gesture:)))
        self.view.addGestureRecognizer(self.datePickerGestureRecognizer)
    }
}

extension HomeViewController: HomeView {
    func setupLabels(periodLabel: String) {
        self.title = "Home"
        self.periodLabel.text = periodLabel
    }

    //
    // MARK: DatePicker設定
    //
    func setupDatePicker() {
        // 隠しているTextFieldViewにフォーカスを当ててDatePickerを表示する
        self.hiddenTextField.inputView = datePicker

        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 40))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(title: "変更", style: .done, target: self, action: #selector(dateChange))
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelled))
        toolbar.setItems([cancelItem, spacelItem, doneItem], animated: true)

        self.hiddenTextField.inputAccessoryView = toolbar
    }
}
