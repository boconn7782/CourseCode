function [mpay,tpay] = loan(amount, rate, years)
% Calculates the monthly and total payments
% for a loan given the amount, rate, and years.
% Input Arguments:
%   amount = Loan amount in US$
%   rate = Annual interest rate as a percent
%   years = Number of Years
% Output Arguments:
%   mpay = Monthly Payment amount in US$
%   tpay = Total cost of the loan in US$

MRate = rate*0.1/12; % Monthly Rate
a = 1 + MRate;
b = (a^(years*12)-1)/MRate;
mpay = amount*a^(years*12)/(a*b);
tpay = mpay*12*years;
end
