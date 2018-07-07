import java.util.Observer;

class Button extends Observable {

    private String text = "";
    private PVector pos = null;


    public Button(String text, PVector pos) {
        this.text = text;
        this.pos = new PVector(pos.x, pos.y);
    }


    public void set_text(String text) {
        this.text = text;
    }


    public void draw() {
        textSize(16);
        fill(255);
        text(text, pos.x, pos.y + textAscent() - 2);
    }


    public void read_input() {
        if (pressed()) {
            click();
        }
    }


    private void click() {
        setChanged();
        notifyObservers(this);
    }


    private boolean pressed() {
        boolean x_bounds = mouseX >= pos.x && mouseX <= pos.x + textWidth(text);
        boolean y_bounds = mouseY >= pos.y && mouseY <= pos.y + 16;
        return x_bounds && y_bounds;
    }
}
