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
    [self refreshRect];
}

-(void)configureView{
    [self addOverlayRect];
    [self addGestureRecognizersForViews];
}

-(void)addOverlayRect{
    self.rectOverlay=[CAShapeLayer layer];
    self.rectOverlay.lineWidth=5;
    self.rectOverlay.fillColor=[UIColor colorWithRed:0.5 green:0.1 blue:0.1 alpha:0.6].CGColor;
    self.rectOverlay.borderColor=[UIColor blackColor].CGColor;
    [self.view.layer addSublayer:self.rectOverlay];
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
    UIBezierPath * bezierPath=[UIBezierPath bezierPath];
    CGPoint view1Center=[self.view1 center];
    CGPoint view2Center=[self.view2 center];
    CGPoint view3Center=[self.view3 center];
    CGPoint view4Center=[self.view4 center];
    
    [bezierPath moveToPoint:view1Center];
    [bezierPath addLineToPoint:view2Center];
    [bezierPath addLineToPoint:view4Center];    
    [bezierPath addLineToPoint:view3Center];

    self.rectOverlay.path=bezierPath.CGPath;
}

@end
