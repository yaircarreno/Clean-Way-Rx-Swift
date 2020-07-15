//
//  PaginatorViewController.swift
//  CleanWayRx
//
//  Created by Yair Carreno on 10/07/20.
//  Copyright © 2020 Yair Carreno. All rights reserved.
//

import UIKit
import RxSwift

class PaginatorViewController: UIViewController {

    private let disposeBag = DisposeBag()
    private var paginator: Paginator?

    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindPaginator()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    private func bindPaginator() {

        paginator = Paginator.instance

        paginator?.getResults(query: "Query 1")
            .map { result in "Updating the list with => \(result)" }
            .subscribe(onNext:  { result in
                self.showResults(result)
            })
            .disposed(by: disposeBag)

        paginator?.getResults(query: "Query 2")
            .map { result in "Hiding the loader after getting => \(result)" }
            .subscribe(onNext:  { result in
                self.showResults(result)
            })
            .disposed(by: disposeBag)

        paginator?.getResults(query: "Query 3")
            .map { result in "Doing any other update with => \(result)" }
            .subscribe(onNext:  { result in
                self.showResults(result)
            })
            .disposed(by: disposeBag)
    }

    @IBAction func loadInitialPage(_ sender: Any) {
        self.queryData(page: 1)
    }
    
    @IBAction func getNewPageByScrolling(_ sender: Any) {
        self.queryData(page: 5)
    }
    
    @IBAction func getNewPageManually(_ sender: Any) {
        self.queryData(page: 21)
    }

    private func queryData(page: Int) {
        paginator?.pushPage(numberPage: page)
    }

    private func showResults(_ result: String) {
        print(result)
        resultLabel.text = result
    }
}
