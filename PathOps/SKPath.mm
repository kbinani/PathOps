#import "SKPath.h"

#include "skia/include/pathops/SkPathOps.h"
#include "skia/include/core/SkPath.h"
#include "skia/include/core/SkRegion.h"

@implementation SKPath
{
    SkPath path;
}


- (instancetype)init
{
    self = [super init];
    return self;
}


- (instancetype)initWithCGPath:(CGPathRef)path
{
    self = [super init];
    if (!self) {
        return nil;
    }
    CGPathApplyWithBlock(path, ^(const CGPathElement * _Nonnull element) {
        CGPathElementType type = element->type;
        switch (type) {
            case kCGPathElementMoveToPoint: {
                [self moveTo: element->points[0]];
                break;
            }
            case kCGPathElementAddLineToPoint: {
                [self addLineTo: element->points[0]];
                break;
            }
            case kCGPathElementAddQuadCurveToPoint: {
                [self addQuadCurveWithControlPoint: element->points[0] to: element->points[1]];
                break;
            }
            case kCGPathElementAddCurveToPoint: {
                [self addCurveWithControlPoint1: element->points[0] andControlPoint2: element->points[1] to: element->points[2]];
                break;
            }
            case kCGPathElementCloseSubpath: {
                [self closeSubpath];
                break;
            }
        }
    });
    return self;
}


- (void)addRect:(CGRect)rect
{
    SkRect r;
    r.fLeft = CGRectGetMinX(rect);
    r.fTop = CGRectGetMinY(rect);
    r.fRight = CGRectGetMaxX(rect);
    r.fBottom = CGRectGetMaxY(rect);
    path.addRect(r);
}


- (void)moveTo:(CGPoint)point
{
    path.moveTo(point.x, point.y);
}


- (void)addLineTo:(CGPoint)point
{
    path.lineTo(point.x, point.y);
}


- (void)addQuadCurveWithControlPoint:(CGPoint)cp to:(CGPoint)destination
{
    path.quadTo(cp.x, cp.y, destination.x, destination.y);
}


- (void)addCurveWithControlPoint1:(CGPoint)cp1 andControlPoint2:(CGPoint)cp2 to:(CGPoint)destination
{
    path.cubicTo(cp1.x, cp1.y, cp2.x, cp2.y, destination.x, destination.y);
}


- (void)closeSubpath
{
    path.close();
}


- (CGPathRef)toCGPath
{
    CGMutablePathRef p = CGPathCreateMutable();
    SkPath::Iter iter(self->path, false);
    SkPoint pts[4];
    for (SkPath::Verb v = iter.next(pts); v != SkPath::Verb::kDone_Verb; v = iter.next(pts)) {
        switch (v) {
            case SkPath::Verb::kLine_Verb: {
                CGPathAddLineToPoint(p, nil, pts[0].x(), pts[0].y());
                break;
            }
            case SkPath::Verb::kMove_Verb: {
                CGPathMoveToPoint(p, nil, pts[0].x(), pts[0].y());
                break;
            }
            case SkPath::Verb::kQuad_Verb: {
                CGPathAddQuadCurveToPoint(p, nil, pts[0].x(), pts[0].y(), pts[1].x(), pts[1].y());
                break;
            }
            case SkPath::Verb::kCubic_Verb: {
                CGPathAddCurveToPoint(p, nil, pts[0].x(), pts[0].y(), pts[1].x(), pts[1].y(), pts[2].x(), pts[2].y());
                break;
            }
            case SkPath::Verb::kClose_Verb: {
                CGPathCloseSubpath(p);
                break;
            }
            case SkPath::Verb::kConic_Verb: {
                //TODO: conic support
                break;
            }
            case SkPath::kDone_Verb: {
                goto end;
            }
        }
    }
end:
    return p;
}


- (SKPath*)subtracted:(SKPath*)path
{
    SKPath *sk = [[SKPath alloc] init];
    Op(self->path, path->path, SkPathOp::kDifference_SkPathOp, &sk->path);
    return sk;
}


- (SKPath*)unionWith:(SKPath*)path
{
    SKPath *sk = [[SKPath alloc] init];
    Op(self->path, path->path, SkPathOp::kUnion_SkPathOp, &sk->path);
    return sk;
}

@end
