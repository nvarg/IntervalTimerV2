class Timer {

    private int start_time;
    private int current_time;
    private int i;
    private ObserverValue < Boolean > paused;
    private ObserverValue < Boolean > reset;
    private ArrayList < Interval > intervals;


    public Timer() {
        start_time = millis();
        current_time = start_time;
        i = 0;
        paused = new ObserverValue < Boolean > (true, Type.TOGGLE_PAUSE);
        reset = new ObserverValue < Boolean > (true, Type.RESET);
        intervals = new ArrayList < Interval > ();
    }


    public void add(int duration, color rgb, Boolean alert) {
        intervals.add(new Interval(duration, rgb, alert));
    }


    public void add(int duration, color rgb) {
        add(duration, rgb, false);
    }


    public void remove(int index) {
        intervals.remove(index);
    }


    public int size() {
        return intervals.size();
    }


    public int time() {
        return current_time - start_time;
    }


    public void draw() {
        draw_arc();
        draw_counter();
    }


    private void draw_arc() {
        if (intervals.isEmpty()) {
            return;
        }

        Interval interval = get_current_interval();
        if (interval.duration() != 0) {
            float ratio = interval.duration() - time();
            ratio /= interval.duration();
            ratio = map(ratio, 0, 1.0, PI + HALF_PI, -HALF_PI);
            fill(interval.rgb());
            arc(width / 2, height / 2,
                width * 0.9, height * 0.9, -HALF_PI, ratio, PIE);
        }
    }


    private void draw_counter() {
        fill(255);
        textSize(52);
        text(string(), width / 2 - textWidth("00:00:00") / 2, height / 2 + textAscent() / 3);
    }


    public String string() {
        if (intervals.isEmpty()) {
            return millis_to_string(0);
        }
        int remaining = get_current_interval().duration() - time();
        return millis_to_string(remaining);
    }


    public void update() {
        if (intervals.isEmpty()) {
            return;
        }

        int new_time = millis();

        if (paused.get()) {
            start_time += new_time - current_time;
        }

        current_time = new_time;

        Interval interval = get_current_interval();
        if (time() >= interval.duration()) {
            if (interval.alert()) {
                play_alert();
            }
            start_time = new_time;
            i = (i + 1) % intervals.size();
        }
    }


    private Interval get_current_interval() {
        if (intervals.isEmpty()) {
            return null;
        }
        return intervals.get(i);
    }


    public Interval interval() {
        return get_current_interval();
    }


    private void play_alert() {
        if (alert_sound != null) {
            alert_sound.rewind();
            alert_sound.play();
        }
    }


    public void reset() {
        i = 0;
        start_time = millis();
        current_time = start_time;
    }


    public Interval get(int index) {
        return intervals.get(index);
    }
}


String millis_to_string(int ms) {
    String s = String.format("%02d:%02d:%02d", ms / 3600000 % 24, ms / 60000 % 60, ms / 1000 % 60);
    return s;
}
