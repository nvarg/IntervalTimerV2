import ddf.minim.*;

Timer timer;
Menu menu;
AudioPlayer alertSound;


void setup() {
    size(300, 300);
    frameRate(24);
    noStroke();

    timer = new Timer();
    menu = new Menu();
    menu.addObservers(timer);

    Minim minim = new Minim(this);
    alertSound = minim.loadFile("alert.mp3");

    textSize(16);
}


void draw() {
    background(52);
    timer.update();
    if (!menu.open()) {
        timer.draw();
    }
    menu.draw();
}


void mousePressed() {
    menu.readMouseInput();
}


void keyTyped() {
    menu.readKey(key);
}
