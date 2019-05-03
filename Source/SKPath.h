#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

NS_ASSUME_NONNULL_BEGIN

@interface SKPath : NSObject
- (instancetype)initWithCGPath:(CGPathRef)path;
- (instancetype)init;

@property(nonatomic, readonly) CGRect boundingBox;
@property(nonatomic, readonly) CGRect boundingBoxOfPath;

- (void)addRect:(CGRect)rect;
- (void)moveTo:(CGPoint)point;
- (void)addLineTo:(CGPoint)point;
- (void)addQuadCurveWithControlPoint:(CGPoint)cp to:(CGPoint)destination;
- (void)addCurveWithControlPoint1:(CGPoint)cp1 andControlPoint2:(CGPoint)cp2 to:(CGPoint)destination;
- (void)closeSubpath;

- (CGPathRef)__toCGPathWith:(CGFloat)resolution;
- (void)simplify;
- (int)__fillRule;

- (SKPath*)copyStrokingWithWidth:(CGFloat)width lineCap:(CGLineCap)lineCap lineJoin:(CGLineJoin)lineJoin miterLimit:(CGFloat)miterLimit resolutionScale:(CGFloat)resolutionScale;

- (SKPath*)subtracted:(SKPath*)path;
- (SKPath*)unionedWith:(SKPath*)path;

- (void)subtract:(SKPath*)path;
- (void)unionWith:(SKPath*)path;

- (BOOL)intersects:(SKPath*)other;
@end

NS_ASSUME_NONNULL_END
