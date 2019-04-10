#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SliderTrackLayer : CALayer

@property (nonatomic) CGFloat trackHeight;
@property (nonatomic) CGFloat stepLineWidth;
@property (nonatomic) NSUInteger numberOfSteps;
@property (nonatomic) CGFloat stepLinesEdgePadding;
@property (nonatomic, strong) UIColor *trackColor;

- (CGSize)sizeThatFits:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
