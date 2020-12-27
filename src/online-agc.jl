global MINSTEP  = -0.6;
global MAXVALUE =  0.6;
global AGCGAIN  =  1.0;


function setagc(;gain=1.0, maxvalue=0.6, minstep=-0.6)
    MINSTEP  = (-1.0 < minstep < 0.0) ? minstep : -0.6
    MAXVALUE = ( 0.0 < maxvalue ) ? maxvalue : 0.6
    MAXVALUE = 1/MAXVALUE
    AGCGAIN  = gain
    return nothing
end


function onlineagc!(wav::Array)
    hmax = maximum(abs.(wav));
    step = 1.0 - hmax*MAXVALUE;
    step = step * abs(step);
    step = max(MINSTEP, min(step, 0.0));
    AGCGAIN = 0.8*AGCGAIN + 0.2*(1 + step);
    wav .*= AGCGAIN;
end


function onlineagc(wav::Array)
    data = deepcopy(wav)
    onlineagc!(data)
    return data
end
