"""
    agc!(wav::Array, fs::Real=16000.0; maxvalue::Real=0.6, minstep::Real=-0.6)

Automatic gain control module for speech signals.
The input signal `wav` would be changed after calling this function.
# Arguments
- `wav     `: raw speech signal
- ` fs     `: sampling rate
- `maxvalue`: specified maximum value for speech signal, maxvalue ∈ (0, +Inf)
- `minstep `: minimum value to change the gain, minstep ∈ (-1, 0)
"""
function agc!(wav::Array, fs::Real=16000.0; maxvalue::Real=0.6, minstep::Real=-0.6)
    minstep  = (-1.0 < minstep < 0.0) ? minstep : -0.6
    maxvalue = ( 0.0 < maxvalue ) ? maxvalue : 0.6
    gain   = 1.0
    winlen = floor(Int, 0.016 * fs)
    frames = div(length(wav)-winlen, winlen) + 1
    firstIds = (0:(frames-1)) .* winlen .+ 1       # 帧起始下标
    lasstIds = firstIds .+ (winlen - 1)            # 帧结束下标
    maxvalue = 1 / maxvalue
    for t = 1:frames
        index = firstIds[t]:lasstIds[t];
        frame = wav[index];
        hmax = maximum(abs.(frame));
        step = 1.0 - hmax*maxvalue;
        step = step * abs(step);
        step = max(minstep, min(step, 0.0));
        gain = 0.8*gain + 0.2*(1 + step);
        wav[index] .*= gain;
    end
end


"""
    agc(wav::Array, fs::Real=16000.0; maxvalue::Real=0.6, minstep::Real=-0.6) -> Array

Automatic gain control module for speech signals.
# Arguments
- `wav     `: raw speech signal
- ` fs     `: sampling rate
- `maxvalue`: specified maximum value for speech signal, maxvalue ∈ (0, +Inf)
- `minstep `: minimum value to change the gain, minstep ∈ (-1, 0)
"""
function agc(wav::Array, fs::Real=16000.0; maxvalue::Real=0.6, minstep::Real=-0.6)
    data = deepcopy(wav)
    agc!(data, fs; maxvalue = maxvalue, minstep=minstep)
    return data
end
