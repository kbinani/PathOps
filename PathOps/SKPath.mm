#import "SKPath.h"

#include "skia/include/pathops/SkPathOps.h"
#include "skia/include/core/SkPath.h"
#include "skia/include/core/SkRegion.h"
#include "skia/include/core/SkStrokeRec.h"
#include "skia/src/core/SkStroke.h"
#include "skia/src/core/SkGeometry.h"

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
                CGPathAddLineToPoint(p, nil, pts[1].x(), pts[1].y());
                break;
            }
            case SkPath::Verb::kMove_Verb: {
                CGPathMoveToPoint(p, nil, pts[0].x(), pts[0].y());
                break;
            }
            case SkPath::Verb::kQuad_Verb: {
                CGPathAddQuadCurveToPoint(p, nil, pts[1].x(), pts[1].y(), pts[2].x(), pts[2].y());
                break;
            }
            case SkPath::Verb::kCubic_Verb: {
                CGPathAddCurveToPoint(p, nil, pts[1].x(), pts[1].y(), pts[2].x(), pts[2].y(), pts[3].x(), pts[3].y());
                break;
            }
            case SkPath::Verb::kClose_Verb: {
                CGPathCloseSubpath(p);
                break;
            }
            case SkPath::Verb::kConic_Verb: {
                SkScalar weight = iter.conicWeight();
                SkPoint control = pts[1];
                SkPoint end = pts[2];
                if (weight == 1) {
                    CGPathAddQuadCurveToPoint(p, nil, control.x(), control.y(), end.x(), end.y());
                } else if (SkScalarIsFinite(weight)) {
                    SkScalar tolerance = 1e-10; //TODO: make this configurable
                    SkAutoConicToQuads converter;
                    SkPoint const* quads = converter.computeQuads(pts, weight, tolerance);
                    for (int i = 0; i < converter.countQuads(); ++i) {
                        SkPoint p0 = quads[i * 2];
                        SkPoint p1 = quads[i * 2 + 1];
                        CGPathAddQuadCurveToPoint(p, nil, p0.x(), p0.y(), p1.x(), p1.y());
                    }
                } else {
                    CGPathAddLineToPoint(p, nil, control.x(), control.y());
                    CGPathAddLineToPoint(p, nil, end.x(), end.y());
                }
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


- (void)simplify
{
    SkPath p;
    Simplify(self->path, &p);
    self->path.swap(p);
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


- (SKPath*)copyStrokingWithWidth:(CGFloat)width lineCap:(CGLineCap)lineCap lineJoin:(CGLineJoin)lineJoin miterLimit:(CGFloat)miterLimit resolutionScale:(CGFloat)resolutionScale
{
    SkStroke stroker;
    stroker.setWidth(width);
    SkPaint::Cap cap;
    switch (lineCap) {
        case CGLineCap::kCGLineCapButt:
            cap = SkPaint::Cap::kButt_Cap;
            break;
        case CGLineCap::kCGLineCapRound:
            cap = SkPaint::Cap::kRound_Cap;
            break;
        case CGLineCap::kCGLineCapSquare:
            cap = SkPaint::Cap::kSquare_Cap;
            break;
        default:
            cap = SkPaint::Cap::kDefault_Cap;
            break;
    }
    stroker.setCap(cap);
    SkPaint::Join join;
    switch (lineJoin) {
        case CGLineJoin::kCGLineJoinBevel:
            join = SkPaint::Join::kBevel_Join;
            break;
        case CGLineJoin::kCGLineJoinMiter:
            join = SkPaint::Join::kMiter_Join;
            break;
        case CGLineJoin::kCGLineJoinRound:
            join = SkPaint::Join::kRound_Join;
            break;
        default:
            join = SkPaint::Join::kDefault_Join;
            break;
    }
    stroker.setJoin(join);
    stroker.setResScale(resolutionScale);
    stroker.setDoFill(true);
    SKPath *p = [[SKPath alloc] init];
    stroker.strokePath(self->path, &p->path);
    return p;
}

@end
