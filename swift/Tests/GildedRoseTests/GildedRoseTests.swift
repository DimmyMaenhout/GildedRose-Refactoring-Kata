@testable import GildedRose
import XCTest

class GildedRoseTests: XCTestCase {
    // Fixed the test that was already here but commented it, would normally delete this as it has nothing todo with the code but just wanted to show that it's fixed
//    func testFoo() throws {
//        let items = [Item(name: "foo", sellIn: 0, quality: 0)]
//        let app = GildedRose(items: items)
//        app.updateQuality()
//        XCTAssertEqual(app.items[0].name, "foo")
//    }
    
    // general test
    // check if items is correctly initialised
    func test_shouldHaveTheCorrectStartingItems() {
        let items: [Item] = []
        let app = GildedRose(items: items)
        
        XCTAssertTrue(items.count == app.items.count)
    }
    
    // normal item
    
    // sellIn should be decreased with the correct value (-1)
    func test_updateQuality_item_shouldHaveCorrectSellinValue() {
        let items = [Item(name: "normal item", sellIn: 1, quality: 1)]
        let app = GildedRose(items: items)
        app.updateQuality()
        XCTAssertEqual(app.items[0].sellIn, 0)
    }
    
    func test_updateQuality_normalItem_shouldHaveCorrectQuality() {
        let items = [Item(name: "normal item", sellIn: 1, quality: 1)]
        let app = GildedRose(items: items)
        app.updateQuality()
        XCTAssertEqual(app.items[0].quality, 0)
    }
    
    func test_updateQuality_normalItem_withPassedSellDate_shouldHaveCorrectQuality() {
        let items = [Item(name: "normal item", sellIn: -1, quality: 2)]
        let app = GildedRose(items: items)
        app.updateQuality()
        XCTAssertEqual(app.items[0].quality, 0)
    }
    
    func test_updateQuality_normalItem_withPassedSellDate_andQualityZero_shouldHaveCorrectQuality() {
        let items = [Item(name: "normal item", sellIn: -1, quality: 0)]
        let app = GildedRose(items: items)
        app.updateQuality()
        XCTAssertEqual(app.items[0].quality, 0)
    }
    
    func test_normalItem_withPassedSellDate_qualityShouldDegradeTwiceAsFast() {
        let item = Item(name: "normal item", sellIn: 2, quality: 1)
        let passedItem = Item(name: "normal item", sellIn: -1, quality: 2)
        
        XCTAssertTrue(passedItem.qualityDegradingValue / 2 == item.qualityDegradingValue)
    }
    
    // Conjured
    
    func test_updateQuality_conjuredItem_shouldHaveCorrectSellDateAndQuality() {
        let items = [Item(name: "Conjured Mana Cake", sellIn: 0, quality: 2)]
        let app = GildedRose(items: items)
        app.updateQuality()
        XCTAssertEqual(app.items[0].quality, 0)
    }
    
    func test_updateQuality_conjuredItem_withPassedSellDate_andQualityZero_shouldHaveCorrectQuality() {
        let items = [Item(name: "Conjured Mana Cake", sellIn: -1, quality: 0)]
        let app = GildedRose(items: items)
        app.updateQuality()
        XCTAssertEqual(app.items[0].quality, 0)
    }
    
    func test_updateQuality_conjuredItem_withPassedSellDate_andQualityOne_shouldHaveCorrectQuality() {
        let items = [Item(name: "Conjured Mana Cake", sellIn: -1, quality: 1)]
        let app = GildedRose(items: items)
        app.updateQuality()
        XCTAssertEqual(app.items[0].quality, 0)
    }
   
    func test_conjuredItem_degradesTwiceAsFastAsNormalItem() {
        let normalItem = Item(name: "normalItem", sellIn: 1, quality: 1)
        let conjuredItem = Item(name: "Conjured Mana Cake", sellIn: 1, quality: 2)
        XCTAssertTrue(conjuredItem.qualityDegradingValue / 2 == normalItem.qualityDegradingValue)
    }
    
    func test_conjuredItem_degradesTwiceAsFastAsNormalItem_whenSellDatePassed() {
        let normalItem = Item(name: "normalItem", sellIn: -1, quality: 2)
        let conjuredItem = Item(name: "Conjured Mana Cake", sellIn: -1, quality: 4)
        XCTAssertTrue(conjuredItem.qualityDegradingValue / 2 == normalItem.qualityDegradingValue)
    }
    
    // Aged brie
    
    func test_updateQuality_agedBrieItem_withSellDateMoreThanTen_shouldHaveCorrectQuality() {
        let items = [Item(name: "Aged Brie", sellIn: 11, quality: 0)]
        let app = GildedRose(items: items)
        app.updateQuality()
        
        XCTAssertEqual(app.items[0].quality, 1)
    }
    
