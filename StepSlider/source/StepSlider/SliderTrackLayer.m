#import "SliderTrackLayer.h"

@implementation SliderTrackLayer

@synthesize trackHeight = _trackHeight;
@synthesize stepLineWidth = _stepLineWidth;
@synthesize numberOfSteps = _numberOfSteps;
@synthesize stepLinesEdgePadding = _stepLinesEdgePadding;
@synthesize trackColor = _trackColor;

#pragma mark - Initialization

- (instancetype) init {
    if (self = [super init]) {
        self.trackHeight = 5.0f;
        self.stepLineWidth = 3.0f;
        self.numberOfSteps = 0;
        self.stepLinesEdgePadding = 10.0f;
        self.trackColor = [UIColor colorWithWhite:0.41f alpha:1.f];
    }
    return self;
}

#pragma mark - Drawing content

- (void)drawInContext:(CGContextRef)context {
    
    // Create track path
    CGPoint trackOrigin = CGPointMake(0.0f, self.bounds.size.height - self.trackHeight);
    CGSize trackSize = CGSizeMake(self.bounds.size.width, self.trackHeight);
    CGRect trackRect = CGRectMake(trackOrigin.x, trackOrigin.y, trackSize.width, trackSize.height);
    CGFloat trackCornerRadius = CGRectGetMidY(trackRect);
    
    UIBezierPath *trackPath = [UIBezierPath bezierPathWithRoundedRect:trackRect cornerRadius:trackCornerRadius];
    
    // Append steps path
    CGPoint stepLineOrigin = CGPointMake(self.stepLinesEdgePadding, 0.0f);
    CGSize stepLineSize = CGSizeMake(self.stepLineWidth, self.bounds.size.height);
    CGRect stepLineRect = CGRectMake(stepLineOrigin.x, stepLineOrigin.y, stepLineSize.width, stepLineSize.height);
    CGFloat stepWidth = (trackSize.width - (self.stepLinesEdgePadding * 2)) / (self.numberOfSteps - 1);
    CGFloat stepLineCornerRadius = CGRectGetMidY(stepLineRect);
    
    for (NSInteger i = 0; i < self.numberOfSteps; i++) {
        CGRect rect = CGRectOffset(stepLineRect, stepWidth * i, 0.0f);
        UIBezierPath *stepLinePath = [UIBezierPath bezierPathWithRoundedRect:rect
                                                           byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight
                                                                 cornerRadii:CGSizeMake(stepLineCornerRadius, stepLineCornerRadius)];
        [trackPath appendPath:stepLinePath];
    }
    
    // Fill track
    CGContextAddPath(context, trackPath.CGPath);
    CGContextSetFillColorWithColor(context, self.trackColor.CGColor);
    CGContextFillPath(context);
}

#pragma mark - Access methods

- (void) setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    
    [self setNeedsDisplay];
}

- (void) setTrackHeight:(CGFloat)trackHeight {
    _trackHeight = trackHeight;
    
    [self setNeedsDisplay];
}

- (void) setStepLineWidth:(CGFloat)stepLineWidth {
    _stepLineWidth = stepLineWidth;
    
    [self setNeedsDisplay];
}

- (void) setNumberOfSteps:(NSUInteger)numberOfSteps {
    _numberOfSteps = numberOfSteps;
    
    [self setNeedsDisplay];
}

- (void) setTrackColor:(UIColor *)trackColor {
    _trackColor = trackColor;
    
    [self setNeedsDisplay];
}

- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake(size.width, self.trackHeight * 2.0f);
}

@end
