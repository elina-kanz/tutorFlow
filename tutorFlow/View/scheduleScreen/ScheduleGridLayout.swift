import UIKit

class ScheduleGridLayout: UICollectionViewLayout {
    
    private var cache: [IndexPath: UICollectionViewLayoutAttributes] = [:]
    private var supplementaryCache: [String: [IndexPath: UICollectionViewLayoutAttributes]] = [:]
    private var contentSize: CGSize = .zero
    
    let rowHeight: CGFloat = 50
    var columnWidth: CGFloat = 0
    
    let dayRowHeight: CGFloat = 50
    let timeColumnWidth: CGFloat = 50
    
    let numberOfDays = 7
    let numberOfHours = 24
    
    override func prepare() {
        super.prepare()
        
        cache.removeAll()
        supplementaryCache.removeAll()
        
        guard let collectionView = collectionView else { return }
        let availableWidth = collectionView.safeAreaLayoutGuide.layoutFrame.width - timeColumnWidth
        columnWidth = availableWidth / CGFloat(numberOfDays)
        contentSize = CGSize(
            width: timeColumnWidth + columnWidth * CGFloat(numberOfDays),
            height: dayRowHeight + rowHeight * CGFloat(numberOfHours)
        )
        
        var daysHeaderCache: [IndexPath: UICollectionViewLayoutAttributes] = [:]
        
        for item in 0..<numberOfDays {
            let indexPath = IndexPath(item: item, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: DayHeaderView.elementKind, with: indexPath)
            attributes.frame = CGRect(
                x: timeColumnWidth + CGFloat(item) * columnWidth,
                y: 0,
                width: columnWidth,
                height: dayRowHeight
            )
            attributes.zIndex = 1024
            daysHeaderCache[indexPath] = attributes
        }
        
        supplementaryCache[DayHeaderView.elementKind] = daysHeaderCache
        
        var hoursHeaderCache: [IndexPath: UICollectionViewLayoutAttributes] = [:]
        
        for section in 0..<numberOfHours {
            let indexPath = IndexPath(item: 0, section: section)
            let attributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: HourHeaderView.elementKind, with: indexPath)
            attributes.frame = CGRect(
                x: 0,
                y: dayRowHeight + CGFloat(section) * rowHeight,
                width: timeColumnWidth,
                height: rowHeight
            )
            hoursHeaderCache[indexPath] = attributes
        }
        
        supplementaryCache[HourHeaderView.elementKind] = hoursHeaderCache
        
        for section in 0..<numberOfHours {
            for item in 0..<numberOfDays {
                let indexPath = IndexPath(item: item, section: section)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = CGRect(
                    x: timeColumnWidth + CGFloat(item) * columnWidth,
                    y: dayRowHeight + CGFloat(section) * rowHeight,
                    width: columnWidth,
                    height: rowHeight
                )
                cache[indexPath] = attributes
            }
        }
    }
    
    override var collectionViewContentSize: CGSize {
        return contentSize
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        guard let collectionView = collectionView else { return nil }
        
        var attributes = [UICollectionViewLayoutAttributes]()
        
        let daysHeaderCache = supplementaryCache[DayHeaderView.elementKind]!
        for (_, attr) in daysHeaderCache {
            let copiedAttr = attr.copy() as! UICollectionViewLayoutAttributes
            copiedAttr.frame.origin.y = collectionView.contentOffset.y
            copiedAttr.zIndex = 1024
            if rect.intersects(copiedAttr.frame) {
                attributes.append(copiedAttr)
            }
        }
        
        let hoursHeaderCache = supplementaryCache[HourHeaderView.elementKind]!
        for (_, attr) in hoursHeaderCache where rect.intersects(attr.frame) {
            attributes.append(attr)
        }
        
        for (_, attr) in cache where rect.intersects(attr.frame) {
            attributes.append(attr)
        }
        
        return attributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath]
    }
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return supplementaryCache[elementKind]?[indexPath]
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

}
