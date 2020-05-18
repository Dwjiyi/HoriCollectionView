//
//  BannerFlowLayout.swift
//  Demo
//
//  Created by wy_d on 2020/5/17.
//  Copyright © 2020 wy. All rights reserved.
//

import UIKit

class BannerFlowLayout: UICollectionViewFlowLayout {
    
    var lastOffsetX: CGFloat = 0
    
    /// 返回停止滚动的点 ，如果希望自定义特定的点，重写该方法，手一离开就调用
    /// - Parameters:
    ///   - proposedContentOffset: 建议的点
    ///   - velocity: 滚动速度
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        guard let collectionView = collectionView else {
            return proposedContentOffset
        }
        
        let scrollWidthEach = itemSize.width + minimumLineSpacing
        
        let offsetMax = collectionView.contentSize.width - (scrollWidthEach + sectionInset.right + minimumLineSpacing)
        
        let offsetMin = CGFloat(0)
        print("velocity:\(velocity)  proposedContentOffset:\(proposedContentOffset.x) ")
        
        let currentX = collectionView.contentOffset.x
        let moveWidth = currentX - lastOffsetX
        let movePage = Int(moveWidth/(self.itemSize.width*0.5))
        var dragIndex = 0
        if velocity.x > 0 || movePage > 0 {
            dragIndex = 1
        } else if velocity.x < 0 || movePage < 0 {
            dragIndex = -1
        } else {
            dragIndex = 0
        }
        let index = Int((lastOffsetX + (itemSize.width + minimumInteritemSpacing) * 0.5) / (itemSize.width + minimumInteritemSpacing)) // 当前cell中心点的index
        var leftOffset = (SCREEN_WIDTH - itemSize.width - 2 * minimumInteritemSpacing) / 2
        
        if lastOffsetX <= offsetMin {
            lastOffsetX = lastOffsetX + CGFloat(dragIndex) * scrollWidthEach - leftOffset
        } else if lastOffsetX > offsetMax {
            lastOffsetX = lastOffsetX + CGFloat(dragIndex) * scrollWidthEach

        }

        

        let realProposedContentOffset = CGPoint(x: lastOffsetX, y: proposedContentOffset.y)
        return realProposedContentOffset

    }
    
    

    /*
     CGFloat offsetForCurrentPointX = ABS(proposedContentOffset.x - _lastOffset.x);//目标位移点距离当前点的距离绝对值
      CGFloat velocityX = velocity.x;
      BOOL direction = (proposedContentOffset.x - _lastOffset.x) > 0;//判断当前滑动方向,手指向左滑动：YES；手指向右滑动：NO
      
      if (offsetForCurrentPointX > pageSpace/8. && _lastOffset.x>=offsetMin && _lastOffset.x<=offsetMax)
      {
          NSInteger pageFactor = 0;//分页因子，用于计算滑过的cell个数
          if (velocityX != 0)
          {
              /*滑动*/
              pageFactor = ABS(velocityX);//速率越快，cell滑过数量越多
          }
          else
          {
              /**
               * 拖动
               * 没有速率，则计算：位移差/默认步距=分页因子
               */
              pageFactor = ABS(offsetForCurrentPointX/pageSpace);
          }

          /*设置pageFactor上限为2, 防止滑动速率过大，导致翻页过多*/
          pageFactor = pageFactor<1?1:(pageFactor<3?1:2);

          CGFloat pageOffsetX = pageSpace*pageFactor;
          proposedContentOffset = CGPointMake(_lastOffset.x + (direction?pageOffsetX:-pageOffsetX), proposedContentOffset.y);
      }
      else
      {
          /*滚动距离，小于翻页步距一半，则不进行翻页操作*/
          proposedContentOffset = CGPointMake(_lastOffset.x, _lastOffset.y);
      }

      //记录当前最新位置
      _lastOffset.x = proposedContentOffset.x;
      return proposedContentOffset;
     */
    
}
