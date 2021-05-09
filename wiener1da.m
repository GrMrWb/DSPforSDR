function h=wiener1da(input,output)
    autocor=xcorr(input,input);
    crosscor=xcorr(input,output);
    Rxx=toeplitz(autocor((end+1)/2:end));
    rdx=crosscor((end+1)/2:-1:1);
    rdx=rdx';
    h=Rxx\rdx;
end    