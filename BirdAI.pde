class BirdAI extends Bird{
	NeuralNetwork brain;
	double[] vision={0,0,0,0};
	// horizontal distance, birdy, topy, bottomy,
	BirdAI(int x,int y){
		super(x,y);
		brain = new NeuralNetwork(4, 4, 1);
		brain.setLearningRate(0.01);
	}
	void look(){
		int d=sticks.get(0).x-x;
		Stick s;
		if(d>0) s=new Stick(sticks.get(0)); else s=new Stick(sticks.get(1));
		vision[0]=(float)(s.x-x)/(float)width;
		vision[1]=(float)(y)/(float)height;
		vision[2]=(float)(y-s.yspace)/(float)height;
		vision[3]=(float)(y-(s.space+s.yspace))/(float)height;
	}
	double think(){
		look();
		double[] output=brain.guess(vision);
		if(output[0]>0.5) this.flap();
		return output[0];
	}
}
