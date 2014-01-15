//
//  KPTimePickerCustom.h
//
//  Customised version of KPTimePicker originally
//  Created by Kasper Pihl Tornøe on 01/08/13.
//  Copyright (c) 2013 Pihl IT. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KPTimePickerCustom;

@protocol KPTimePickerDelegate

@optional
/* Get's called every time the date changes - used for customizing the labels */
//-(NSString*)timePicker:(KPTimePicker*)timePicker titleForDate:(NSDate *)time;
//-(NSString*)timePicker:(KPTimePicker*)timePicker clockForDate:(NSDate *)time;
-(void)timePicker:(KPTimePickerCustom*)timePicker updateDate:(NSDate *)time;
@end


@interface KPTimePickerCustom : UIView


@property (nonatomic,unsafe_unretained) NSObject<KPTimePickerDelegate> *delegate;


@property (nonatomic,strong) NSDate *pickingDate;
@property (nonatomic,strong) NSDate *minimumDate;
@property (nonatomic,strong) NSDate *maximumDate;

@property (nonatomic) UIColor *lightColor;
@property (nonatomic) UIColor *darkColor;
@property (nonatomic) UIColor *confirmColor;

@property (nonatomic) BOOL hideIcons;

//Time increment (seconds)
@property (nonatomic) NSInteger increment;

-(void)forwardGesture:(UIPanGestureRecognizer*)sender;
@end
