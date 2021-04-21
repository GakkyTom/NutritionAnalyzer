//
//  DetailPresenter.swift
//  NutritionAnalyzer_legacy
//
//  Created by 板垣智也 on 2021/04/20.
//

import Foundation

protocol DetailPresentation: AnyObject {

}

class DetailPresenter {
    private weak var view: DetailView?
    private let router: DetailWireframe

    init(view: DetailView,
         router: DetailWireframe) {
        self.view = view
        self.router = router
    }
}

extension DetailPresenter: DetailPresentation {

}
