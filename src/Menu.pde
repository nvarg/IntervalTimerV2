class Menu {

    private ArrayList < TextBox > duration_inputs;
    private ArrayList < TextBox > red_inputs;
    private ArrayList < TextBox > green_inputs;
    private ArrayList < TextBox > blue_inputs;
    private ArrayList < Button > alert_toggles;
    private ArrayList < Button > delete_buttons;

    private TextBox active;

    private ObserverValue < Boolean > open;
    private Button menu_button;
    private Button pause_button;
    private Button reset_button;
    private Button new_timer_button;

    public Menu() {
        duration_inputs = new ArrayList < TextBox > ();
        red_inputs = new ArrayList < TextBox > ();
        green_inputs = new ArrayList < TextBox > ();
        blue_inputs = new ArrayList < TextBox > ();
        alert_toggles = new ArrayList < Button > ();
        delete_buttons = new ArrayList < Button > ();

        active = null;

        open = new ObserverValue < Boolean > (false, Type.TOGGLE);
        menu_button = new Button("menu", new PVector(0, 0));
        menu_button.addObserver(open);

        pause_button = new Button("start", new PVector(width / 2 + 25, height / 2 + 50));
        pause_button.addObserver(timer.paused);

        reset_button = new Button("reset", new PVector(width / 2 - 64, height / 2 + 50));
        reset_button.addObserver(timer.reset);
    }


    public void draw() // todo draw everything
    {
        if (open.get()) {
            ArrayList < TextBox > all_textboxes = all_textboxes();
            for (int i = 0; i < all_textboxes.size(); i++) {
                all_textboxes.get(i).draw();
            }
            for (int i = 0; i < alert_toggles.size(); i++) {
                alert_toggles.get(i).draw();
            }
            for (int i = 0; i < delete_buttons.size(); i++) {
                delete_buttons.get(i).draw();
            }
            new_timer_button.draw();
        } else {
            pause_button.draw();
            reset_button.draw();
        }
        menu_button.draw();
    }


    public void read_mouse_input() // todo: add buttons
    {
        if (open.get()) {
            ArrayList < TextBox > all_textboxes = all_textboxes();
            for (TextBox textbox : all_textboxes) {
                if (textbox.pressed()) {
                    if (active != null) {
                        active.deactivate();
                    }
                    textbox.activate();
                    active = textbox;
                }
            }
            ArrayList < Button > all_buttons = all_buttons();
            for (Button button : all_buttons) {
                button.read_input();
            }
            new_timer_button.read_input();
        } else {
            pause_button.read_input();
            reset_button.read_input();
        }
        menu_button.read_input();
    }


    protected void deleteObservers() {
        ArrayList < Observable > all_inputs = new ArrayList < Observable > ();
        all_inputs.addAll(all_textboxes());
        all_inputs.addAll(all_buttons());
        for (Observable obs : all_inputs) {
            obs.deleteObservers();
        }
        clear_all();
    }


    private void clear_all() {
        duration_inputs.clear();
        red_inputs.clear();
        green_inputs.clear();
        blue_inputs.clear();
        alert_toggles.clear();
        delete_buttons.clear();
    }


    public void addObservers(Timer timer) {
        textSize(16);

        for (int i = 0; i < timer.size(); i++) {
            Interval interval = timer.get(i);
            PVector pos = new PVector(width - textWidth("00:00:00"), i * 18);
            float duration_width = textWidth("00:00:00");

            TextBox duration_textbox = new TextBox(pos.x, pos.y, duration_width);
            duration_textbox.addObserver(interval.duration_observer());
            duration_textbox.set_text(millis_to_string(interval.duration()));
            duration_inputs.add(duration_textbox);

            float color_width = textWidth("255");

            pos.x -= color_width + 5;
            TextBox blue_textbox = new TextBox(pos.x, pos.y, color_width);
            blue_textbox.addObserver(interval.blue_observer());
            blue_textbox.set_text(str(int(blue(interval.rgb()))));
            blue_inputs.add(blue_textbox);

            pos.x -= color_width + 5;
            TextBox green_textbox = new TextBox(pos.x, pos.y, color_width);
            green_textbox.addObserver(interval.green_observer());
            green_textbox.set_text(str(int(green(interval.rgb()))));
            green_inputs.add(green_textbox);

            pos.x -= color_width + 5;
            TextBox red_textbox = new TextBox(pos.x, pos.y, color_width);
            red_textbox.addObserver(interval.red_observer());
            red_textbox.set_text(str(int(red(interval.rgb()))));
            red_inputs.add(red_textbox);

            pos.x -= textWidth('0') + 10;
            Button alert_button = new Button(interval.alert() ? "\u2713" : "\u2717", pos);
            alert_button.addObserver(interval.alert_observer());
            alert_toggles.add(alert_button);

            pos.x -= textWidth('0') + 10;
            Button delete_button = new Button("-", pos);
            ObserverValue < Integer > index = new ObserverValue < Integer > (i, Type.DELETER);
            delete_button.addObserver(index);
            delete_buttons.add(delete_button);
        }
        new_timer_button = new Button("+", new PVector(width - textWidth('+'), 18 * timer.size()));
        ObserverValue < Integer > i = new ObserverValue < Integer > (0, Type.ADD_NEW);
        new_timer_button.addObserver(i);
    }


    public boolean open() {
        return open.get();
    }


    public void read_key(char k) {
        if (active != null) {
            switch (k) {
                case RETURN:
                case ENTER:
                    active.submit();
                    active = null;
                    break;
                case BACKSPACE:
                    active.backspace();
                    break;
                default:
                    active.append(k);
                    break;
            }
        }
    }


    private ArrayList < TextBox > all_textboxes() {
        ArrayList < TextBox > all_textboxes = new ArrayList < TextBox > ();
        all_textboxes.addAll(duration_inputs);
        all_textboxes.addAll(red_inputs);
        all_textboxes.addAll(green_inputs);
        all_textboxes.addAll(blue_inputs);
        return all_textboxes;
    }


    private ArrayList < Button > all_buttons() {
        ArrayList < Button > all_buttons = new ArrayList < Button > ();
        all_buttons.addAll(alert_toggles);
        all_buttons.addAll(delete_buttons);
        return all_buttons;
    }
}
