class Menu {

    private ArrayList < Textbox > durationTextboxes;
    private ArrayList < Textbox > redTextboxes;
    private ArrayList < Textbox > greenTextboxes;
    private ArrayList < Textbox > blueTextboxes;
    private ArrayList < Button > alertButtons;
    private ArrayList < Button > deleteButtons;

    private Textbox active;

    private ObserverValue < Boolean > open;
    private Button menuButton;
    private Button pauseButton;
    private Button resetButton;
    private Button newTimerButton;

    public Menu() {
        durationTextboxes = new ArrayList < Textbox > ();
        redTextboxes = new ArrayList < Textbox > ();
        greenTextboxes = new ArrayList < Textbox > ();
        blueTextboxes = new ArrayList < Textbox > ();
        alertButtons = new ArrayList < Button > ();
        deleteButtons = new ArrayList < Button > ();

        active = null;

        open = new ObserverValue < Boolean > (false, Type.TOGGLE);
        menuButton = new Button("menu", new PVector(0, 0));
        menuButton.addObserver(open);

        pauseButton = new Button("start", new PVector(width / 2 + 25, height / 2 + 50));
        pauseButton.addObserver(timer.paused);

        resetButton = new Button("reset", new PVector(width / 2 - 64, height / 2 + 50));
        resetButton.addObserver(timer.reset);
    }


    public void draw() // todo draw everything
    {
        if (open.get()) {
            ArrayList < Textbox > allTextboxes = allTextboxes();
            for (int i = 0; i < allTextboxes.size(); i++) {
                allTextboxes.get(i).draw();
            }
            for (int i = 0; i < alertButtons.size(); i++) {
                alertButtons.get(i).draw();
            }
            for (int i = 0; i < deleteButtons.size(); i++) {
                deleteButtons.get(i).draw();
            }
            newTimerButton.draw();
        } else {
            pauseButton.draw();
            resetButton.draw();
        }
        menuButton.draw();
    }


    public void readMouseInput() // todo: add buttons
    {
        if (open.get()) {
            ArrayList < Textbox > allTextboxes = allTextboxes();
            for (Textbox textbox : allTextboxes) {
                if (textbox.pressed()) {
                    if (active != null) {
                        active.deactivate();
                    }
                    textbox.activate();
                    active = textbox;
                }
            }
            ArrayList < Button > allButtons = allButtons();
            for (Button button : allButtons) {
                button.readInput();
            }
            newTimerButton.readInput();
        } else {
            pauseButton.readInput();
            resetButton.readInput();
        }
        menuButton.readInput();
    }


    protected void deleteObservers() {
        ArrayList < Observable > allInputs = new ArrayList < Observable > ();
        allInputs.addAll(allTextboxes());
        allInputs.addAll(allButtons());
        for (Observable obs : allInputs) {
            obs.deleteObservers();
        }
        clearAll();
    }


    private void clearAll() {
        durationTextboxes.clear();
        redTextboxes.clear();
        greenTextboxes.clear();
        blueTextboxes.clear();
        alertButtons.clear();
        deleteButtons.clear();
    }


    public void addObservers(Timer timer) {
        textSize(16);

        for (int i = 0; i < timer.size(); i++) {
            Interval interval = timer.get(i);
            PVector pos = new PVector(width - textWidth("00:00:00"), i * 18);
            float durationWidth = textWidth("00:00:00");

            Textbox durationTextbox = new Textbox(pos.x, pos.y, durationWidth);
            durationTextbox.addObserver(interval.durationObserver());
            durationTextbox.setText(millisToString(interval.duration()));
            durationTextboxes.add(durationTextbox);

            float colorWidth = textWidth("255");

            pos.x -= colorWidth + 5;
            Textbox blueTextbox = new Textbox(pos.x, pos.y, colorWidth);
            blueTextbox.addObserver(interval.blueObserver());
            blueTextbox.setText(str(int(blue(interval.rgb()))));
            blueTextboxes.add(blueTextbox);

            pos.x -= colorWidth + 5;
            Textbox greenTextbox = new Textbox(pos.x, pos.y, colorWidth);
            greenTextbox.addObserver(interval.greenObserver());
            greenTextbox.setText(str(int(green(interval.rgb()))));
            greenTextboxes.add(greenTextbox);

            pos.x -= colorWidth + 5;
            Textbox redTextbox = new Textbox(pos.x, pos.y, colorWidth);
            redTextbox.addObserver(interval.redObserver());
            redTextbox.setText(str(int(red(interval.rgb()))));
            redTextboxes.add(redTextbox);

            pos.x -= textWidth('0') + 10;
            Button alertButton = new Button(interval.alert() ? "\u2713" : "\u2717", pos);
            alertButton.addObserver(interval.alertObserver());
            alertButtons.add(alertButton);

            pos.x -= textWidth('0') + 10;
            Button deleteButton = new Button("-", pos);
            ObserverValue < Integer > index = new ObserverValue < Integer > (i, Type.DELETER);
            deleteButton.addObserver(index);
            deleteButtons.add(deleteButton);
        }
        newTimerButton = new Button("+", new PVector(width - textWidth('+'), 18 * timer.size()));
        ObserverValue < Integer > i = new ObserverValue < Integer > (0, Type.ADD_NEW);
        newTimerButton.addObserver(i);
    }


    public boolean open() {
        return open.get();
    }


    public void readKey(char k) {
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


    private ArrayList < Textbox > allTextboxes() {
        ArrayList < Textbox > allTextboxes = new ArrayList < Textbox > ();
        allTextboxes.addAll(durationTextboxes);
        allTextboxes.addAll(redTextboxes);
        allTextboxes.addAll(greenTextboxes);
        allTextboxes.addAll(blueTextboxes);
        return allTextboxes;
    }


    private ArrayList < Button > allButtons() {
        ArrayList < Button > allButtons = new ArrayList < Button > ();
        allButtons.addAll(alertButtons);
        allButtons.addAll(deleteButtons);
        return allButtons;
    }
}
