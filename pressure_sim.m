function[true, complete] = pressure_sim(Pf, P1, a, stdy)
    t = 5400; %1.5h in seconds
    fs = 0.5; %sampling frequency
    samples = t*fs; %how many samples
    tn = 0:1/(samples/1.5):(1.5-(1/(samples/1.5))); 
    %tn is time in hours btwn samples
    P = Pf - P1.*exp(-a.*tn);
    
    fc = 0.075;
    RandStream.setGlobalStream(RandStream('mt19937ar', 'Seed', 54));
    noise = randn(1,samples+14); % Pad by 14 for start-up transient.
    [b1,a1] = butter(2, fc/(fs/2), 'low');
    noise = filter(b1, a1, noise);
    noise = noise(15:end); %remove start-up transient
    noise = stdy*noise/std(noise); %change std of noise to input std.

    true = P;
    complete = P + noise;
end