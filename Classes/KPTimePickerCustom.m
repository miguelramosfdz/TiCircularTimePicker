//
//  KPTimePicker.m
//
//  Customised version of KPTimePicker originally
//  Created by Kasper Pihl Tornøe on 01/08/13.
//  Copyright (c) 2013 Pihl IT. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "KPTimePickerCustom.h"
#import "Categories.h"
@class KPTimePickerCustom;


@interface KPTimePickerCustom () <UIGestureRecognizerDelegate>

@property (nonatomic,strong) UIImageView *timeSlider;

/* Private Properties*/

@property (nonatomic) CGPoint _centerPoint;
@property (nonatomic) CGPoint _lastPosition;
@property (nonatomic) CGFloat _lastChangedAngle;
@property (nonatomic) CGFloat _distanceForIcons;


@end
@implementation KPTimePickerCustom

-(void)setPickingDate:(NSDate *)pickingDate{
    
    if(_pickingDate != pickingDate){
        if(pickingDate) pickingDate = [pickingDate dateToNearestMinutes:self.increment];
        _pickingDate = pickingDate;
        [self updateForDate:pickingDate];
    }
}

#pragma mark Actions
-(void)forwardGesture:(UIPanGestureRecognizer *)sender{
    [self panGestureRecognized:sender];
}

#define distanceBetween(p1,p2) sqrt(pow((p2.x-p1.x),2) + pow((p2.y-p1.y),2))
- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender
{
    CGPoint velocity = [sender velocityInView:self];
    CGPoint location = [sender locationInView:self];
    CGFloat vel = fabsf(velocity.y)+fabsf(velocity.x);
    NSInteger minutesPerInterval = self.increment;
    CGFloat angleInterval = 50;
    //NSLog(@"%f",vel);
    if(vel > 1400){
        minutesPerInterval = 30;
        angleInterval = 40;
    }
    angleInterval = angleInterval*M_PI/180;
    CGFloat distanceToMiddle = distanceBetween(self._centerPoint, location);
    
    if (sender.state == UIGestureRecognizerStateChanged || sender.state == UIGestureRecognizerStateBegan) {
        CGPoint sliderStartPoint = self._lastPosition;
        if(CGPointEqualToPoint(self._lastPosition, CGPointZero)) sliderStartPoint = location;
        CGFloat angle = [self angleBetweenCenterPoint:self._centerPoint point1:sliderStartPoint point2:location];
        self._lastChangedAngle = self._lastChangedAngle + angle;
        self._lastPosition = location;
        NSInteger numberOfIntervals = round(self._lastChangedAngle/angleInterval);
        if(numberOfIntervals != 0){
            
            
            NSInteger timeAdded = minutesPerInterval*numberOfIntervals;
            NSDate *newTime = [self.pickingDate dateBySubtractingMinutes:timeAdded];
            self._lastChangedAngle = 0;
            
            if(self.minimumDate && [newTime isEarlierThanDate:self.minimumDate]) newTime = self.minimumDate;
            if(self.maximumDate && [newTime isLaterThanDate:self.maximumDate]) newTime = self.maximumDate;
            
            self.pickingDate = newTime;
        }
    }
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        self._lastPosition = CGPointZero;
        self._lastChangedAngle = 0;
    }
    
}
-(CGFloat)angleBetweenCenterPoint:(CGPoint)centerPoint point1:(CGPoint)p1 point2:(CGPoint)p2{
    CGPoint v1 = CGPointMake(p1.x - centerPoint.x, p1.y - centerPoint.y);
	CGPoint v2 = CGPointMake(p2.x - centerPoint.x, p2.y - centerPoint.y);
	
	CGFloat angle = atan2f(v2.x*v1.y - v1.x*v2.y, v1.x*v2.x + v1.y*v2.y);
	
	return angle;
}
- (CGPoint)pointFromPoint:(CGPoint)origin withDistance:(float)distance towardAngle:(float)angle
{
    double radAngle = angle * M_PI / 180.0;
    return CGPointMake(origin.x + distance * cos(radAngle), origin.y + distance * sin(radAngle));
}

-(void)updateForDate:(NSDate*)date{
    
   
    if([self.delegate respondsToSelector:@selector(timePicker:updateDate:)])
    {
      [self.delegate timePicker:self updateDate:date];
    }
   
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self._centerPoint = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/3*2);
        
        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)];
        panGestureRecognizer.delegate = self;
        [self addGestureRecognizer:panGestureRecognizer];
        
        
        [self layoutSubviews];
    }
    return self;
}
-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    if(!self.increment) self.increment = 5;//Default
    
    if(!self.pickingDate) self.pickingDate = [NSDate date];
    else [self updateForDate:self.pickingDate];
    
}
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}
-(void)dealloc{
    self.timeSlider = nil;
}

@end

