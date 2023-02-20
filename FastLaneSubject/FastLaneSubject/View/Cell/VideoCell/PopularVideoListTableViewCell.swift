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
    
    private func setBindings() {
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

//MARK: - UICollectionViewDelegateFlowLayout
extension PopularVideoListTableViewCell : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2.5
        let height = 128.0
        
        return CGSize(width: width, height: height)
    }
}
