class Timer {

    private int startTime;
    private int currentTime;
    private int i;
    private ObserverValue < Boolean > paused;
    private ObserverValue < Boolean > reset;
    private ArrayList < Interval > intervals;


    public Timer() {
        startTime = millis();
        currentTime = startTime;
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
        return currentTime - startTime;
    }


    public void draw() {
        drawArc();
        drawCounter();
    }


    private void drawArc() {
        if (intervals.isEmpty()) {
            return;
        }

        Interval interval = getCurrentInterval();
        if (interval.duration() != 0) {
            float ratio = interval.duration() - time();
            ratio /= interval.duration();
            ratio = map(ratio, 0, 1.0, PI + HALF_PI, -HALF_PI);
            fill(interval.rgb());
            arc(width / 2, height / 2,
                width * 0.9, height * 0.9, -HALF_PI, ratio, PIE);
        }
    }


    private void drawCounter() {
        fill(255);
        textSize(52);
        text(string(), width / 2 - textWidth("00:00:00") / 2, height / 2 + textAscent() / 3);
    }


    public String string() {
        if (intervals.isEmpty()) {
            return millisToString(0);
        }
        int remaining = getCurrentInterval().duration() - time();
        return millisToString(remaining);
    }


    public void update() {
        if (intervals.isEmpty()) {
            return;
        }

        int newTime = millis();

        if (paused.get()) {
            startTime += newTime - currentTime;
        }

        currentTime = newTime;

        Interval interval = getCurrentInterval();
        if (time() >= interval.duration()) {
            if (interval.alert()) {
                playAlert();
            }
            startTime = newTime;
            i = (i + 1) % intervals.size();
        }
    }


    private Interval getCurrentInterval() {
        if (intervals.isEmpty()) {
            return null;
        }
        return intervals.get(i);
    }


    public Interval interval() {
        return getCurrentInterval();
    }


    private void playAlert() {
        if (alertSound != null) {
            alertSound.rewind();
            alertSound.play();
        }
    }


    public void reset() {
        i = 0;
        startTime = millis();
        currentTime = startTime;
    }


    public Interval get(int index) {
        return intervals.get(index);
    }
}


String millisToString(int ms) {
    String s = String.format("%02d:%02d:%02d", ms / 3600000 % 24, ms / 60000 % 60, ms / 1000 % 60);
    return s;
}
