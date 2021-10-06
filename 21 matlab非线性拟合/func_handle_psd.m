function [psd] = func_handle_psd(A,ft)

    p00 = A(1);
    p10 = A(2);
    p01 = A(3);
    p20 = A(4);
    p11 = A(5);
    p02 = A(6);
    p21 = A(7);
    p12 = A(8);
    p03 = A(9);
    
    x = ft(:,1);
    y = ft(:,2);
    
      psd = p00 + p10.*x + p01.*y + p20.*(x.^2) + p11.*x.*y + p02.*(y.^2) + p21.*(x.^2.*y) + p12.*x.*(y.^2) + p03.*(y.^3);

end