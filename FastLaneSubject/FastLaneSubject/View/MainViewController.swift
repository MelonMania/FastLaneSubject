//
//  MainViewController.swift
//  FastLaneSubject
//
//  Created by RooZin on 2023/02/16.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    private let tableView : UITableView = { // 테이블뷰 생성
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        //tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        addSubView()
        autoLayout()
        setTableView()
        registerXib()
    }
    
    
}

//MARK: - UI 그리기
extension MainViewController {
    
    private func addSubView() {
        view.addSubview(tableView)
    }
    
    private func autoLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension MainViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0 :
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PopularVideoTableViewCell.identifier) as? PopularVideoTableViewCell else { return UITableViewCell() }
           
            return cell
            
        default :
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0 :
            return 204
        default :
            return 0
        }
    }
    
    private func registerXib() {
        let popularVideoNib = UINib(nibName: PopularVideoTableViewCell.identifier, bundle: nil)
        let recommendEventNib = UINib(nibName: RecommendEventTableViewCell.identifier, bundle: nil)
        let newEventNib = UINib(nibName: NewEventTableViewCell.identifier, bundle: nil)
        
        tableView.register(popularVideoNib, forCellReuseIdentifier: PopularVideoTableViewCell.identifier)
        tableView.register(recommendEventNib, forCellReuseIdentifier: RecommendEventTableViewCell.identifier)
        tableView.register(newEventNib, forCellReuseIdentifier: NewEventTableViewCell.identifier)
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}
