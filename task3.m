clear all
% z -> desired signal
x = randn(1,1000);
% Channel
h = [1 2 3 2 1];
h = h/sqrt(h*h');

% Weiner Filter
new_weight = [0 0 0 0 0 ];
%w = w/sqrt(w*w');
opt = [0.2269;0.4524;0.6837;0.4577;0.2289];
n = 0.1*randn(1,1004);
step_size = 0.05;

for i=1:1000
    w = new_weight;
    if i==1
        inputVector = [x(i) 0 0 0 0];
    elseif i==2
        inputVector = [x(i) x(i-1) 0 0 0]; 
    elseif i==3
        inputVector = [x(i) x(i-1) x(i-2) 0 0];  
    elseif i==4
        inputVector = [x(i) x(i-1) x(i-2) x(i-3) 0];
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
        P_zx = xcorr([x(i-1) x(i-2)],[z(i-1),z(i-1)]);
        %Rxx = xcorr([x(i) x(i-1) x(i-2) x(i-3) x(i-4)],[x(i) x(i-1) x(i-2) x(i-3) x(i-4)]);
    end
    y(i,1)=(h)*inputVector';
    y_w(i,1)=(w)*inputVector';
    
    z(i,1)=y(i,1)+n(i);
    e(i,1)=y(i,1)-y_w(i,1);
    mse(i)= ((y(i,1)-y_w(i,1))^2)/2;
    
    if i>5
        if 2*mse(i) < mse(i-1)
            step_size= 0.03;
        elseif mse(i)< mse(i-1)
            step_size= 0.01;
        end
    end
    
    new_weight = w + step_size*e(i,1)*inputVector;
    weight_change(i,:) = w;
end
figure
subplot(1,2,1);
plot(mse)
subplot(1,2,2);
plot(weight_change)

figure
subplot(3,2,1);
plot(mse)
subplot(3,2,2);
plot(weight_change(:,1))
yline(abs(opt(1)));
title('Filter: First component')
opt(1)-weight_change(999,1)

subplot(3,2,3);
plot(weight_change(:,2))
yline(abs(opt(2)));
title('Filter: Second component')
opt(2)-weight_change(999,2)

subplot(3,2,4);
plot(weight_change(:,3))
yline(abs(opt(3)));
title('Filter: Third component')
opt(3)-weight_change(999,3)

subplot(3,2,5);
plot(weight_change(:,4))
yline(abs(opt(4)));
title('Filter: Forth component')
opt(4)-weight_change(999,4)

subplot(3,2,6);
plot(weight_change(:,5))
yline(abs(opt(5)));
title('Filter: Fifth component')
opt(5)-weight_change(999,5)
