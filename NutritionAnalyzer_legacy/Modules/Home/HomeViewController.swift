//
//  HomeViewController.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/04/20.
//

import UIKit

protocol HomeView: AnyObject { }

class HomeViewController: UIViewController {

    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    @IBOutlet weak var carbohydrateLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!

    var presenter: HomePresentation!
    private let refreshCtl = UIRefreshControl()
    // ① PageViewControllerクラス、
    // 　 PageViewで表示するViewControllerを格納する配列をそれぞれ定義
    private var pageViewController: UIPageViewController!
    private var controllers: [ UIViewController ] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Home"

//        refresh()

        self.initPageViewController()

        refreshCtl.addTarget(self, action: #selector(self.refresh(sender:)), for: .valueChanged)
//        scrollView.refreshControl = refreshCtl
    }
    private func initPageViewController() {

        // 背景色定義
        let backColor: [ UIColor ] = [ .systemIndigo, .systemOrange, .systemGreen ]

        // ② 表示するViewController作成 & 表示配列に保存
        for i in 0 ... 2 {
            let myViewController: UIViewController = UIViewController()
            myViewController.view.backgroundColor = backColor[i]
            myViewController.view.frame = self.view.frame
            self.controllers.append(myViewController)
        }
        // ③ UIPageViewController設定
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.pageViewController.setViewControllers([self.controllers[0]], direction: .forward, animated: true, completion: nil)
        self.pageViewController.dataSource = self

        // ④既存ViewControllerに追加
        self.addChild(self.pageViewController)
        self.view.addSubview(self.pageViewController.view!)
    }
    private func refresh() {
        let data = presenter.fetchUserData()
        data.forEach { (userPfc) in
            proteinLabel.text = "Protein: \(self.presenter.sumup("protein"))"
            fatLabel.text = "Fat: \(self.presenter.sumup("fat"))"
            carbohydrateLabel.text = "Carbohydrate: \(self.presenter.sumup("carbohydrate"))"
        }
    }

    @objc func refresh(sender: UIRefreshControl) {
        refresh()
        sender.endRefreshing()
    }
}

extension HomeViewController: HomeView {
    
}

// ⑤ PageViewControllerのDataSourceを定義
// MARK: - UIPageViewController DataSource
extension HomeViewController: UIPageViewControllerDataSource {

    /// ページ数
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.controllers.count
    }

    /// 左にスワイプ（進む）
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = self.controllers.firstIndex(of: viewController),
            index < self.controllers.count - 1 {
            return self.controllers[index + 1]
        } else {
            return nil
        }
    }

    /// 右にスワイプ （戻る）
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = self.controllers.firstIndex(of: viewController),
            index > 0 {
            return self.controllers[index - 1]
        } else {
            return nil
        }
    }

}
