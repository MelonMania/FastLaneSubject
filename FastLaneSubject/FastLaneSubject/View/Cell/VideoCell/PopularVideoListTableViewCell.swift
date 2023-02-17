//
//  PopularVideoListTableViewCell.swift
//  FastLaneSubject
//
//  Created by RooZin on 2023/02/16.
//

import UIKit
import RxSwift
import RxCocoa

class PopularVideoListTableViewCell: UITableViewCell, UICollectionViewDelegate {
    
    static let identifier = "PopularVideoListTableViewCell"
    
    let viewModel = MainViewModel()
    var disposeBag = DisposeBag()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        registerXib()
        setCollectionView()
        setBindings()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    private func registerXib() {
        let videoNib = UINib(nibName: VideoCollectionViewCell.identifier, bundle: nil)
        collectionView.register(videoNib, forCellWithReuseIdentifier: VideoCollectionViewCell.identifier)
    }
    
    private func setCollectionView() {
        collectionView.delegate = self
    }
    
    private func setBindings() { // private 써도 되나
        Observable.just(())
            .bind(to: viewModel.fetchVideo)
            .disposed(by: disposeBag)
        
        viewModel.allVideos
            .bind(to: collectionView.rx.items(cellIdentifier: VideoCollectionViewCell.identifier, cellType: VideoCollectionViewCell.self)) {
                _, item, cell in
                
                cell.onData.onNext(item)
            }.disposed(by: disposeBag)
    }
    
    
}

////MARK: - UICollectionViewDelegate, UICollectionViewDataSource
//extension PopularVideoListTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return videoList.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionViewCell.identifier, for: indexPath) as? VideoCollectionViewCell else { return UICollectionViewCell() }
//
//        cell.videoTitleLabel.text = videoList[indexPath.row].videoTitle
//
//        return cell
//    }
//
//    private func registerXib() {
//        let videoNib = UINib(nibName: VideoCollectionViewCell.identifier, bundle: nil)
//        collectionView.register(videoNib, forCellWithReuseIdentifier: VideoCollectionViewCell.identifier)
//    }
//
//    private func setCollectionView() {
//        collectionView.delegate = self
//        collectionView.dataSource = self
//    }
//}
