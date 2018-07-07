class Interval {

    private ObserverValue < Integer > duration;
    private ObserverValue < Integer > red;
    private ObserverValue < Integer > green;
    private ObserverValue < Integer > blue;
    private ObserverValue < Boolean > alert;


    public Interval(int duration, color rgb, Boolean alert) {
        this.duration = new ObserverValue < Integer > (duration, Type.TIMER_DURATION);
        this.red = new ObserverValue < Integer > (int(red(rgb)), Type.COLOR_RED);
        this.green = new ObserverValue < Integer > (int(green(rgb)), Type.COLOR_GREEN);
        this.blue = new ObserverValue < Integer > (int(blue(rgb)), Type.COLOR_BLUE);
        this.alert = new ObserverValue < Boolean > (alert, Type.TOGGLE_ALERT);
    }


    public int duration() {
        return duration.get();
    }


    public color rgb() {
        return color(red.get(), green.get(), blue.get());
    }


    public Boolean alert() {
        return alert.get();
    }


    public void setDuration(int duration) {
        this.duration.set(duration);
    }


    public void setRGB(color rgb) {
        this.red.set(int(red(rgb)));
        this.green.set(int(green(rgb)));
        this.blue.set(int(blue(rgb)));
    }


    public void setAlert(Boolean alert) {
        this.alert.set(alert);
    }


    public ObserverValue < Integer > durationObserver() {
        return duration;
    }


    public ObserverValue < Integer > redObserver() {
        return red;
    }


    public ObserverValue < Integer > greenObserver() {
        return green;
    }


    public ObserverValue < Integer > blueObserver() {
        return blue;
    }


    public ObserverValue < Boolean > alertObserver() {
        return alert;
    }
}
