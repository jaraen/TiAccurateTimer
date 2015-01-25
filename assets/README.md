# Accurate Timer Module

	version 1.2, 2015, jan: open sourced
	version 1.0, 2012, jun

## Description

An accurate timer module for iOS with milliseconds precision, mostly written in pure C.

JavaScript's `setInterval()`  function has a low precision timer and, even worst, accumulates its time error on each iteration, which results in a total lost of synchronization on any timing operation in just a few seconds (think in a metronome or similar). 

AccurateTimer solves this and ensures that your callback function is called with the delay you expect, executed from a low level high priority function.

AccurateTimer has been developed with accuracy and performance in mind. The user callback function is executed with the minimum load to avoid undesired delays. However, keep in mind that once the Titanium callback function is executed, performance depends on Javascript runtime machine and therefore on the complexity of your function. Keep your callback function lightweight, loading previously into memory resources such as images and sounds you will manage from the callback function.

The module internally works with a unit slower than miliseconds (actually, at microseconds) so, even if your function introduces any delay on its execution, AccurateTimer should keep calling the interval callback with a precission of milliseconds.

## Accessing the timer Module

Include it in you tiapp.xml file

```
<module platform="iphone">com.accuratetimer</module>
```


To access this module from JavaScript, you would do the following:

```
	var timer = require("com.accuratetimer");
```


The timer variable is a reference to the Module object.	


## Reference


### accurateTimer.setInterval()

Configures the timer for interval operations. Receives a dictionary with two objects: callback and delay.

SetInterval does not start automatically the timer. Call start() method to run the timer.

```
	timer.setInterval({
		callback: yourCallbackFunction,
		delay: delayInMilliSeconds
	});
```

note that delay is an integer number of milliseconds between each interval.

### accurateTimer.setTimeout()

Configures the timer for a timeout operation, calling the callback function after the delay time. Receives a dictionary with two objects: callback and delay.

setTimeout starts automatically, so there's no need to call start()

```
	timer.setTimeout({
		callback: yourCallbackFunction,
		delay: delayInMilliSeconds
	});
```

note that delay is an integer number of milliseconds between each interval.


### accurateTimer.start()

starts the timer calling the callback function each delay milliseconds defined with setInterval()

### accurateTimer.stop()

stops the timer.

### accurateTimer.logTimeStamp()

Prints in console the current time system since 00:00:00 1 January 2001 in seconds with 6 decimals (microseconds precision) 

### accurateTimer.getTimeStamp()

Returns a double number with the current time system since 00:00:00 1 January 2001 in seconds with 6 decimals (microseconds precision) 


### accurateTimer.delay

Delay property in milliseconds.

## Usage

see example folder.

## Author

Javier Rayon, 2012-2015 (Criteria Studio)
Twitter: @jrayon


## License

Code released under Apache license 2.0 (formerly was under commercial license).

You can use it for commercial projects, open source projects, or really just about whatever you want.

Code is provided as it is, no support or maitainance is guaranteed.


