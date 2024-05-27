public class GildedRose {
    var items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    public func updateQuality() {
        items.forEach { item in
            switch item.type {
            case .agedBrie:
                handleIncreaseQuality(for: item)
            case .backstagePasses:
                guard !item.hasSellInPast else {
                    item.quality = item.minQuality
                    break
                }
                handleIncreaseQuality(for: item)
            case .sulfuras:
                // legendary item, doesn't have to be sold and quality remains (80)
                break
            case .normal, .conjured:
                handleDecreaseQuality(for: item)
            }
            
            updateSellIn(for: item)
        }
    }
    
    private func handleIncreaseQuality(for item: Item) {
        guard item.quality < item.maxQuality else { return }
        
        guard item.quality + item.qualityIncreaseValue <= item.maxQuality else {
            item.quality = item.maxQuality
            return
        }
        
        item.quality += item.qualityIncreaseValue
    }
    
    private func handleDecreaseQuality(for item: Item) {
        guard item.quality - item.qualityDegradingValue >= item.minQuality else {
            item.quality = item.minQuality
            return
        }
        
        item.quality -= item.qualityDegradingValue
    }
    
    private func updateSellIn(for item: Item) {
        // Sulfuras is a legendary item and doens't have to be sold
        if item.type != .sulfuras {
            item.sellIn -= 1
        }
    }
    
    // New feature removing of items
    
    public func removeAllItems() {
        items.removeAll()
    }
    
    public func removeItems(of type: ItemType) {
        items.removeAll { $0.type == type }
    }
    
    public func removeItemsWithPassedDateAndQuality0() {
        items.removeAll { $0.quality == $0.minQuality && $0.sellIn < 0 }
    }
}

public enum ItemType: String {
    case agedBrie = "Aged Brie"
    case backstagePasses = "Backstage passes to a TAFKAL80ETC concert"
    case sulfuras = "Sulfuras, Hand of Ragnaros"
    case conjured = "Conjured Mana Cake"
    case normal
}

extension Item {
    var type: ItemType {
        guard let type = ItemType(rawValue: self.name) else {
            return .normal
        }
        
        return type
    }
    
    var qualityDegradingValue: Int {
        switch type {
        case .sulfuras, .agedBrie, .backstagePasses:
            return 0
        case .normal:
            guard !hasSellInPast else {
                return defaultDegradingValue * 2
            }
            return defaultDegradingValue
        case .conjured:
            guard sellIn >= 0 else {
                return (defaultDegradingValue * 2) * 2
            }
            return defaultDegradingValue * 2
        }
    }
    
    var qualityIncreaseValue: Int {
        switch type {
        case .agedBrie:
            guard !hasSellInPast else {
                return 2
            }
            return 1
        case .backstagePasses:
            if (0...5).contains(sellIn) {
                return 3
            }
            
            if (6...10).contains(sellIn) {
                return 2
            }
            
            if sellIn >= 11 {
                return 1
            }
            return 0
        case .normal, .conjured, .sulfuras:
            return 0
        }
    }
    
    private var defaultDegradingValue: Int {
        return 1
    }
    
    var maxQuality: Int {
        switch type {
        case .normal, .agedBrie, .backstagePasses, .conjured:
            return 50
        case .sulfuras:
            return 80
        }
    }
    
    var minQuality: Int {
        if type != .sulfuras {
            return 0
        }
        return 80
    }
    
    var hasSellInPast: Bool {
        return sellIn <= 0
    }
}
