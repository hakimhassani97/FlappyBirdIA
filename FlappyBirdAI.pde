ArrayList<BirdAI> birds=new ArrayList<BirdAI>();
ArrayList<BirdAI> removed=new ArrayList<BirdAI>();
int species=250;
int frequency=1;
Stick s;
PImage bg;
int speed=5;
int startingy=300;
ArrayList<Stick> sticks=new ArrayList<Stick>();
int spos=400,spacing=400;
int genCount=0;
void setup(){
	frameRate(30);
	bg=loadImage("bg2.png");
	//background(bg);
	size(600, 600);
	nextGen();
	//stick (x,40==>560,50==>100)
	for(int i=0;i<8;i++){
		s=new Stick(spos,400,100);
		int m=(int)random(40,500),n=(int)random(min(abs(m-80),abs(m-400)),max(abs(m-80),abs(m-400)));
		sticks.add(new Stick(spos,m,150));
		spos+=spacing;
	}
}
void draw(){
	for(int i=0;i<frequency;i++){
		//background(bg);
		background(120);
		show();
		update();
	}
}
void keyPressed(){
	if(key=='s') saveBrain();
	else if(key=='+') frequency+=1;
	else if(key=='-' && frequency>1) frequency-=1;
	else
	for(int i=0;i<birds.size();i++)
		birds.get(i).flap();
}
void show(){
  showScore();
	showBirds();
	showSticks();
}
void update(){
	updateBirds();
	updateSticks();
}
//birds
void showBirds(){
	for(int i=0;i<birds.size();i++)
		birds.get(i).show();
}
void updateBirds(){
	if(birds.size()==0) nextGen();
	for(int i=0;i<birds.size();i++){
		birds.get(i).think();
		birds.get(i).update();
		if(frameCount==100){
			// for(int j=0;j<birds.size();j++)
			// 	println(birds.get(j).score);stop();
			//println(birds.get(i).vision[0]+" "+birds.get(i).vision[1]+" "+birds.get(i).vision[2]+" "+birds.get(i).vision[3]+" ");stop();
		}
	}
}
//sticks
void showSticks(){
	for(int i=0;i<sticks.size();i++){
		sticks.get(i).show();
	}
}
void updateSticks(){
	for(int i=0;i<sticks.size();i++){
		sticks.get(i).update(speed);
		for(int j=0;j<birds.size();j++)
			sticks.get(i).colide(birds.get(j));
	}
	if(sticks.get(0).x+sticks.get(0).w<0){
		s=sticks.remove(0);
		s.x=sticks.get(sticks.size()-1).x+spacing;
		int m=(int)random(40,500);
		sticks.add(new Stick(s.x,m,150));
		for(int j=0;j<birds.size();j++)
			birds.get(j).score++;
	}
}
//score
int max=0;
void showScore(){
  String s="";
  if(birds.size()>0) {s=""+birds.get(0).score;if(birds.get(0).score>max) max=birds.get(0).score;}
  fill(color(255));
  textSize(30);
  text(s,500,100);
  textSize(30);
  text("max : "+max,450,150);
}
//generationss
void nextGen(){
	birds=new ArrayList<BirdAI>();
	fitness();
	println("generation : "+(++genCount));
	for(int i=0;i<species;i++){
		//birds.add(new BirdAI(50,startingy));//startingy+=5;
		birds.add(select());
	}
	removed.clear();
}
void fitness(){
	int sfitness=0;
	for(int j=0;j<birds.size();j++)
			sfitness+=birds.get(j).score;
	for(int j=0;j<birds.size();j++)
		birds.get(j).fitness=birds.get(j).score/sfitness;
}
BirdAI select(){
	BirdAI b=new BirdAI(50,startingy);
	if(removed.size()>0){
		NeuralNetwork newbrain=removed.get(removed.size()-1).brain.copy();
		newbrain.mutate(0.1);
		b.brain=newbrain;
		removed.clear();
	}
	return b;
}
void saveBrain(){
	if(birds.size()>0) {
		println("brain saved to C:\\Program Files\\processing-3.5.3nn_data.json");
		FileReaderAndWriter.writeToFile(birds.get(0).brain);
		//birds.get(0).brain.writeToFile();
	}
}
