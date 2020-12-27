# AGC
 Automatic gain control module for speech signals

## Installation
Enter the REPL mode and add the module
```julia
]add https://github.com/sonosole/AGC.git
```
or
```julia
]add AGC
```

## Offline Example
In offline situation, the input is a whole single channel speech signal.

```julia
using WAV
using AGC

wav, fs = wavread("./doc/123.wav")

new = agc(wav,fs,maxvalue=0.5,minstep=-0.99); # deepcopy wav and then operate in-place
agc!(wav,fs,maxvalue=0.15,minstep=-0.5)       # in-place operation

wavwrite(wav, "./doc/agced1.wav", Fs=fs, nbits=32)
wavwrite(new, "./doc/agced2.wav", Fs=fs, nbits=32)
```

After adjustment, the value larger than specified maximum value is weakened.

![agced](/doc/agced-wav.png)


## Online Example
In online situation, the input is a frame of speech signal, so it is for streaming usage.

```julia
wav = 5*randn(32,1);
new = onlineagc(wav); # deepcopy wav and then operate in-place
onlineagc!(wav)       # in-place operation

# if the streaming wav is done. Just reset the online agc params by
setagc()

# also you can re-specify the params by
setagc(gain=1.0, maxvalue=0.6, minstep=-0.6)
```
