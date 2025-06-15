//
//  ScheduleGridLayout.swift
//  tutorFlow
//
//  Created by Elina Kanzafarova on 13.06.2025.
//

import UIKit

class ScheduleGridLayout: UICollectionViewLayout {
    
    private var cache: [IndexPath: UICollectionViewLayoutAttributes] = [:]
    private var contentSize: CGSize = .zero
    
    let rowHeight: CGFloat = 60
    let columnWidth: CGFloat = 80
    
    let timeColumnWidth: CGFloat = 60
    let dayRowHeight: CGFloat = 50
    
    let numberOfHours = 24
    let numberOfDays = 7
    
    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else { return }

        cache.removeAll()
        
        let width = timeColumnWidth + CGFloat(numberOfDays) * columnWidth
        let height = dayRowHeight + CGFloat(numberOfHours) * rowHeight
        contentSize = CGSize(width: width, height: height)
        
        for section in 0..<numberOfHours {
            for item in 0..<numberOfDays {
                let indexPath = IndexPath(item: item, section: section)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                
                let x = timeColumnWidth + CGFloat(item) * columnWidth
                let y = dayRowHeight + CGFloat(section) * rowHeight
                attributes.frame = CGRect(x: x, y: y, width: columnWidth, height: rowHeight)
                cache[indexPath] = attributes
            }
        }
    }
    
    override var collectionViewContentSize: CGSize {
        return contentSize
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cache.values.filter { $0.frame.intersects(rect) }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        cache[indexPath]
    }
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath]
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
