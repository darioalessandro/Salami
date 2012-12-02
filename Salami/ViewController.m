/* ====================================================================
 * Copyright (c) 2012 Dario Alessandro Lencina Talarico.  All rights
 * reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in
 *    the documentation and/or other materials provided with the
 *    distribution.
 *
 * 3. The end-user documentation included with the redistribution,
 *    if any, must include the following acknowledgment:
 *    "This product includes software developed by
 *    Dario Alessandro Lencina Talarico: darioalessandrolencina@gmail.com"
 *
 *    Alternately, this acknowledgment SHOULD be included in the software itself,
 *    usually where such third-party acknowledgments normally appear,
 *
 *
 * 5. Products derived from this software may not be called "Designed by Dario",
 *    nor may "Designed by Dario" appear in their name, without prior written
 *    permission of the Author.
 *
 * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESSED OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED.  IN NO EVENT SHALL DARIO ALESSANDRO LENCINA TALARICO OR
 * ITS CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
 * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
 * OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 * ====================================================================
 *
 */

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
}

-(void)viewDidAppear:(BOOL)animated{
    [self refreshRect];
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    [self refreshRect];
}

-(void)configureView{
    [self addOverlayRect];
    [self addGestureRecognizersForViews];
}

-(void)addOverlayRect{
    self.rectOverlay=[CAShapeLayer layer];
    self.rectOverlay.fillColor=[UIColor colorWithRed:0.5 green:0.1 blue:0.1 alpha:0.6].CGColor;
    self.rectOverlay.lineWidth = 4.0f;
    self.rectOverlay.lineCap = kCALineCapRound;;
    self.rectOverlay.strokeColor = [[UIColor blackColor] CGColor];
    [self.view.layer addSublayer:self.rectOverlay];
    
    self.dottedLinesOverlay=[CAShapeLayer layer];
    self.dottedLinesOverlay.fillColor=[UIColor clearColor].CGColor;
    self.dottedLinesOverlay.lineWidth = 4.0f;
    self.dottedLinesOverlay.lineCap = kCALineCapRound;;
    self.dottedLinesOverlay.strokeColor = [[UIColor blackColor] CGColor];
    self.dottedLinesOverlay.lineDashPattern=@[@(5), @(5)];
    [self.view.layer addSublayer:self.dottedLinesOverlay];
}

-(void)addGestureRecognizersForViews{
    UIPanGestureRecognizer * pan=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panEventHandler:)];
    [self.view1 addGestureRecognizer:pan];
    pan=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panEventHandler:)];
    [self.view2 addGestureRecognizer:pan];
    pan=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panEventHandler:)];
    [self.view3 addGestureRecognizer:pan];
    pan=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panEventHandler:)];
    [self.view4 addGestureRecognizer:pan];
}

-(void)panEventHandler:(UIPanGestureRecognizer *)pan{
    [self translateView:pan.view becauseOfGestureRecognizer:pan];
    [self refreshRect];
}

-(void)translateView:(UIView *)view becauseOfGestureRecognizer:(UIPanGestureRecognizer *)pan{
    UIView * target= pan.view;
    CGPoint translation= [pan translationInView:self.view];
    target.center=CGPointMake(target.center.x+translation.x, target.center.y+translation.y);
    [pan setTranslation:CGPointZero inView:self.view];
}

-(void)refreshRect{
    UIBezierPath * rectPath=[UIBezierPath bezierPath];
    UIBezierPath * dottedLinesPath=[UIBezierPath bezierPath];
    //Rectangle coordinates
    CGPoint view1Center=[self.view1 center];
    CGPoint view2Center=[self.view2 center];
    CGPoint view3Center=[self.view3 center];
    CGPoint view4Center=[self.view4 center];
    
    //central horizontal line coordinates
    
    CGPoint view13MiddleCenter=CGPointMake(view1Center.x - (view1Center.x-view3Center.x)/2, view1Center.y-(view1Center.y-view3Center.y)/2);
    CGPoint view24MiddleCenter=CGPointMake(view2Center.x - (view2Center.x-view4Center.x)/2, view2Center.y-(view2Center.y-view4Center.y)/2);
    
    CGPoint view12MiddleCenter=CGPointMake(view1Center.x - (view1Center.x-view2Center.x)/2, view1Center.y-(view1Center.y-view2Center.y)/2);
    CGPoint view34MiddleCenter=CGPointMake(view3Center.x - (view3Center.x-view4Center.x)/2, view3Center.y-(view3Center.y-view4Center.y)/2);
    
    //central vertical line coordinates
    
    //Rectangle drawing
    [rectPath moveToPoint:view1Center];
    [rectPath addLineToPoint:view2Center];
    [rectPath addLineToPoint:view4Center];    
    [rectPath addLineToPoint:view3Center];
    [rectPath addLineToPoint:view1Center];
    
    //Central lines drawing
    [dottedLinesPath moveToPoint:view13MiddleCenter];
    [dottedLinesPath addLineToPoint:view24MiddleCenter];
    
    [dottedLinesPath moveToPoint:view12MiddleCenter];
    [dottedLinesPath addLineToPoint:view34MiddleCenter];
    
    self.rectOverlay.path=rectPath.CGPath;
    self.dottedLinesOverlay.path=dottedLinesPath.CGPath;
}

@end
