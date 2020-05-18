//
//  ViewController3.swift
//  Demo
//
//  Created by wy_d on 2020/5/13.
//  Copyright © 2020 wy. All rights reserved.
//

import UIKit

class ViewController3: UIViewController {
    
    let itemCount = 20
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
    
    
}
extension ViewController3: UICollectionViewDelegate, UICollectionViewDataSource {
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

//extension ViewController3: UIScrollViewDelegate {
//    /// 即将开始拖拽
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        // 1. 标记拖动前的位置
//        dragStartX = scrollView.contentOffset.x
//    }
//
//    /// 即将结束拖拽
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        // 2. 标记拖动后手指离开的位置
//        let currentX = scrollView.contentOffset.x
//        // 3. 计算手指拖动的距离
//        let moveWidth = currentX - dragStartX
//        // 4. 以0.5个itemWidth为界限, 多则滑到下一个/上一个，少则回到原位
//        let movePage = Int(moveWidth / (itemSize.width * 0.5))
//        if velocity.x > 0 || movePage > 0 {
//            dragIndex = 1
//        } else if velocity.x < 0 || movePage < 0 {
//            dragIndex = -1
//        } else {
//            dragIndex = 0
//        }
//        // 5. 计算当前cell中心点的index
//        let index = Int((dragStartX + (itemSize.width + minimumInteritemSpacing) * 0.5) / (itemSize.width + minimumLineSpacing))
//        print("scrollViewWillEndDragging: \(index)")
//        // 最后一个cell继续往右滑， 不滑了
//        if (index == itemCount - 1 && dragIndex == 1) {
//            return
//        }
//
//        collectionView.scrollToItem(at: IndexPath(row: index + dragIndex, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
//
//    }
//
//    /// 滑动即将开始减速
//    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
//        let index = Int((dragStartX + (itemSize.width + minimumInteritemSpacing) * 0.5) / (itemSize.width + minimumLineSpacing))
//        print("scrollViewWillBeginDecelerating: \(index)")
//
//        if (index == itemCount - 1 && dragIndex == 1) {
//            return
//        }
//        collectionView.scrollToItem(at: IndexPath(row: index + dragIndex, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
//
//    }
//
//}


