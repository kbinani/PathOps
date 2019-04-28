#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface SKPath : NSObject
- (instancetype)initWithCGPath:(CGPathRef)path;
- (instancetype)init;
- (void)addRect:(CGRect)rect;
- (void)moveTo:(CGPoint)point;
- (void)addLineTo:(CGPoint)point;
- (void)addQuadCurveWithControlPoint:(CGPoint)cp to:(CGPoint)destination;
- (void)addCurveWithControlPoint1:(CGPoint)cp1 andControlPoint2:(CGPoint)cp2 to:(CGPoint)destination;
- (void)closeSubpath;

- (CGPathRef)toCGPath;

- (SKPath*)subtracted:(SKPath*)path;
- (SKPath*)unionWith:(SKPath*)path;
@end
