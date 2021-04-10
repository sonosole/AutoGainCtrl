global MINSTEP  = -0.6;
global MAXVALUE =  0.6;
global AGCGAIN  =  1.0;


"""
    setagc(;gain=1.0, maxvalue=0.6, minstep=-0.6)

Set the automatic-gain-control module's parameters.
# Optional Arguments
- `gain    `: inital speech signal's gain value
- `maxvalue`: specified maximum value for speech signal, maxvalue ∈ (0, +Inf)
- `minstep `: minimum value to change the gain, minstep ∈ (-1, 0)
"""
function setagc(;gain=1.0, maxvalue=0.6, minstep=-0.6)
    global MINSTEP;
    global MAXVALUE;
    global AGCGAIN;
    MINSTEP  = (-1.0 < minstep < 0.0) ? minstep : -0.6
    MAXVALUE = ( 0.0 < maxvalue ) ? maxvalue : 0.6
    MAXVALUE = 1/MAXVALUE
    AGCGAIN  = gain
    return nothing
end


"""
    onlineagc!(wav::Array)

Streaming automatic-gain-control module for speech signal.
# Arguments
- `wav`: one frame of speech signal
"""
function onlineagc!(wav::Array)
    global MINSTEP;
    global MAXVALUE;
    global AGCGAIN;
    fmax = maximum(abs.(wav));
    step = 1.0 - fmax*MAXVALUE;
    step = step * abs(step);
    step = max(MINSTEP, min(step, 0.0));
    AGCGAIN = 0.8*AGCGAIN + 0.2*(1 + step);
    wav .*= AGCGAIN;
    return nothing
end


"""
    onlineagc(wav::Array) -> Array

Streaming automatic-gain-control module for speech signal.
# Arguments
- `wav`: one frame of speech signal
"""
function onlineagc(wav::Array)
    data = deepcopy(wav)
    onlineagc!(data)
    return data
end
