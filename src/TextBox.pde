class Textbox extends Observable {

    private String text;
    private PVector pos;
    private float w;
    private boolean active;


    public Textbox(float x, float y, float w) {
        this.text = "";
        this.pos = new PVector(x, y);
        this.w = w;
    }


    public void draw() {
        if (active)
            fill(255);
        else
            fill(255, 255, 255, 198);
        textSize(16);
        rect(pos.x, pos.y, w, 16);
        fill(0);
        if (active)
            text(this.text + '|', pos.x, pos.y + 14);
        else
            text(this.text, pos.x, pos.y + 14);
    }


    public void setText(String text) {
        this.text = text;
    }


    public String content() {
        return text;
    }


    public void submit() {
        setChanged();
        notifyObservers(this);
    }


    public void clear() {
        text = "";
    }


    public boolean pressed() {
        boolean boundsX = mouseX >= pos.x && mouseX <= pos.x + w;
        boolean boundsY = mouseY >= pos.y && mouseY <= pos.y + 16;
        return boundsX && boundsY;
    }


    public boolean isActive() {
        return active;
    }


    public void activate() {
        active = true;
    }


    public void deactivate() {
        active = false;
    }


    public void append(char c) {
        boolean cIsNumeric = c >= 48 && c <= 58;
        boolean cIsLowercase = c >= 97 && c <= 122;
        boolean cIsUppercase = c >= 65 && c <= 90;
        if (cIsNumeric || cIsLowercase || cIsUppercase) {
            text += c;
        }
    }


    public void backspace() {
        if (text.length() != 0) {
            text = text.substring(0, text.length() - 1);
        }
    }
}
