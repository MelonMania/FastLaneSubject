//
//  MainViewController.swift
//  FastLaneSubject
//
//  Created by RooZin on 2023/02/16.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    
    private let tableView : UITableView = { // 테이블뷰 생성
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    let viewModel = MainViewModel()
    var disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        addSubView()
        autoLayout()
        setTableView()
        registerXib()
    }
    
    // MARK: - UI Binding

    func setupBindings() {
        viewModel.allVideos
        
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
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0 :
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PopularVideoListTableViewCell.identifier) as? PopularVideoListTableViewCell else { return UITableViewCell() }
           
            return cell
        case 1 :
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EventListTableViewCell.identifier) as? EventListTableViewCell else { return UITableViewCell() }
           
            cell.eventTitleLabel.text = "추천이벤트"
            cell.eventTitleLabel.asColor(targetString: "이벤트", color: UIColor.systemPink)
            
            return cell
        case 2 :
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EventListTableViewCell.identifier) as? EventListTableViewCell else { return UITableViewCell() }
           
            cell.eventTitleLabel.text = "신규이벤트"
            cell.eventTitleLabel.asColor(targetString: "이벤트", color: UIColor.systemPink)
            
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
            return 1000
        }
    }
    

    private func registerXib() {
        let popularVideoListNib = UINib(nibName: PopularVideoListTableViewCell.identifier, bundle: nil)
        let eventListNib = UINib(nibName: EventListTableViewCell.identifier, bundle: nil)
        
        tableView.register(popularVideoListNib, forCellReuseIdentifier: PopularVideoListTableViewCell.identifier)
        tableView.register(eventListNib, forCellReuseIdentifier: EventListTableViewCell.identifier)
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        
        tableView.separatorInset.left = 0
        tableView.separatorInset.right = 0
        
    }
    
}
