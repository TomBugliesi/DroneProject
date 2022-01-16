%% Script per realizzare il controllo Computed Torque
run('eq_non_linear.m');
clc %mostrare nella command window solo gli elementi del presente script

% riparto dalle equazioni della dinamica ma non mi sposto nel punto di
% equilibrio
% f1 = subs(sol.xpp,[F11,F12,F21,F22],[F11+ms/4*g,F12+ms/4*g,F21+ms/4*g,F22+ms/4*g]);
% f2 = subs(sol.ypp,[F11,F12,F21,F22],[F11+ms/4*g,F12+ms/4*g,F21+ms/4*g,F22+ms/4*g]);
% f3 = subs(sol.zpp,[F11,F12,F21,F22],[F11+ms/4*g,F12+ms/4*g,F21+ms/4*g,F22+ms/4*g]);
% f4 = subs(sol.th1pp,[F11,F12,F21,F22],[F11+ms/4*g,F12+ms/4*g,F21+ms/4*g,F22+ms/4*g]);
% f5 = subs(sol.th2pp,[F11,F12,F21,F22],[F11+ms/4*g,F12+ms/4*g,F21+ms/4*g,F22+ms/4*g]);
% f6 = subs(sol.th3pp,[F11,F12,F21,F22],[F11+ms/4*g,F12+ms/4*g,F21+ms/4*g,F22+ms/4*g]);

f1_eq_CT = simplify(subs(sol.xpp,[F11,F12,F21,F22,F11p,F12p,F21p,F22p],[F11_HPRY,F12_HPRY,F21_HPRY,F22_HPRY,F11_HPRYp,F12_HPRYp,F21_HPRYp,F22_HPRYp]));
f2_eq_CT = simplify(subs(sol.ypp,[F11,F12,F21,F22,F11p,F12p,F21p,F22p],[F11_HPRY,F12_HPRY,F21_HPRY,F22_HPRY,F11_HPRYp,F12_HPRYp,F21_HPRYp,F22_HPRYp]));
f3_eq_CT = simplify(subs(sol.zpp,[F11,F12,F21,F22,F11p,F12p,F21p,F22p],[F11_HPRY,F12_HPRY,F21_HPRY,F22_HPRY,F11_HPRYp,F12_HPRYp,F21_HPRYp,F22_HPRYp]));
f4_eq_CT = simplify(subs(sol.th1pp,[F11,F12,F21,F22,F11p,F12p,F21p,F22p],[F11_HPRY,F12_HPRY,F21_HPRY,F22_HPRY,F11_HPRYp,F12_HPRYp,F21_HPRYp,F22_HPRYp]));
f5_eq_CT = simplify(subs(sol.th2pp,[F11,F12,F21,F22,F11p,F12p,F21p,F22p],[F11_HPRY,F12_HPRY,F21_HPRY,F22_HPRY,F11_HPRYp,F12_HPRYp,F21_HPRYp,F22_HPRYp]));
f6_eq_CT = simplify(subs(sol.th3pp,[F11,F12,F21,F22,F11p,F12p,F21p,F22p],[F11_HPRY,F12_HPRY,F21_HPRY,F22_HPRY,F11_HPRYp,F12_HPRYp,F21_HPRYp,F22_HPRYp]));

%% Computed Torque
%calcolo gli ingressi del computed torque
sol_CT = solve(f3_eq_CT==zpp,f4_eq_CT==th1pp,f5_eq_CT==th2pp,f6_eq_CT==th3pp,H,R,P,Yp);
H_CT = sol_CT.H;
R_CT = sol_CT.R;
P_CT = sol_CT.P;
Yp_CT = sol_CT.Yp;

%verifico che lo schema funzioni 
simplify(subs(f3_eq_CT-zpp,[H,R,P,Yp],[H_CT,R_CT,P_CT,Yp_CT]))
simplify(subs(f4_eq_CT-th1pp,[H,R,P,Yp],[H_CT,R_CT,P_CT,Yp_CT]))
simplify(subs(f5_eq_CT-th2pp,[H,R,P,Yp],[H_CT,R_CT,P_CT,Yp_CT]))
simplify(subs(f6_eq_CT-th3pp,[H,R,P,Yp],[H_CT,R_CT,P_CT,Yp_CT]))