class Bird{
	int x=0,y=0;
	int dir=1;
	PImage img;
	int score=0;
	int fitness=0;
	Bird(int x,int y){
		this.x=x;this.y=y;
		img = loadImage("bird.png");
	}
	void show(){
		fill(color(200,200,0));
		ellipse(x,y,img.width,img.height);
	}
	void show1(){
		//image(img,x,y);
		pushMatrix();
		translate(x,y);
		imageMode(CENTER);
		if(dir<0) rotate(radians(-15));
		else rotate(radians(25));
		image(img, 0,0);
		popMatrix();
	}
	void update(){
		int maxy=600-img.height/3,miny=img.height/2;
		if(y+dir<maxy) y+=dir;else y=maxy;
		if(y>maxy || y<miny){
			dir=0;
		}
		//if(frameCount%5==0) dir+=2;
		dir+=1;
	}
	void flap(){
		int miny=img.height/2;
		if(y>miny) dir=-5;
	}
}
