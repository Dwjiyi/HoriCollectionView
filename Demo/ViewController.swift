//
//  ViewController.swift
//  Demo
//
//  Created by wy_d on 2020/5/13.
//  Copyright © 2020 wy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let itemCount = 5
    let itemSize = CGSize(width: 280, height: 80)
    let minimumInteritemSpacing: CGFloat = 10
    let minimumLineSpacing: CGFloat = 10
    var lastOffset: CGPoint = CGPoint.zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(collectionView)
        
    }
    
    //MARK: - Lazy Load Properties
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 150, width: SCREEN_WIDTH , height: 120), collectionViewLayout: self.layout)
        collectionView.backgroundColor = UIColor.green
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        let scrollWidth = CGFloat(itemCount) * (itemSize.width + minimumInteritemSpacing) + layout.sectionInset.left + layout.sectionInset.right
        collectionView.contentSize = CGSize(width: scrollWidth, height: 120)
        collectionView.decelerationRate = .fast
        return collectionView
    }()
    
    lazy var layout: BannerFlowLayout = {
        let layout = BannerFlowLayout()
        layout.itemSize = itemSize
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        return layout
    }()
    
    lazy var clickMeBtn: UIButton = {
        let clickMeBtn = UIButton(frame: CGRect(x: 30, y: 300, width: SCREEN_WIDTH - 60, height: 30))
        clickMeBtn.backgroundColor = UIColor.red
        
        clickMeBtn.setTitle("点击我跳转另一个实现", for: .normal)
        clickMeBtn.setTitleColor(UIColor.white, for: .normal)
        return clickMeBtn
        
    }()
    
}
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.backgroundColor = UIColor.red
        return cell
    }
    
}

 
