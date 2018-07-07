class TextBox extends Observable {

    private String text;
    private PVector pos;
    private float w;
    private boolean active;


    public TextBox(float x, float y, float w) {
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


    public void set_text(String text) {
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
        boolean x_bounds = mouseX >= pos.x && mouseX <= pos.x + w;
        boolean y_bounds = mouseY >= pos.y && mouseY <= pos.y + 16;
        return x_bounds && y_bounds;
    }


    public boolean is_active() {
        return active;
    }


    public void activate() {
        active = true;
    }


    public void deactivate() {
        active = false;
    }


    public void append(char c) {
        boolean c_is_numeric = c >= 48 && c <= 58;
        boolean c_is_lowercase = c >= 97 && c <= 122;
        boolean c_is_uppercase = c >= 65 && c <= 90;
        if (c_is_numeric || c_is_lowercase || c_is_uppercase) {
            text += c;
        }
    }


    public void backspace() {
        if (text.length() != 0) {
            text = text.substring(0, text.length() - 1);
        }
    }
}
