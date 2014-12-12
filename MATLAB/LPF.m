function data = LPF(dataInput, freqHz, sampleFreq)
    Len = length(dataInput);
    N = 2^nextpow2(Len);
    fData = fft(dataInput,N)/Len;
    F = sampleFreq/2*linspace(0,1,N/2+1);
    cutoffIndex = 0;
    i = 0;
    while cutoffIndex == 0;
        i = i + 1;
        if abs(F(i) - freqHz) < .1
            cutoffIndex = i;
        end
    end
    fData(cutoffIndex,end) = 0;
    data = real(ifft(fData(1:cutoffIndex)));
end