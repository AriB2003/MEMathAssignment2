Xn = [2;3;1];
thresh = 1e-14;
[Fxn, Jxn] = test_function01(Xn);
while any(abs(Fxn)>thresh)
    Xn = Xn-Jxn\Fxn;
    [Fxn, Jxn] = test_function01(Xn);
end
test_function01(Xn)