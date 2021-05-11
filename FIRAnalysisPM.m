function FIRAnalysisPM 
    noise = [2 3 4 5 6 7 8 9 10];
    order = 10:10:100;
    fc = 0.025:0.025:0.96; %create normalized freq
    y = zeros(length(noise), length(fc), length(order)); %create 3d array

    for n = 1:length(noise)
        [true, complete] = pressure_sim(64.76, 29.87, 1.5, noise(n));
        %create pressure waveform
        for c = 1:length(fc)
            for o = 1:length(order)
                a = [1 1 0 0];
                f = [0 fc(c) fc(c)+0.025 1];
                %setup passband and stopband - have a 0.025pi difference
                %between the two
                b = firpm(order(o), f, a); %create filter
                filtered = filter(b, 1, complete); %filter out noise
                y(n, c, o) = pressure_eval(true, filtered, 100);
                %test how successful we were
            end
        end
    end
    for i = 1:length(noise)
        noise2 = y(noise(i)-1, :, :); %make noise levels into layers
        noise2_shape = reshape(noise2, length(fc), length(order)');
        mesh(order, fc, noise2_shape);
        hold on
    end
    hold off 
    colorbar; %plot
    xlabel('Filter order')
    ylabel('Cutoff Frequency')
    zlabel('RMS Error')
    title('FirPM RMS Error')
end


