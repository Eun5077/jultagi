1024 => int WINDOW_SIZE;    // window size
0.2 => float WAVEFORM_Y;    // y position of waveform
10 => float DISPLAY_WIDTH;  // width of waveform display
64 => int WATERFALL_DEPTH;  // waterfall depth 

0.45 => float groundY;     // ground position
0.0 => float guyX;          // current x position of guy
groundY => float guyY;      // current y position of guy
0.0 => float velocityY;     // vertical velocity
-20 => float gravity;       // downward acceleration

GWindow.title( "JULTAGI" );     // window title
GWindow.fullscreen();           // fullscreen
GG.scene().camera().pos(@(0, -0.5, 8));
GG.scene().camera().lookAt(@(0, 1.0, 0));

// Background
GPlane sky --> GG.scene();
GPlane ground --> GG.scene();

// Sky
sky.sca(@(30, 25, 1));
sky.pos(@(0, 1, -6));
sky.color(@(0.773, 0.902, 1.0));

// ground
ground.sca(@(30, 15, 1));
ground.pos(@(0, -8, -5));
ground.color(@(0.65, 0.42, 0.22));

// Clouds
for (0 => int i; i < 3; i++) {
    GGen cloud --> GG.scene();

    if (i == 0) cloud.pos(@(-4, 4.8, -5.9));
    if (i == 1) cloud.pos(@(6, 5.4, -5.9));
    if (i == 2) cloud.pos(@(2, 3.5, -5.9));

    // shaping cloud
    for (0 => int j; j < 5; j++) {
        GCircle circle --> cloud;

        if (j < 2) {
            // Top: 2 circles
            circle.pos(@((j - 0.5) * 0.8, 0.4, 0));
        } else {
            // Bottom: 3 circles
            circle.pos(@((j - 3) * 0.8, 0, 0));
        }

        circle.sca(@(1.2, 1.2, 1));
        circle.color(@(1, 1, 1));
    }
}

// Sun
GCircle sun --> GG.scene();
sun.pos(@(-9, 7, -4.5));
sun.sca(@(3.5, 3.5, 1));
sun.color(@(0.9, 0.2, 0.1));

// Mountains
PolygonGeometry triangle;
triangle.build([@(-1, -1), @(1, -1), @(0, 1)]);

FlatMaterial green;
green.color(@(0.25, 0.55, 0.3));

for (0 => int i; i < 5; i++) {
    GMesh mountain --> GG.scene();
    mountain.mesh(triangle, green);

    mountain.pos(@(-6 + i * 3, 1.4, -5.8));
    mountain.sca(@(2.5, 2.0 + (i % 3) * 0.5, 1));
}

// Guy
GGen guy --> GG.scene();
GSphere head --> guy;
GCircle leftEye --> head;
GCircle rightEye --> head;
GCylinder body --> guy;
GCylinder rightUpperArm --> guy;
GGen rightElbow --> guy;
GCylinder rightForearm --> rightElbow;
GCylinder leftArm --> guy;
Waterfall waterfall --> rightElbow;
GCylinder rightLeg --> guy;
GCylinder leftLeg --> guy;
GCylinder hatBrim --> guy;
GCylinder hatTop --> guy;

guy.sca(@(0.3,0.3,0.3));
guy.pos(@(2, groundY, 0));

head.sca(1);
head.pos(@(0, 1.0, 0));
leftEye.sca(@(0.12, 0.12, 1));
rightEye.sca(@(0.12, 0.12, 1));
leftEye.pos(@(-0.2, 0, 0.9));
rightEye.pos(@(0.2, 0, 0.9));
leftEye.color(@(0.05, 0.05, 0.05));
rightEye.color(@(0.05, 0.05, 0.05));

body.sca(@(2,1));
body.pos(@(0, 0, 0.1));
body.color(@(0.95, 0.85, 0.65));

