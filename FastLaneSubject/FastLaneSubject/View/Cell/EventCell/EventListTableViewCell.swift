//
//  EventListTableViewCell.swift
//  FastLaneSubject
//
//  Created by RooZin on 2023/02/16.
//

import UIKit
import RxSwift
import RxCocoa

protocol TransferDelegate : AnyObject {
    func didSelectEvent(event : ViewEvent)
}

class EventListTableViewCell: UITableViewCell, UITableViewDelegate {
    
    static let identifier = "EventListTableViewCell"
    
    var tableItem : [ViewEvent] = [ViewEvent(eventImageURL: "https://d10fvx8ndeqwvu.cloudfront.net/upfiles/product/4132860110.jpg?w=202&h=202&q=90", customerName: "강남병원", locationName: "강남 | 신사", displayName: "강남병원", eventName: "필러", comment: "이게 설명이다", price: 130000, wishCount: 55, reviewCount: 123, rate: 5.0), ViewEvent(eventImageURL: "https://d10fvx8ndeqwvu.cloudfront.net/upfiles/product/4132860110.jpg?w=202&h=202&q=90", customerName: "강남병원", locationName: "강남 | 신사", displayName: "강남병원", eventName: "필러", comment: "이게 설명이다", price: 130000, wishCount: 55, reviewCount: 123, rate: 5.0), ViewEvent(eventImageURL: "https://d10fvx8ndeqwvu.cloudfront.net/upfiles/product/4132860110.jpg?w=202&h=202&q=90", customerName: "강남병원", locationName: "강남 | 신사", displayName: "강남병원", eventName: "필러", comment: "이게 설명이다", price: 130000, wishCount: 55, reviewCount: 123, rate: 5.0), ViewEvent(eventImageURL: "https://d10fvx8ndeqwvu.cloudfront.net/upfiles/product/4132860110.jpg?w=202&h=202&q=90", customerName: "강남병원", locationName: "강남 | 신사", displayName: "강남병원", eventName: "필러", comment: "이게 설명이다", price: 130000, wishCount: 55, reviewCount: 123, rate: 5.0), ViewEvent(eventImageURL: "https://d10fvx8ndeqwvu.cloudfront.net/upfiles/product/4132860110.jpg?w=202&h=202&q=90", customerName: "강남병원", locationName: "강남 | 신사", displayName: "강남병원", eventName: "필러", comment: "이게 설명이다", price: 130000, wishCount: 55, reviewCount: 123, rate: 5.0)]
    
    lazy var tableItemRX = Observable.just(tableItem)
    
    var delegate : TransferDelegate?
    var isNewEvent : Bool = false // 신규이벤트 셀인지 아닌지 구분
    
    let viewModel = MainViewModel()
    var disposeBag = DisposeBag()
    
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        registerXib()
        setTableView()
        
        setBindings()
        setTableViewModelSelectedRx()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    private func registerXib() {
        let eventNib = UINib(nibName: EventTableViewCell.identifier, bundle: nil)
        
        tableView.register(eventNib, forCellReuseIdentifier: EventTableViewCell.identifier)
    }
    
    private func setTableView() {
        tableView.delegate = self
        
        tableView.separatorInset.left = 0
        tableView.separatorInset.right = 0
    }
    
    private func setBindings() {
//        if isNewEvent {
//            Observable.just(())
//                .bind(to: viewModel.fetchNewEvent)
//                .disposed(by: disposeBag)
//
//            viewModel.allNewEvents
//                .bind(to: tableView.rx.items(cellIdentifier: EventTableViewCell.identifier, cellType: EventTableViewCell.self)) {
//                    _, item, cell in
//
//                    cell.onData.onNext(item)
//                }.disposed(by: disposeBag)
//        } else {
//            Observable.just(())
//                .bind(to: viewModel.fetchRecommendEvent)
//                .disposed(by: disposeBag)
//
//            viewModel.allRecommendEvents
//                .bind(to: tableView.rx.items(cellIdentifier: EventTableViewCell.identifier, cellType: EventTableViewCell.self)) {
//                    _, item, cell in
//
//                    cell.onData.onNext(item)
//                    cell.selectionStyle = .none
//                }.disposed(by: disposeBag)
//        }
        tableItemRX.bind(to: tableView
                    .rx
            .items(cellIdentifier: EventTableViewCell.identifier, cellType: EventTableViewCell.self)) {
                        (tv, tableViewItem, cell) in
                
                cell.onData.onNext(tableViewItem)
                cell.selectionStyle = .none
                    }
                    .disposed(by: disposeBag)
    }
    
    private func setTableViewModelSelectedRx() {
            tableView
                .rx
                .modelSelected(ViewEvent.self)
                .subscribe(onNext: { event in
                    self.delegate?.didSelectEvent(event: event)
                    print("탭")
                })
                .disposed(by: disposeBag)
        }
}

