class Stick{
	int x=0;
	int space=80;
	int yspace=0;
	int w=40;
	PImage top,bottom,stick;
	Stick(int x,int yspace,int space){
		this.x=x;this.yspace=yspace;this.space=space;
		//top=loadImage("stickt.png");
		//bottom=loadImage("stickb.png");
		//stick=loadImage("stick.png");
	}
	Stick(Stick s){
		this.x=s.x;this.yspace=s.yspace;this.space=s.space;
		//this.top=loadImage("stickt.png");
		//this.bottom=loadImage("stickb.png");
		//this.stick=loadImage("stick.png");
	}
	void show(){
		fill(color(0,150,0));
		rect(x,0,w,yspace);
		rect(x,yspace+space,w,600);
	}
	void show1(){
		//rect(x,0,w,yspace);
		//rect(x,yspace+space,w,600);
		imageMode(CORNER);
		int height1=yspace-top.height;
		stick.resize(40,height1);
		image(stick,x,0);
		image(top,x,height1);
		int height2=yspace+space+bottom.height;
		image(bottom,x,height2-bottom.height);
		stick.resize(40,abs(600-height2));
		image(stick,x,height2);
	}
	void update(int speed){
		x-=speed;
	}
	void colide(BirdAI b){
		if(b.x>=x-b.img.width/3 && b.x<=x+w+b.img.width/3 && (b.y<=yspace+b.img.height/3 || b.y>=yspace+space-b.img.height/3)){
			//b.y=300;
			//b.dir=1;
			b.score=-1;
			removed.add(b);
			birds.remove(b);
		}
	}
}
