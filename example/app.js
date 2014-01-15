// This is a test harness for your module
// You should do something interesting in this harness 
// to test out the module and to provide instructions 
// to users on how to use it by example.


// open a single window
var win = Ti.UI.createWindow({
	backgroundColor:'white'
});


var TiCircularTimePicker = require('co.coolelephant.titimepicker');
Ti.API.info("module is => " + TiCircularTimePicker);

//Label
var currentTime = Ti.UI.createLabel({
	width: Ti.UI.SIZE,
	height: Ti.UI.SIZE,
	top: 40,
	text: '',
	font: {
		fontSize: 28,
		fontWeight: 'bold'
	},
	textAlign: 'center',
	color: '#888',
	touchEnabled: false
});
win.add(currentTime);

//Scroll Wheel background image
var pvHolder = Ti.UI.createView({
	width: 250,
	height: 250,
	backgroundImage: 'picker_wheel.png'
});

//Use moment.js or something just as exciting
var startDate = new Date();
startDate.setHours(6);
startDate.setMinutes(0);
startDate.setSeconds(0);
startDate.setMilliseconds(0);

var endDate = new Date();
endDate.setHours(10);
endDate.setMinutes(0);
endDate.setSeconds(0);
endDate.setMilliseconds(0);

var initialDate = new Date();
initialDate.setHours(7);
initialDate.setMinutes(0);
initialDate.setSeconds(0);
initialDate.setMilliseconds(0);

Ti.API.info("startDate => " + startDate.toUTCString());
Ti.API.info("endDate => " + endDate.toUTCString());
var pickerView  = TiCircularTimePicker.createView({
	width: 250,
	height: 250,
	increment: 2,
	minimumValue: startDate.getTime()/1000, //Time in seconds since 1 Jan 1970
	maximumValue: endDate.getTime()/1000,
	currentDate: initialDate.getTime()/1000
});
pvHolder.add(pickerView);

pickerView.addEventListener('change', function(e){
	
	//Use moment to format the date properly in real life
	currentTime.text = new Date(e.value).toLocaleTimeString();
});
var selectView = Ti.UI.createView({
	width: 80,
	height: 80,
	borderRadius: 40,
	backgroundColor: 'green',
	opacity: 0.8
		
});
pvHolder.add(selectView);

var selectLabel = Ti.UI.createLabel({
	width: 70,
	height: 30,
	text: 'SELECT',
	font: {
		fontSize: 14,
		fontWeight: 'bold'
	},
	textAlign: 'center',
	color: '#fff',
	touchEnabled: false
});
selectView.add(selectLabel);

selectView.addEventListener('click', function(e){
	alert('You selected: ' + new Date(pickerView.currentDate).toLocaleTimeString());
	
});

win.add(pvHolder);

win.open();

