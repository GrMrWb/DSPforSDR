clear all
% z -> desired signal

h = [1 2 3 2 1];
h = h/sqrt(h*h');
x = randn(1,1000);
w = [0 0 0 0 0 0];
%w = [0 0 0 0 0 ];
%w = w/sqrt(w*w');
n = .1*randn(1,1004);
step_size = 0.001;

%% Training for wiener
inputVector_train = [1 1 0 1 0];

for i=1:9
    if i==1
        inputVector_train = [x(i) 0 0 0 0];
    elseif i==2
        inputVector_train = [x(i) x(i-1) 0 0 0];
    elseif i==3
        inputVector_train = [x(i) x(i-1) x(i-2) 0 0];  
    elseif i==4
        inputVector_train = [x(i) x(i-1) x(i-2) x(i-3) 0];
    elseif i==5
        inputVector_train = [x(i) x(i-1) x(i-2) x(i-3) x(i-4)];
        store_input = inputVector_train;
    elseif i==6
        inputVector_train = [0 x(i-1) x(i-2) x(i-3) x(i-4)];
    elseif i==7
        inputVector_train = [0 0 x(i-2) x(i-3) x(i-4)];
    elseif i==8
        inputVector_train = [0 0 0 x(i-3) x(i-4)];
    elseif i==9
        inputVector_train = [0 0 0 0 x(i-4)];
    end
    y_train(i,1)=(h)*inputVector_train(1:5)';
    z_train(i,1)=y_train(i,1)+n(i);%desire output
end

inputVector_train = [1 1 0 1 0];
new_weight = wiener1da(inputVector_train, z_train(1:5));

%%

%new_weight = new_weight/sqrt(new_weight*new_weight');
for i=1:1000
    if i==1
        inputVector = [x(i) 0 0 0 0];
    elseif i==2
        inputVector = [x(i) x(i-1) 0 0 0];
    elseif i==3
        inputVector = [x(i) x(i-1) x(i-2) 0 0];
    elseif i==4
        inputVector = [x(i) x(i-1) x(i-2) x(i-3) 0];
    elseif i==5
        inputVector = [x(i) x(i-1) x(i-2) x(i-3) x(i-4)];
    elseif i==1001
        inputVector = [0 x(i-1) x(i-2) x(i-3) x(i-4)];
    elseif i==1002
        inputVector = [0 0 x(i-2) x(i-3) x(i-4)];
    elseif i==1003
        inputVector = [0 0 0 x(i-3) x(i-4)];
    elseif i==1004
        inputVector = [0 0 0 0 x(i-4)];
    else
        inputVector = [x(i) x(i-1) x(i-2) x(i-3) x(i-4)];
        %P_zx = xcorr([x(i-1) x(i-2)],[z(i-1),z(i-1)]);
        %Rxx = xcorr([x(i) x(i-1) x(i-2) x(i-3) x(i-4)],[x(i) x(i-1) x(i-2) x(i-3) x(i-4)]);
    end
    
    y(i,1)=(h)*inputVector(1:5)';
    z(i,1)=y(i,1)+n(i);
%    e(i,1)=z(i,1)-y_w(i,1);
    
    %Rxx(i,:) = xcorr(inputVector(1),inputVector(5),0)

    snR(i,1)=snr(y(i,1),z(i,1));
end
opt = wiener1da(x, z);
%%
filter_legth=5;
for i=1:1000
    if i==1
        if filter_legth==5
            inputVector = [x(i) 0 0 0 0];
        elseif filter_legth==6
            inputVector = [x(i) 0 0 0 0 0];
        elseif filter_legth==7
            inputVector = [x(i) 0 0 0 0 0 0];
        end
    elseif i==2
        if filter_legth==5
            inputVector = [x(i) x(i-1) 0 0 0 ];
        elseif filter_legth==6
            inputVector = [x(i) x(i-1) 0 0 0 0];
        elseif filter_legth==7
            inputVector = [x(i) x(i-1) 0 0 0 0 0];
        end
    elseif i==3
        if filter_legth==5
            inputVector = [x(i) x(i-1) x(i-2) 0 0 ];
        elseif filter_legth==6
            inputVector = [x(i) x(i-1) x(i-2) 0 0 0];
        elseif filter_legth==7
            inputVector = [x(i) x(i-1) x(i-2) 0 0 0 0];
        end      
    elseif i==4
        if filter_legth==5
            inputVector = [x(i) x(i-1) x(i-2) x(i-3) 0 ];
        elseif filter_legth==6
            inputVector = [x(i) x(i-1) x(i-2) x(i-3) 0 0];
        elseif filter_legth==7
            inputVector = [x(i) x(i-1) x(i-2) x(i-3) 0 0 0];
        end
    elseif i==5
        if filter_legth==5
            inputVector = [x(i) x(i-1) x(i-2) x(i-3) x(i-4)];
        elseif filter_legth==6
            inputVector = [x(i) x(i-1) x(i-2) x(i-3) x(i-4) 0];
        elseif filter_legth==7
            inputVector = [x(i) x(i-1) x(i-2) x(i-3) x(i-4) 0 0];
        end    
    elseif i==6
        if filter_legth==5
            inputVector = [x(i) x(i-1) x(i-2) x(i-3) x(i-4)];
        elseif filter_legth==6
            inputVector = [x(i) x(i-1) x(i-2) x(i-3) x(i-4) x(i-5)];
        elseif filter_legth==7
            inputVector = [x(i) x(i-1) x(i-2) x(i-3) x(i-4) x(i-5) 0];
        end
    else
        if filter_legth==5
            inputVector = [x(i) x(i-1) x(i-2) x(i-3) x(i-4)];
        elseif filter_legth==6
            inputVector = [x(i) x(i-1) x(i-2) x(i-3) x(i-4) x(i-5)];
        elseif filter_legth==7
            inputVector = [x(i) x(i-1) x(i-2) x(i-3) x(i-4) x(i-5) x(i-6)];
        end
    end
    y_w(i,1)=(opt(1:filter_legth)')*inputVector';
end

figure
hold on
stem(z)
stem(y_w)

figure
stem((z-y_w))
mean(abs((z-y_w).^2))

figure
plot(snR)
%mean(snR)

%figure
%plot(mse)