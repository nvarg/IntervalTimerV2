import ddf.minim.*;

Timer timer;
Menu menu;
AudioPlayer alert_sound;


void setup() {
    size(300, 300);
    frameRate(24);
    noStroke();

    timer = new Timer();
    timer.add(105000, color(133, 193, 233), true);
    timer.add(20000, color(255, 163, 157), false);

    menu = new Menu();
    menu.addObservers(timer);

    Minim minim = new Minim(this);
    alert_sound = minim.loadFile("alert.mp3");

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
    menu.read_mouse_input();
}


void keyTyped() {
    menu.read_key(key);
}