    func test_updateQuality_agedBrieItem_withQuality50_shouldHaveCorrectQuality() {
        let items = [Item(name: "Aged Brie", sellIn: 1, quality: 50)]
        let app = GildedRose(items: items)
        app.updateQuality()
        
        XCTAssertEqual(app.items[0].quality, 50)
    }
    
    // backstage passes
    
    func test_updateQuality_backstagePasses_shouldHaveCorrectQuality() {
        let items = [Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 15, quality: 20)]
        let app = GildedRose(items: items)
        app.updateQuality()
        
        XCTAssertEqual(app.items[0].quality, 21)
    }
    
    func test_updateQuality_backstagePasses_withSellDate10_shouldHaveCorrectQuality() {
        let items = [Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 10, quality: 20)]
        let app = GildedRose(items: items)
        app.updateQuality()
        
        XCTAssertEqual(app.items[0].quality, 22)
    }
    
    func test_updateQuality_backstagePasses_withSellDateBetweenZeroAndFive_shouldHaveCorrectQuality() {
        let items = [Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 5, quality: 20)]
        let app = GildedRose(items: items)
        app.updateQuality()
        
        XCTAssertEqual(app.items[0].quality, 23)
    }
    
    func test_updateQuality_backstagePasses_withPassedSellDate_shouldHaveCorrectQuality() {
        let items = [Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: -1, quality: 20)]
        let app = GildedRose(items: items)
        app.updateQuality()
        
        XCTAssertEqual(app.items[0].quality, 0)
    }
    
    func test_updateQuality_backstagePasses_withSellDate3_andQuality50_shouldHaveCorrectQuality() {
        let items = [Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 3, quality: 50)]
        let app = GildedRose(items: items)
        app.updateQuality()
        
        XCTAssertEqual(app.items[0].quality, 50)
    }
    
    func test_updateQuality_backstagePasses_withSellDate3_andQuality49_shouldHaveCorrectdQuality() {
        let items = [Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 3, quality: 49)]
        let app = GildedRose(items: items)
        app.updateQuality()
        XCTAssertEqual(app.items[0].quality, 50)
    }
    
    // Sulfuras
    // values shouldn't change as this is a legendary item that doesn't have to be sold
    func test_updateQuality_sulfuras_shouldHaveCorrectSellInAndQuality() {
        let items = [Item(name: "Sulfuras, Hand of Ragnaros", sellIn: 1, quality: 80)]
        let app = GildedRose(items: items)
        app.updateQuality()
        
        XCTAssertEqual(app.items[0].sellIn, 1)
        XCTAssertEqual(app.items[0].quality, 80)
    }
    
    // tests for extra feature
    
    func test_removeAllItems_showsTheCorrectAmountOfItems() {
        let normalItem = Item(name: "normal item", sellIn: 1, quality: 1)
        let sulfuras = Item(name: "Sulfuras, Hand of Ragnaros", sellIn: 1, quality: 80)
        
        let app = GildedRose(items: [normalItem, sulfuras])
        app.removeAllItems()
        
        XCTAssertEqual(app.items.count, 0)
    }
    
    func test_removeItemsOfType_hasNoMoreItemsOfSpecifiedType() {
        let normalItem = Item(name: "normal item", sellIn: 1, quality: 1)
        let sulfuras = Item(name: "Sulfuras, Hand of Ragnaros", sellIn: 1, quality: 80)
        
        let app = GildedRose(items: [normalItem, sulfuras])
        app.removeItems(of: .normal)

        XCTAssertFalse(app.items.contains(where: { $0.type == .normal} ))
        XCTAssertEqual(app.items.count, 1)
    }
    
    func test_removeItemsWithPassedSellDateAndQualityZero_hasNoMoreItemsWithPassedSellDateAndQualityZero() {
        let normalItem = Item(name: "normal item", sellIn: -1, quality: 0)
        let sulfuras = Item(name: "Sulfuras, Hand of Ragnaros", sellIn: 1, quality: 80)
        let backStagePass = Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 3, quality: 49)
        
        let app = GildedRose(items: [normalItem, sulfuras, backStagePass])
        app.removeItems(of: .normal)

        XCTAssertFalse(app.items.contains(where: { $0.sellIn < 0  && $0.quality == 0} ))
        XCTAssertFalse(app.items.contains(where: { $0.type == .normal}))
        XCTAssertTrue(app.items.contains(where: { $0.type == .sulfuras }))
        XCTAssertTrue(app.items.contains(where: { $0.type == .backstagePasses }))
        XCTAssertEqual(app.items.count, 2)
    }
}