rightUpperArm.sca(@(0.65, 0.6, 0.5));
rightUpperArm.rotZ(-Math.PI / 2);
rightUpperArm.pos(@(0.75, 0.3, 0));
rightElbow.pos(@(1.1, 0.3, 0));
rightForearm.sca(@(0.65, 0.6, 0.5));
rightForearm.rotZ(-Math.PI / 2);
rightForearm.pos(@(0.3, 0, 0));
leftArm.sca(@(0.65,1));
leftArm.rot(@(0,0,Math.PI/4));
leftArm.pos(@(-0.7, 0.6, 0));
rightUpperArm.color(@(0.95, 0.85, 0.65));
rightForearm.color(@(0.95, 0.85, 0.65));
leftArm.color(@(0.95, 0.85, 0.65));

waterfall.pos(@(0.52, 0.30, 0.1));

rightLeg.sca(@(1.0, 1.2));
rightLeg.rot(@(0, Math.PI/2, Math.PI/8));
rightLeg.pos(@(0.4, -1, -0.2));
leftLeg.sca(@(1.0, 1.2));
leftLeg.rot(@(0, Math.PI/2, -Math.PI/8));
leftLeg.pos(@(-0.4, -1, 0.2));
rightLeg.color(@(0.15, 0.25, 0.55));
leftLeg.color(@(0.15, 0.25, 0.55));

hatBrim.sca(@(4, 0.08, 2.5));
hatBrim.pos(@(0, 1.55, 0));
hatBrim.color(@(0.05, 0.05, 0.05));
hatTop.sca(@(1, 0.4, 0.8));
hatTop.pos(@(0, 1.8, 0));
hatTop.color(@(0.05, 0.05, 0.05));

// Supports
GGen leftSupport --> GG.scene();
GGen rightSupport --> GG.scene();
GCylinder leftPole1 --> leftSupport;
GCylinder leftPole2 --> leftSupport;
GCylinder rightPole1 --> rightSupport;
GCylinder rightPole2 --> rightSupport;

leftPole1.sca(@(0.2, 2.2, 0.2));
rightPole1.sca(@(0.2, 2.2, 0.2));
leftPole2.sca(@(0.2, 2.8, 0.2));
rightPole2.sca(@(0.2, 2.8, 0.2));

leftPole1.color(@(0.9, 0.5, 0.2));
leftPole2.color(@(0.6, 0.3, 0.1));
rightPole1.color(@(0.9, 0.5, 0.2));
rightPole2.color(@(0.6, 0.3, 0.1));

leftPole1.rotX(Math.PI / 9);
leftPole2.rotX(-Math.PI / 9);
rightPole1.rotX(Math.PI / 9);
rightPole2.rotX(-Math.PI / 9);

leftPole1.posY(-0.2);
rightPole1.posY(-0.2);
rightPole2.posY(-0.3);
leftPole2.posY(-0.3);

leftSupport.pos(@(-5, groundY, 0));
rightSupport.pos(@(5, groundY, 0));

// audience
60 => int numAudience;
GGen audience[60];
float audienceY[60];
float audiencePhase[60];

for (0 => int i; i < numAudience; i++){
    audience[i] --> GG.scene();
    
    GCircle head --> audience[i];
    head.sca(@(0.25, 0.25, 1));
    head.pos(@(0, 0.6, 0));
    head.color(@(0.95, 0.8, 0.65));

    GPlane body --> audience[i];
    body.sca(@(0.4, Math.random2f(0.5, 0.8), 1));
    body.pos(@(0, 0.1, 0));
    body.color(@(Math.random2f(0.1, 0.9), Math.random2f(0.1, 0.9), Math.random2f(0.1, 0.9)));

    GCylinder leftArm --> audience[i];
    leftArm.sca(@(0.07, 0.4, 0.07));
    leftArm.pos(@(-0.3, 0.1, 0));
    leftArm.rotZ(-Math.PI / 6);

    GCylinder rightArm --> audience[i];
    rightArm.sca(@(0.07, 0.4, 0.07));
    rightArm.pos(@(0.3, 0.1, 0));
    rightArm.rotZ(Math.PI / 6);

    i % 20 => int col;
    i / 20 => int row;

    -6.2 + col * 0.65 + row * 0.15 => float x;
    -2.5 + row * 0.7 => float y;

    y => audienceY[i];
    audience[i].pos(@(x, y, -2.5));

    Math.random2f(0.5, 0.65) => float size;
    audience[i].sca(@(size, size, size));
    Math.random2f(0, 2 * Math.PI) => audiencePhase[i];
}

