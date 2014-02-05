var		sketch,
		play = new Boolean();

$( window ).load(function() {
	
	$('#instructions').delay(2000).fadeOut(300, function() {
        playSketch();
    });
	
});

$( window ).scroll(function() {
	
	// EMPTY
	
});

$( document ).ready(function() {
	
	// EMPTY
	
});

$( window ).resize(function() {
	
	resizeSketch();

});

$( document ).keydown(function(e){
    if (e.keyCode == 32) {  // SPACE BAR
	
		play = !play;
		
		if(play == true) {
			playSketch();
			$('#instructions').fadeOut(300);
		} else {
			pauseSketch();
			$('#instructions').fadeIn(300);
		}
		
		return false;
		
    }
});

function setSketch() {
	sketch = Processing.getInstanceById('sketch');
}

function resizeSketch() {
	setSketch();
	sketch.size($( window ).width(),$( window ).height());
}

function playSketch() {
	setSketch();
	if(sketch) {
		sketch.loop();
	}
}

function pauseSketch() {
	setSketch();
	sketch.noLoop();
}