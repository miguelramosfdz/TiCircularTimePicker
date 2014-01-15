TiCircularTimePicker
===========================================


It's a circular time picker using an old fashioned scroll wheel.
It is a Titanium Module based on the KPTimePicker by Kasper Pihl Tornøe from https://github.com/kasperpihl/KPTimePicker.

**iOS only** at the moment,

<img src="images/demo.gif" />

### Usage

	var TiCircularTimePicker = require('co.coolelephant.titimepicker');

	var pickerView  = TiCircularTimePicker.createView({
		width: 250,
		height: 250,
		increment: 2, //Minute steps in which to increment when you scroll
		minimumValue: <MINIMUM DATE>, //Time in seconds since 1 Jan 1970
		maximumValue: <MAXIMUM DATE>,
		currentDate: <START DATE>
	});
	pickerView.addEventListener('change',function(e)
	{
		Ti.API.info( "Value is: ", e.value );
	});
	win.add( pickerView );
	

Please see the example included with this module. Please note that you should place a scroll wheel image behind this view and a select button in front as per the example.

## Options


#### increment

Type: `Integer`  
Default: `5`

The amount to increment/decrement as you scroll.


#### minimumValue

Type: `Integer`  
Default: None (required)

The earliest date the scroll wheel will scroll back to

#### maximumValue

Type: `Integer`  
Default: None (required)

The latest date the scroll wheel will scroll to

#### currentDate

Type: `Integer`  
Default: Current Date/Time

The starting date to use when the scroll is initiated - note if you read the property it returns a date string the same as the `change` event


## Events

### change
Fired every time the selection changes.

##### value
Type: `String`   
A date string of the currently selected value

## Changelog

* v1.0  
  * initial version

##ABOUT THE AUTHOR
Cool Elephant is a front to back end system integration company with a special focus on mobile application design, development and integration. Titanium Appcelerator is one of our specialities! (amongst other things)

web: [Cool Elephant](http://coolelephant.co.uk)  
twitter: [@coolelephant](https://twitter.com/coolelephant)  
email: trunk@coolelephant.co.uk

Or you can email

## License

    Copyright (c) 2010-2014 Cool Elephant Ltd

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
    THE SOFTWARE.
