module AGC

export agc!
export agc

function agc!(wav::Array, fs::Real=16000.0; maxvalue=0.6)
    gain   = 1.0
    winlen = floor(Int, 0.016 * fs)
    frames = div(length(wav)-winlen, winlen) + 1
    firstIds = (0:(frames-1)) .* winlen .+ 1       # 帧起始下标
    lasstIds = firstIds .+ (winlen - 1)            # 帧结束下标
    maxvalue = 1/(maxvalue + 1e-38)
    for t = 1:frames
        index = firstIds[t]:lasstIds[t];
        frame = wav[index];
        hmax = maximum(abs.(frame));
        step = 1.0 - hmax*maxvalue;
        step = step * abs(step);
        step = max(-0.6, min(step, 0.0));
        gain = 0.8*gain + 0.2*(1 + step);
        wav[index] .*= gain;
    end
end


function agc(wav::Array, fs::Real=16000.0; maxvalue=0.6)
    data = deepcopy(wav)
    agc!(data, fs; maxvalue = maxvalue)
    return data
end


end #module
