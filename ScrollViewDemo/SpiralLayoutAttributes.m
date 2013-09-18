#import "SpiralLayoutAttributes.h"

@implementation SpiralLayoutAttributes

- (id)init
{
    self = [super init];
    if (self) {
        self.headerTextAlignment = NSTextAlignmentLeft;
        self.shadowOpacity = 0.5;
    }
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    SpiralLayoutAttributes *newAttributes = [super copyWithZone:zone];
    newAttributes.headerTextAlignment = self.headerTextAlignment;
    newAttributes.shadowOpacity = self.shadowOpacity;
    return newAttributes;
}

/*+ (instancetype)layoutAttributesForCellWithIndexPath:(NSIndexPath *)indexPath
 {
 ConferenceLayoutAttributes *attributes = [[ConferenceLayoutAttributes alloc] init];
 attributes->_representedElementCategory = UICollectionElementCategoryCell;
 return attributes;
 }
 
 + (instancetype)layoutAttributesForDecorationViewOfKind:(NSString *)decorationViewKind withIndexPath:(NSIndexPath*)indexPath
 {
 ConferenceLayoutAttributes *attributes = [[ConferenceLayoutAttributes alloc] init];
 return attributes;
 }
 
 + (instancetype)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind withIndexPath:(NSIndexPath *)indexPath
 {
 ConferenceLayoutAttributes *attributes = [[ConferenceLayoutAttributes alloc] init];
 return attributes;
 }*/

@end