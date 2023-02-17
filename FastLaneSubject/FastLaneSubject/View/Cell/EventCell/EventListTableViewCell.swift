//
//  EventListTableViewCell.swift
//  FastLaneSubject
//
//  Created by RooZin on 2023/02/16.
//

import UIKit
import RxSwift
import RxCocoa

class EventListTableViewCell: UITableViewCell {
    
    static let identifier = "EventListTableViewCell"

    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        registerXib()
        setTableView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension EventListTableViewCell : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventTableViewCell.identifier) as? EventTableViewCell else { return UITableViewCell() }

        
        return cell
    }
    
    private func registerXib() {
        let eventNib = UINib(nibName: EventTableViewCell.identifier, bundle: nil)
        
        tableView.register(eventNib, forCellReuseIdentifier: EventTableViewCell.identifier)
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorInset.left = 0
        tableView.separatorInset.right = 0
    }
    
}
