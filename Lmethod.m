function [optimal]=Lmethod(data,dx)
%%data 2xN  1XN = independient varible, 2xN = depediente variable
% N data length. N>9
% dx = displacement
N=size(data,2);
if length(N)<9
    S=ones(N,1);
    for a=3:N-5
        [P1,~]= polyfit(data(1,1:a),data(2,1:a),1);
        [P2,~] = polyfit(data(1,a+dx:end),data(2,a+dx:end),1);
        S(a)= sum([(data(2,1:a)-P1(1)*data(1,1:a)-P1(2)).^2,(data(2,a+dx:end)-P2(1)*data(1,a+dx:end)-P2(2)).^2]);
    end
    %%%% the best fitting
    [~,optimal]=min(S);
    optimal=(data(1,optimal(1)));
else
    optimal= N/2;
    f = uifigure;
    message = sprintf('Length Data < 9! \n the threshold is N/2 .');
    uialert(f,message,'Warning',... 
        'Icon','warning');
end