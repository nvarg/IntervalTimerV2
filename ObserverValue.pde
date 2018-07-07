import java.util.Observer;
import java.util.Observable;

enum Type {
    COLOR_RED,
    COLOR_GREEN,
    COLOR_BLUE,
    TIMER_DURATION,
    DELETER,
    TOGGLE,
    TOGGLE_PAUSE,
    TOGGLE_ALERT,
    RESET,
    ADD_NEW
}


class ObserverValue < T > implements Observer {

    private T t;
    private Type TYPE;


    public ObserverValue(T t, Type TYPE) {
        set(t);
        this.TYPE = TYPE;
    }


    public T get() {
        return t;
    }


    public void set(T t) {
        this.t = t;
    }


    public void update(Observable o, Object arg) {
        switch (TYPE) {
            case COLOR_RED:
                if (t instanceof Integer && arg instanceof TextBox) {
                    TextBox input = (TextBox) arg;
                    int red = int(input.content());
                    if (red >= 0 && red <= 255) {
                        t = (T)(Object) red;
                    }
                    input.deactivate();
                }
                break;
            case COLOR_GREEN:
                if (t instanceof Integer && arg instanceof TextBox) {
                    TextBox input = (TextBox) arg;
                    int green = int(input.content());
                    if (green >= 0 && green <= 255) {
                        t = (T)(Object) green;
                    }
                    input.deactivate();
                }
                break;
            case COLOR_BLUE:
                if (t instanceof Integer && arg instanceof TextBox) {
                    TextBox input = (TextBox) arg;
                    int blue = int(input.content());
                    if (blue >= 0 && blue <= 255) {
                        t = (T)(Object) blue;
                    }
                    input.deactivate();
                }
                break;
            case TIMER_DURATION:
                if (t instanceof Integer && arg instanceof TextBox) {
                    TextBox input = (TextBox) arg;
                    if (match(input.content(), "\\d{2}:\\d{2}:\\d{2}") != null) {
                        int[] time = int(split(input.content(), ':'));
                        t = (T)(Object)(time[0] * 360000 + time[1] * 60000 + time[2] * 1000);
                    }
                    input.deactivate();
                }
                break;
            case DELETER:
                if (t instanceof Integer && arg instanceof Button) { //<>//
                    timer.remove((Integer) t);
                    timer.reset();
                    menu.active = null;
                    menu.deleteObservers();
                    menu.addObservers(timer);
                }
                break;
            case TOGGLE:
                if (t instanceof Boolean && arg instanceof Button) {
                    t = (T)(Object)((Boolean) t ? false : true);
                }
                break;
            case TOGGLE_ALERT: // todo: better way to do this
                if (t instanceof Boolean && arg instanceof Button) {
                    toggle_string((Button) arg, "\u2713", "\u2717");
                }
                break;
            case TOGGLE_PAUSE:
                if (t instanceof Boolean && arg instanceof Button) {
                    toggle_string((Button) arg, "start", "pause");
                }
                break;
            case RESET:
                timer.reset();
                break;
            case ADD_NEW:
                timer.add(0, color(255, 128, 128), false); //<>//
                timer.reset();
                menu.active = null;
                menu.deleteObservers();
                menu.addObservers(timer);
                break;
        }
    }


    private void toggle_string(Button btn, String tru, String fls) {
        boolean toggle = (Boolean) t ? false : true;
        t = (T)(Object) toggle;
        btn.set_text((Boolean) t ? tru : fls);
    }
}
