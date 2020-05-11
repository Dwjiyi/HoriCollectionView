//
//  ViewController2.swift
//  Demo
//
//  Created by wy_d on 2020/5/12.
//  Copyright © 2020 wy. All rights reserved.
//

import UIKit

/**
 这套方案禁掉了collectionView的滑动，改为swipe手势手动滑动，
 不提倡，仅供参考
 */
class ViewController2: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        collectionView.isScrollEnabled = false
        
        otherButton.setTitle("返回", for: .normal)

        addGesture()
    }
    
    func addGesture() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeRight.direction = .right
        collectionView.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeLeft.direction = .left
        collectionView.addGestureRecognizer(swipeLeft)
    }
    
    override func onNextTap() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleSwipeGesture(_ swipeGesture: UISwipeGestureRecognizer) {
        
        let gesture = swipeGesture
                
        let point = gesture.location(in: collectionView)
        
        let width = itemSize.width + minimumInteritemSpacing
        
        // 计算当前滑动的cell索引
        var currentIndex = Int((point.x - layout.sectionInset.left) / width)
        
        // 将点转化成view上的点
        let pointOnView = collectionView.convert(point, to: view)
        
        // 计算该点在view上的x坐标
        let x = SCREEN_WIDTH.truncatingRemainder(dividingBy: pointOnView.x)
        
        if gesture.direction == .left {
            
            // 右划特殊考虑最后一个
            if currentIndex <= itemCount - 2, x < width {
                currentIndex = currentIndex + 1
            }
            
        } else if gesture.direction == .right {
            
            // 左划特殊考虑第一个和倒数第二个
            if currentIndex > 0 {
                
                if collectionView.contentOffset.x > width * CGFloat(itemCount - 2), currentIndex == itemCount - 2 {
                    
                    print("这是在最后一页左划倒数第二个item,index不变")
                    
                } else {
                    
                    if x <= layout.sectionInset.left {
                        
                        print("currentIndex 不变")
                        
                    } else if (x > layout.sectionInset.left && x < width + layout.sectionInset.left) || currentIndex == 1 {
                        
                        currentIndex = currentIndex - 1
                        
                    } else {
                        
                        currentIndex = currentIndex - 2
                    }
                }
            }
        }
        
        if currentIndex == itemCount - 1 { // 最后一个
            
            UIView.animate(withDuration: 0.3) {
                self.collectionView.setContentOffset(CGPoint(x: width * CGFloat(currentIndex) - (SCREEN_WIDTH - 15 - self.itemSize.width - self.layout.sectionInset.right) , y: 0), animated: true)
            }
        
        } else {
            
            UIView.animate(withDuration: 0.3) {
                self.collectionView.setContentOffset(CGPoint(x: width * CGFloat(currentIndex) , y: 0), animated: true)
            }
        }

    }
 
}

