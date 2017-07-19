//
//  FeedViewController.swift
//  Marslink
//
//  Created by Makoto Ishihara on 2017-07-18.
//  Copyright © 2017 Ray Wenderlich. All rights reserved.
//

import UIKit
import IGListKit

class FeedViewController: UIViewController {
    
    let wxScanner = WxScanner()
    
    let pathfinder = Pathfinder()
    
    lazy var adapter: IGListAdapter = {
        return IGListAdapter(updater: IGListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    
    let collectionView: IGListCollectionView = {
        // 2
        let view = IGListCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        // 3
        view.backgroundColor = UIColor.black
        return view
    }()
    
    let loader = JournalEntryLoader()
    
    override func viewDidLoad() {
        loader.loadLatest()
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }

}

extension FeedViewController: IGListAdapterDataSource {
    // 1
    func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
        // 1
        var items: [IGListDiffable] = [wxScanner.currentWeather]
        items += loader.entries as [IGListDiffable]
        items += pathfinder.messages as [IGListDiffable]
        // 2
        return items.sorted(by: { (left: Any, right: Any) -> Bool in
            if let left = left as? DateSortable, let right = right as? DateSortable {
                return left.date > right.date
            }
            return false
        })
    }
    
    // 2
    func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        if object is Message {
            return MessageSectionController()
        } else if object is Weather {
            return WeatherSectionController()
        } else {
            return JournalSectionController()
        }
    }
    
    // 3
    func emptyView(for listAdapter: IGListAdapter) -> UIView? { return nil }
}