GLines waveform --> GG.scene();
waveform.width(0.05);
waveform.posY(WAVEFORM_Y);
waveform.color(@(0.85, 0.72, 0.35)); 

global Gain bus => dac;

bus => Flip accum => blackhole;               // accumulate samples from mic
bus => PoleZero dcbloke => FFT fft => blackhole;  // take the FFT
.95 => dcbloke.blockZero;                       // set DC blocker
WINDOW_SIZE => accum.size;                      // set size of flip
Windowing.hann(WINDOW_SIZE) => fft.window;      // set window type and size
WINDOW_SIZE*2 => fft.size;                      // set FFT size (will automatically zero pad)
Windowing.hann(WINDOW_SIZE) @=> float window[]; // get a reference for our window for visual tapering of the waveform

float samples[0];               // sample array
complex response[0];            // FFT response
vec2 positions[WINDOW_SIZE];    // a vector to hold positions

// custom GGen to render waterfall
class Waterfall extends GGen{
    0 => int playhead;              // waterfall playhead
    GLines wfl[WATERFALL_DEPTH];    // lines
    @(1.0, 1.0, 1.0)  => vec3 color;     // color

    // fan opening
    0.0 => float openness;
    0.0 => float target;
    4.0 => float foldSpeed;

    // iterate over line GGens
    for( GLines w : wfl ){
        w --> this;                 // connect as a child of this GGen
        w.width(.01);               // line width
        w.color( @(1.0, 1.0, 1.0) );    // color
    }

    // copy
    fun void latest( vec2 positions[] ){
        positions => wfl[playhead].positions;   // set into
        playhead++;                             // advance playhead
        WATERFALL_DEPTH %=> playhead;           // wrap it
    }

    // update
    fun void update( float dt ){

        // open or close the fan
        foldSpeed * dt => float step;

        if (openness < target){
            Math.min(openness + step, target) => openness;
        } else if (openness > target){
            Math.max(openness - step, target) => openness;
        }

        10 + (openness * (WATERFALL_DEPTH -1)) $ int => int lines;
        playhead => int pos;

        for( int i; i < wfl.size(); i++ ){
            pos--; if( pos < 0 ) WATERFALL_DEPTH-1 => pos;
        
        // rotate each spectrum history
        0.25 * Math.PI - Math.PI * (i$float / WATERFALL_DEPTH) => float angle;
        wfl[pos].rotZ(angle * openness);

        if (i < lines){
            wfl[pos].sca(@(1, 1, 1));
        } else{
            wfl[pos].sca(@(0, 0, 0));
        }
        wfl[pos].color(color);
        }
    }
}

// keyboard controls and getting audio from dac
fun void kbListener(){
    SndBuf buf => dac;
    while (true) {
        GG.nextFrame() => now;
        if (UI.isKeyPressed(UI_Key.Space, false) && guyY > groundY){
            Math.random2(1, 6) => int n;
            "sounds/" + n + ".wav" => buf.read;
            5.0 => buf.gain;
            0 => buf.pos;
        }

        // rotate while in the air and holding spacebar
        if (UI.isKeyDown(UI_Key.Space) && guyY > groundY){
            guy.rotate(@(0, 0, 0.3));
        } else{
            guy.rot(@(0, 0, 0));
        }

        // move left
        if (UI.isKeyDown(UI_Key.LeftArrow) && guyX > -4.5){
            0.05 -=> guyX;
        }

        // move right
        if (UI.isKeyDown(UI_Key.RightArrow) && guyX < 4.5){
            0.05 +=> guyX;
        }
    }
} 

