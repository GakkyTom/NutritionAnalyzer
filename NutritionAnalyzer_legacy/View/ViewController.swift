//
//  ViewController.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/04/05.
//

import UIKit
import Charts

class ViewController: UIViewController {

    @IBOutlet weak var radarChartView: RadarChartView!

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var foodTextField: UITextField!
    let model = NutritionModel()
    var data: [Nutrition] = []
    let labels = ["P", "F", "C"]

    var addData: [Nutrition] = []
    let cellIdentifier = "NutritionTableViewCell"

    @IBAction func onTapRefreshButton(_ sender: Any) {
        setupPieChartView()
    }
    @IBAction func onTapSearchButton(_ sender: Any) {
        if let foodName = self.foodTextField.text {
            data = model.getFoodBy(foodName)
            tableView.reloadData()
        }
    }

    @IBAction func onTapAddButton(_ sender: Any) {
        model.create()
    }

    @IBAction func onTapMoveButton(_ sender: Any) {
        model.delete()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        model.initializeDB()

        setupTableView()
        refreshMasterData()

        if model.isExistsUserData() {
            setupPieChartView()
        }
    }

    func refreshMasterData() {
        self.data = model.dataSource
    }

    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }

    private func setupPieChartView() {
        let xAxis = radarChartView.xAxis
        xAxis.labelFont = .systemFont(ofSize: 11, weight: .semibold)
        xAxis.xOffset = 5
        xAxis.yOffset = 5
        xAxis.valueFormatter = self


        let protein = model.sumup("protein")
        let fat = model.sumup("fat")
        let carbohydrate = model.sumup("carbohydrate")
        
        let proteinDataSet = RadarChartDataEntry(value: protein, data: "protein")
        let fatDataSet = RadarChartDataEntry(value: fat, data: "fat")
        let carbohydrateDataSet = RadarChartDataEntry(value: carbohydrate, data: "carbon")

        var dataEntries: [RadarChartDataEntry] = []
        dataEntries.append(proteinDataSet)
        dataEntries.append(fatDataSet)
        dataEntries.append(carbohydrateDataSet)

        let chartDataSet = RadarChartDataSet(entries: dataEntries, label: "PFC")
        chartDataSet.setColor(UIColor(red: 103/255, green: 110/255, blue: 129/255, alpha: 1))
        chartDataSet.fillColor = UIColor(red: 103/255, green: 110/255, blue: 129/255, alpha: 1)
        chartDataSet.drawFilledEnabled = true
        chartDataSet.fillAlpha = 0.7
        chartDataSet.lineWidth = 2
        chartDataSet.drawHighlightCircleEnabled = true
        chartDataSet.setDrawHighlightIndicators(false)

        let data: RadarChartData = RadarChartData(dataSet: chartDataSet)

        self.radarChartView.data = data
        self.radarChartView.rotationEnabled = false
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NutritionTableViewCell", for: indexPath) as! NutritionTableViewCell
        cell.setupCell(nutrition: data[indexPath.row], actual: 5.5, planned: 8.0, percentage: 0.8)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = NutritionDetailViewController.getViewController(data: data[indexPath.row])
        self.present(vc, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return NutritionTableViewCell.cellHeight
    }
}

extension ViewController: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return labels[Int(value) % labels.count]
    }
}
