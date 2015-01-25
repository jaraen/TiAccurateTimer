

var timer = require('com.accuratetimer');


var win = Ti.UI.createWindow({
	backgroundColor:'white'
});


var flag = 0;

var label = Ti.UI.createLabel({text:''});

var btnPlay = Ti.UI.createButton({
    width:100, bottom:100, height:40,
    title:'press'
});
btnPlay.addEventListener('click', function(){
	timer.stop();
	timerDelay = 3000;
	
	label.text = "wait";
 	//timer.start();

	// timer.setTimeout({
		// callback : InitInterval,
		// delay : timerDelay
	// })

  timer.setInterval({
        callback:InitInterval, 
        delay:timerDelay    //set delay in ms
    });
    timer.start(); 
    
   // InitInterval();
});

win.add(btnPlay);
win.add(label);

win.open();



InitInterval = function(){
	timer.stop();

    timer.setInterval({
        callback:IntervalMain, 
        delay:1000    //set delay in ms
    });
    
    timer.start();     //setInterval requires to call explicitly start() method


}

IntervalMain = function(){
    //timer.stop();
	if (flag) {
		label.text = "+";
		flag = 0;
	} else {
		label.text = "-";
		flag = 1;
	}

    //timer.start();

}


label.text = "o";
timerDelay = 1000;


InitInterval();


