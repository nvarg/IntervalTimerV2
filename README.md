# IntervalTimerV2
A simple interval timer using the Java mode for processing

## What is this?

![timer demonstration](https://i.imgur.com/9YGW4EY.gif)

An interval timer contains a list of intervals and starts timers in sequence. When the final interval expires it begins the first one.

For example, you could create an interval timer that ticks for 3 minutes, then 20 seconds, and then 10 minutes;

## Adding intervals

![example](https://i.imgur.com/XOutslp.gif)

![button explaination](https://imgur.com/UlGftlf.png)

#### alert

If checked, the timer will play a short alert sound to notify you that it finished.

#### red green blue

The color of each interval is customizable to help differentiate them. Accepts values between 0 and 255.

#### duration

The duration follows hh:mm:ss format, however it doesn't bound the numbers as long as they are two digits. It will accept 00:00:90 as 1 minute 30 seconds for example.
