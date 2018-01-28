//
//  MemoListViewController.swift
//  voicy-ios
//
//  Created by Eliel A. Gordon on 1/5/18.
//  Copyright © 2018 Eliel Gordon. All rights reserved.
//

import UIKit

class MemoListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var dataSource = GenericCollectionViewDatasource<MemoItemViewModel>()
    let viewModel = MemoViewModel()
    var memos = [MemoItemViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionView()
    }
    
    func registerCollectionView() {
        collectionView.register(MemoListCell.self)
        viewModel.fetchMemos(callback: { [unowned self] (memos) in
            self.dataSource.items = memos
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
        
        dataSource.configureCell = { cv, indexPath in
            let cell = cv.dequeueReusableCell(forIndexPath: indexPath) as MemoListCell
            
            return cell
        }
        
        collectionView.dataSource = dataSource
        collectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            print("item: \(self.memos)")
        }
    }
    
    func goToDetailController(selectedMemo: MemoItemViewModel) {
        let memoDetailVC = MemoDisplayViewController(
            nibName: MemoDisplayViewController.storyboardIdentifier,
            bundle: Bundle.main
        )
        
        self.navigationController?.pushViewController(memoDetailVC, animated: true)
    }
}

extension MemoListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMemo = dataSource.items[indexPath.row]
        
        goToDetailController(selectedMemo: selectedMemo)
    }
}
