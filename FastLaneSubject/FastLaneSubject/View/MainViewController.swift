//
//  MainViewController.swift
//  FastLaneSubject
//
//  Created by RooZin on 2023/02/16.
//

import UIKit
import SnapKit
import RxSwift
import RxViewController
import RxCocoa

class MainViewController: UIViewController {
    
    private let tableView : UITableView = { // 테이블뷰 생성
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    let viewModel: MainViewModelType
    var disposeBag = DisposeBag()
    
    var newEventCount : Int = 0
    var recommendEventCount : Int = 0
    
    init(viewModel: MainViewModelType = MainViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        viewModel = MainViewModel()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addSubView()
        autoLayout()
        
        setTableView()
        registerXib()
        setBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNavigationBar()
    }

    private func setBindings() {
        Observable.just(())
            .bind(to: viewModel.fetchNewEvent)
            .disposed(by: disposeBag)
        
        Observable.just(())
            .bind(to: viewModel.fetchRecommendEvent)
            .disposed(by: disposeBag)
        
        viewModel.allNewEvents
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] event in
                self?.newEventCount = event.count
                self?.tableView.reloadData()
            }).disposed(by: disposeBag)
        
        viewModel.allRecommendEvents
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] event in
                self?.recommendEventCount = event.count
                self?.tableView.reloadData()
            }).disposed(by: disposeBag)

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
    
    private func setNavigationBar() {
        let backBarButtonItem = UIBarButtonItem(title: "     이벤트", style: .plain, target: self, action: nil)
        
        self.navigationItem.backBarButtonItem = backBarButtonItem
        self.navigationController?.navigationBar.isHidden = true
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
            cell.delegate = self
            cell.isNewEvent = false
            
            return cell
        case 2 :
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EventListTableViewCell.identifier) as? EventListTableViewCell else { return UITableViewCell() }
            
            cell.eventTitleLabel.text = "신규이벤트"
            cell.eventTitleLabel.asColor(targetString: "이벤트", color: UIColor.systemPink)
            cell.delegate = self
            cell.isNewEvent = true
            
            return cell
        default :
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0 :
            return 204
        case 1 :
            return CGFloat(45 + (109 * recommendEventCount))
        case 2 :
            return CGFloat(45 + (109 * newEventCount))
        default:
            return 0
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
        
        tableView.estimatedRowHeight = 109
        tableView.rowHeight = UITableView.automaticDimension
    }
    
}

//MARK: - TransferDelegate
extension MainViewController : TransferDelegate {
    func didSelectEvent(event : ViewEvent) {
        let vc = DetailViewController()
        vc.event = event
        print(event)
        print("delegate 실행")
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
