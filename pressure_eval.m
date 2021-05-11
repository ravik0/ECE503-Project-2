function[rmsval] = pressure_eval(true, filtered, startup)
    true = true(startup+1: end);
    filtered = filtered(startup+1:end); %remove startups from both

    diff = (true - filtered).^2;
    value = sum(diff)/length(diff);
    rmsval = sqrt(value);
end