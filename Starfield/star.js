function Star(){

	this.x = random(-window.screen.width,window.screen.width);
	this.y = random(-window.screen.height,window.screen.height);
	this.z = random(window.screen.width);

	var radius = random(1,7);

	this.show = function(){

		noStroke();

		var dx = map(this.x / this.z, 0, 1, 0, width);
		var dy = map(this.y / this.z, 0, 1, 0, height);
		

		ellipse(dx,dy,radius,radius);

	}

	this.update = function(){

		this.z = this.z - speed;

		if(this.z < 1){
			this.z = window.screen.width;
			this.x = random(-window.screen.width,window.screen.width);
			this.y = random(-window.screen.height,window.screen.height);
		}

	
	}


}




 



