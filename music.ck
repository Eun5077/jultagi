//// Audio setup /////
global Gain bus;
SndBuf buf => bus;

3::second => now;

///// MELODY starts /////////
"sounds/melody1.wav" => buf.read;
buf.length() => now;

"sounds/melody2.wav" => buf.read;
buf.length() => now;

/// Instrument functions ////////
// Jing
fun void jing(){
    SndBuf buf => bus;
    "sounds/Jing.wav" => buf.read;
    0.3 => buf.gain;
    buf.length() => now;
}

// Kkwaenggwari
fun void kkwaenggwari(){
    SndBuf buf => bus;
    "sounds/Kkwaenggwari.wav" => buf.read;
    buf.length() => now;
}

// Janggu (samples 1-6)
fun void janggu(int n){
    SndBuf buf => bus;
    "sounds/Janggu" + n + ".wav" => buf.read;
    buf.length() => now;
}

///// Jing after the melody ///////
1::second => now;
spork ~ jing();
3::second => now;

1::second => dur interval;  // set tempo

////// Percussion section (96 beats / 24 bars) //////
for (0 => int i; i < 100; i++) {

    // Jing: every 4 beats -> every 2 beats -> every beat
    if (i % 4 == 0 && i > 0 && i < 32){
        spork ~ jing();
    } else if (i % 2 == 0 && i >= 32 && i < 48){
        spork ~ jing();
    } else if (i >= 48){
        spork ~ jing();
    }

    // Divide each beat into triplets
    for (0 => int j; j < 3; j++) {

        // Kkwaenggwari
        if (i < 8 || i > 88) {
            // play on downbeat for the first 8 beats
            if (j == 0) {
                spork ~ kkwaenggwari();
            }
        } else{
            // play randomly from beat 9
            if (Math.random2(0, 1) == 1) {
                spork ~ kkwaenggwari();
            }
        }
 
        // Janggu 1
        if (i >= 4 && i < 8 && i % 2 == 0 && j == 0) {
            // play every 2 beats from beats 5-8
            spork ~ janggu(1);
        } else if (i >= 8 && j == 0){
            // play on every downbeat after beat 9
            spork ~ janggu(1);
        }

        // Janggu 2-6
        if (i >= 16 && i <= 88 && Math.random2(0, 1) == 1) {
            // randomly trigger samples 2-6 in triplet
            spork ~ janggu(Math.random2(2, 6));
        }

        interval / 3 => now;    // advance by one triplet
    }

    // tempo control
    if (i < 4) {
        interval - 0.125::second => interval;
    } else if (i >= 48 && i < 88) {
        if (interval > 0.35::second) {
            interval - 0.005::second => interval;
        }
    } else if (i >= 88) {
        interval + 0.04::second => interval;
    }
}

///////// Ending ////////////
"sounds/Jing.wav" => buf.read;
0.3 => buf.gain;
buf.length() => now;
