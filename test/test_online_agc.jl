wav = 5*randn(32,1);
new = onlineagc(wav); # deepcopy wav and then operate in-place
onlineagc!(wav)       # in-place operation

# if the streaming wav is done. Just reset the online agc params by
setagc()

# also you can re-specify the params by
setagc(gain=1.0, maxvalue=0.6, minstep=-0.6)
