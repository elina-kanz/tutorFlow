import UIKit

class ScheduleGridLayout: UICollectionViewLayout {
    
    private var cache: [IndexPath: UICollectionViewLayoutAttributes] = [:]
    private var supplementaryCache: [String: [IndexPath: UICollectionViewLayoutAttributes]] = [:]
    private var contentSize: CGSize = .zero
    
    let rowHeight: CGFloat = 60
    let columnWidth: CGFloat = 50
    
    let timeColumnWidth: CGFloat = 50
    let dayRowHeight: CGFloat = 50
    
    let numberOfHours = 24
    let numberOfDays = 7
    
    override func prepare() {
        super.prepare()

        cache.removeAll()
        supplementaryCache.removeAll()
        
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
        
        var dayHeadersCache = [IndexPath: UICollectionViewLayoutAttributes]()
        for day in 0..<numberOfDays {
            let indexPath = IndexPath(item: day, section: 0)
            let attributes = UICollectionViewLayoutAttributes(
                forSupplementaryViewOfKind: DayHeaderView.elementKind,
                with: indexPath
            )
            
            attributes.frame = CGRect(
                x: timeColumnWidth + CGFloat(day) * columnWidth,
                y: 0,
                width: columnWidth,
                height: dayRowHeight
            )
            attributes.zIndex = 1024
            dayHeadersCache[indexPath] = attributes
        }
        supplementaryCache[DayHeaderView.elementKind] = dayHeadersCache
        
        var hourHeadersCache = [IndexPath: UICollectionViewLayoutAttributes]()
        for hour in 0..<numberOfHours {
            let indexPath = IndexPath(item: 0, section: hour)
            let attributes = UICollectionViewLayoutAttributes(
                forSupplementaryViewOfKind: HourHeaderView.elementKind,
                with: indexPath
            )
            
            attributes.frame = CGRect(
                x: 0,
                y: dayRowHeight + CGFloat(hour) * rowHeight,
                width: timeColumnWidth,
                height: rowHeight
            )
            hourHeadersCache[indexPath] = attributes
        }
        supplementaryCache[HourHeaderView.elementKind] = hourHeadersCache
    }
    
    override var collectionViewContentSize: CGSize {
        return contentSize
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributes = [UICollectionViewLayoutAttributes]()
        
        let dayHeaders = supplementaryCache[DayHeaderView.elementKind]!
        for (_, attr) in dayHeaders {
            var frame = attr.frame
            frame.origin.y = collectionView?.contentOffset.y ?? 0
            attr.frame = frame
            attributes.append(attr)
        }
            
        
        for (_, attr) in cache where rect.intersects(attr.frame) {
            attributes.append(attr)
        }
        
        let hourHeaders = supplementaryCache[HourHeaderView.elementKind]!
        for (_, attr) in hourHeaders where rect.intersects(attr.frame) {
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
