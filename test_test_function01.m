Xn = [2;3;1];
[Fxn, Jxn] = test_function01(Xn)
roots = Xn-Jxn\Fxn
test_function01(roots)