bcode = imread('OFFv3.png');%Barcode Image %loading
xn = bcode(85, :);% row 250 was chosen randomly to %process the barcode
difh = [1 -1];% difference filter
yn = conv (double(xn),double(difh));% Filtered xn
subplot(211), stem(xn)
subplot(212), stem(yn)
%The following for loop creates a threshold signal with %zeros and ones where one represents an edge.
for m =1:323
      if (abs(yn(1,m)) < 50) % Threshold value: =50
         dn(1,m) = 0;
      else
         dn(1,m) = 1;
      end
end
ln = find (dn);
stem (ln)
delta_n = conv(ln,difh);
hold on;
subplot(211), stem (ln)
subplot(212), stem(delta_n)
% most of the values of the deltan are 3,6,9,12
subplot(211), stem (ln)
subplot(212), stem(delta_n)
sum = 0;
for n = 5:63
       sum = sum + delta_n(1,n);
end
divider = sum / 95; % divider = 2.67368421052632
for n = 1:67
      delta_n(1,n) = delta_n(1,n)/divider;
end
for n=1:67
	if (delta_n(1,n) >0.5 && delta_n(1, n) <= 1.5)
           	delta_n(1,n) = 1;
	end
	if (delta_n(1,n) >1.5 && delta_n(1, n) <= 2.5)
           	delta_n(1,n) = 2;
	end
	if (delta_n(1,n) >2.5 && delta_n(1, n) <= 3.5)
           	delta_n(1,n) = 3;
	end
	if (delta_n(1,n) >4 && delta_n(1, n) <= 5)
           	delta_n(1,n) = 4;
	end
end
barcodearray = delta_n(1,5:63);
decodeUPC (barcodearray)