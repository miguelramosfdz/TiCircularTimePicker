/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2014 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "CoCoolelephantTitimepickerView.h"

@implementation CoCoolelephantTitimepickerView

-(KPTimePickerCustom*) timePicker
{
    if( timePicker == nil )
    {
        //NSLog(@"INITIALIZING VIEW %@",[self frame]);
        timePicker = [[KPTimePickerCustom alloc] initWithFrame:[self frame]];
        
        //[self setMinimumValue_:[self.timePicker.pickingDate dateAtStartOfDay]];
        //[self setMaximumValue_:[[[self.timePicker.pickingDate dateByAddingMinutes:(60*24)] dateAtStartOfDay] dateBySubtractingMinutes:5]];
        
        [self addSubview:timePicker];
        [timePicker setDelegate:self];
        
        //[sliderView addTarget:self.proxy action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return timePicker;

}

-(void)frameSizeChanged:(CGRect)frame bounds:(CGRect)bounds
{
    //NSLog(@"[VIEW LIFECYCLE EVENT] frameSizeChanged: %@", timePicker);
    
    if (timePicker != nil) {
        
        // You must call the special method 'setView:positionRect' against
        // the TiUtils helper class. This method will correctly layout your
        // child view within the correct layout boundaries of the new bounds
        // of your view.
        [TiUtils setView:timePicker positionRect:bounds];
        
        KPTimePickerCustom *oldPicker = timePicker;
        [timePicker removeFromSuperview];
        timePicker = [[KPTimePickerCustom alloc] initWithFrame:bounds];
    
        [self addSubview:timePicker];
        [timePicker setDelegate:self];

    
        [timePicker setMinimumDate:oldPicker.minimumDate];
        [timePicker setMaximumDate:oldPicker.maximumDate];
        [timePicker setPickingDate:oldPicker.pickingDate];
        pickerDate = oldPicker.pickingDate;
        
        [timePicker setIncrement:oldPicker.increment];
    
    }
    
}

-(void)setMinimumValue_:(id)minimum
{
    minimumDate = [NSDate dateWithTimeIntervalSince1970:[TiUtils intValue:minimum]];
    [[self timePicker] setMinimumDate:minimumDate];
}

-(void)setMaximumValue_:(id)maximum
{
    maximumDate = [NSDate dateWithTimeIntervalSince1970:[TiUtils intValue:maximum]];
    [[self timePicker] setMaximumDate:maximumDate];
}


-(void)setCurrentDate_:(id)date
{
    //NSLog(@"setCurrentDate");
    pickerDate = [NSDate dateWithTimeIntervalSince1970:[TiUtils intValue:date]];
    [[self timePicker] setPickingDate:pickerDate];
}

-(id)currentDate
{
    return [self timePicker].pickingDate;
}

-(void)setIncrement_:(id)incrementValue
{
    increment = [TiUtils intValue:incrementValue];
    [[self timePicker] setIncrement:increment];
}


-(void)panRecognized:(UIPanGestureRecognizer*)sender{
    if(!self.timePicker) return;
    [self.timePicker forwardGesture:sender];
}

//When the scroll wheel is used
-(void)timePicker:(KPTimePickerCustom *)timePicker updateDate:(NSDate *)date;
{
    if(date){
        //NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //[dateFormatter setLocale:[NSLocale currentLocale]];
        //[dateFormatter setDateStyle:NSDateFormatterNoStyle];
        //[dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        //NSLog(@"updateDate: %@",[[dateFormatter stringFromDate:date] lowercaseString]);
        
        pickerDate = date;
        
        if ([self.proxy _hasListeners:@"change"])
        {
            // fire event
            [self.proxy fireEvent:@"change" withObject:@{
                                                         @"value":date
                                                         }];
        }
        
    }
}

@end