// map audio buffer to 3D positions
fun void map2waveform( float in[], vec2 out[] ){
    if( in.size() != out.size() ){
        <<< "size mismatch in map2waveform()", "" >>>;
        return;
    }
    
    // mapping to xyz coordinate
    int i;
    DISPLAY_WIDTH => float width;
    for( auto s : in ){
        -width/2 + width/WINDOW_SIZE*i => out[i].x; // space evenly in X
        s * window[i] => out[i].y;                // map y, using window function to taper the ends
        i++;        // increment
    }
} 

// map FFT output to 3D positions
fun void map2spectrum( complex in[], vec2 out[] ){
    if( in.size() != out.size() ){
        <<< "size mismatch in map2spectrum()", "" >>>;
        return;
    }
    
    // mapping to 2D coordinate
    int i;
    1 => float width;
    for( auto s : in ){
        -width/2 + width/WINDOW_SIZE*i => out[i].y;
        5 * Math.sqrt( (s$polar).mag * 25 ) => out[i].x;
        i++;    // increment
    }

    out[0].x => float pivotX;
    out[0].y => float pivotY;

    for( int j; j < out.size(); j++ ){
        out[j].x - pivotX => out[j].x;
        out[j].y - pivotY => out[j].y;
    }
    waterfall.latest( out );
}

// do audio stuff
fun void doAudio()
{
    while( true ){
        accum.upchuck();            // upchuck to process accum
        accum.output( samples );    // get the last window size samples (waveform)
        fft.upchuck();              // upchuck to take FFT, get magnitude reposne
        fft.spectrum( response );   // get spectrum (as complex values)
        WINDOW_SIZE::samp => now;   // jump by samples
    }
}
spork ~ doAudio();

// calculate RMS amplitude
fun float getRMS(float in[]){
    if (in.size() == 0){
        return 0.0;
    }
    
    0.0 => float sum;

    for (int i; i < in.size(); i++){
        sum + in[i]*in[i] => sum; 
    }
    return Math.sqrt(sum / in.size());
}

0.0 => float smoothRMS;     // smoothing RMS
0.3 => float alpha;         // smoothing amount
0.01 => float threshold;    // minimum amount for jumping        
20.0 => float jumpScale;    // controls jump strength

// update jump movement
fun void jumping(float loudness, float dt){

    // start jump when sound is over threshold and guy is sitting on the line
    if (loudness > threshold && guyY <= groundY){
        loudness * jumpScale => velocityY;
    }

    gravity * dt +=> velocityY;     // apply gravity to velocity
    velocityY * dt +=> guyY;        // update vertical position

    // stop guy from falling below the line
    if (guyY < groundY){
        groundY => guyY;
        0.0 => velocityY;
    }

    guy.pos(@(guyX, guyY, 0));     // update guy position

}

1.0 / 60.0 => float dt;         // time step for 60 FPS

fun void fanning(float loudness){
    if (loudness > threshold){
        1.0 => waterfall.target;
    } else{
        0.0 => waterfall.target;
    }
}
spork ~ kbListener();

// graphics render loop
while( true ){
    map2waveform( samples, positions );     // map to interleaved format
    waveform.positions( positions );        // set the mesh position
    map2spectrum( response, positions );    // map to spectrum display
    
    getRMS(samples) => float rms;           // get current RMS
    alpha * smoothRMS + (1.0 - alpha) * rms => smoothRMS;   // exponential smoothing

    // Audience movement based on loudness
    for (0 => int i; i < numAudience; i++) {

        // jump based on RMS
        Math.min(smoothRMS * 1.5, 0.12) => float jump;

        // individual movement
        Math.max(0, Math.sin(now / second * 8 + audiencePhase[i])) => float motion;
        audience[i].posY(audienceY[i] + jump * motion);
    }

    fanning(smoothRMS);
    waterfall.update(dt);
    jumping(smoothRMS, dt);

    // forearm follows fan opening
    1.5 * (1.0 - waterfall.openness) => float elbowAngle;
    rightElbow.rotZ(elbowAngle);

    GG.nextFrame() => now;
}