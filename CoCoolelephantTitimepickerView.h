/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2014 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */
#import "TiUIView.h"
#import "KPTimePickerCustom.h"
#import "Categories.h"

@interface CoCoolelephantTitimepickerView : TiUIView <KPTimePickerDelegate, UIGestureRecognizerDelegate> {

    KPTimePickerCustom* timePicker;
    
    NSDate* pickerDate;
    NSDate* minimumDate;
    NSDate* maximumDate;
    
    NSInteger* increment;
}
-(NSDate*) currentDate;

@end
