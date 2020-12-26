# AGC
 Automatic gain control module for speech signals

## Installation
enter the repl mode and add the module
```julia
]add https://github.com/sonosole/AGC.git
```

## Example

```julia
using WAV
using AGC

wav, fs = wavread("./doc/123.wav");
agc!(wav,fs,maxvalue=0.3);       # in-place operation
new = agc(wav,fs,maxvalue=0.3);  # deepcopy wav and then operate in-place

wavwrite(wav, "./agced1.wav", Fs=fs, nbits=32)
wavwrite(new, "./agced2.wav", Fs=fs, nbits=32)
```

After adjustment, the value larger than specified maximum value is weakened.

![agced](/doc/agced-wav.png)
