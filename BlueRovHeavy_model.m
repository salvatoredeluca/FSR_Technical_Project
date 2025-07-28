
syms x y z u v w p q r phi theta psi u1 u2 u3 u4 u5 u6 u7 u8  real


%physical parameters
m_t     = BLUEROV_DATA.m_t;
I       = BLUEROV_DATA.I;
SCG     = BLUEROV_DATA.SCG;
r_cg    = BLUEROV_DATA.r_cg;
W       = BLUEROV_DATA.W;
B       = BLUEROV_DATA.B;
M       = BLUEROV_DATA.M;
tau_k   = BLUEROV_DATA.tau_k;
K_vec   = BLUEROV_DATA.K;

Xu = BLUEROV_DATA.Xu; Xuu = BLUEROV_DATA.Xuu;
Yv = BLUEROV_DATA.Yv; Yvv = BLUEROV_DATA.Yvv;
Zw = BLUEROV_DATA.Zw; Zww = BLUEROV_DATA.Zww;
Kp = BLUEROV_DATA.Kp; Kpp = BLUEROV_DATA.Kpp;
Mq = BLUEROV_DATA.Mq; Mqq = BLUEROV_DATA.Mqq;
Nr = BLUEROV_DATA.Nr; Nrr = BLUEROV_DATA.Nrr;

X_udot = BLUEROV_DATA.X_udot;
Y_vdot = BLUEROV_DATA.Y_vdot;
Z_wdot = BLUEROV_DATA.Z_wdot;
K_pdot = BLUEROV_DATA.K_pdot;
M_qdot = BLUEROV_DATA.M_qdot;
N_rdot = BLUEROV_DATA.N_rdot;

%jacobian
n_1 = [1 sin(phi)*tan(theta) cos(phi)*tan(theta);
       0 cos(phi) -sin(phi);
       0 sin(phi)*sec(theta) cos(phi)*sec(theta)];
    
n_2 = [cos(psi)*cos(theta),    -sin(psi)*cos(phi) + cos(psi)*sin(theta)*sin(phi),  sin(psi)*sin(phi) + cos(psi)*cos(phi)*sin(theta);
       sin(psi)*cos(theta),     cos(psi)*cos(phi) + sin(phi)*sin(theta)*sin(psi), -cos(psi)*sin(phi) + sin(theta)*sin(psi)*cos(phi);
      -sin(theta),              cos(theta)*sin(phi),                               cos(theta)*cos(phi)];

J_eta=[n_2,zeros(3,3);zeros(3,3),n_1];



%damping matrix 

epsilon=sym(1e-4);


D = diag([Xu + Xuu*sqrt(u^2 + epsilon), ...
          Yv + Yvv*sqrt(v^2 + epsilon), ...
          Zw + Zww*sqrt(w^2 + epsilon), ...
          Kp + Kpp*sqrt(p^2 + epsilon), ...
          Mq + Mqq*sqrt(q^2 + epsilon), ...
          Nr + Nrr*sqrt(r^2 + epsilon)]);

%Gravity and bouyancy vector
delta_WB = W - B;
g_eta = [ delta_WB*sin(theta);
         -delta_WB*cos(theta)*sin(phi);
         -delta_WB*cos(theta)*cos(phi);
          r_cg(3)*W*cos(theta)*sin(phi);
          r_cg(3)*W*sin(theta);
          0];

omega = [p; q; r];
IO = I * omega;

S_IO = [   0     -IO(3)  IO(2);
         IO(3)    0     -IO(1);
        -IO(2)  IO(1)    0];

S_omega = [  0  -r   q;
             r   0  -p;
            -q   p   0];
%masses
 M=BLUEROV_DATA.M;
 
%Coriolis and centrifugal matrix
C_rb = [m_t*S_omega,          -m_t*S_omega*SCG;
        m_t*SCG*S_omega,      -S_IO];

C_A = [ 0  0  0  0          -Z_wdot*w        0;
         0  0  0 -Z_wdot*w   0              -X_udot*u;
         0  0  0 -Y_vdot*v   X_udot*u        0;
         0 -Z_wdot*w Y_vdot*v  0          -N_rdot*r     M_qdot*q;
         Z_wdot*w  0 -X_udot*u N_rdot*r      0         -K_pdot*p;
        -Y_vdot*v X_udot*u  0 -M_qdot*q    K_pdot*p     0];

%velocity linear and angular vector
nu = [u; v; w; p; q; r];
%Kinematic model
sys_kin=[n_2*[u,v,w]';n_1*[p,q,r]'];


%Dynamical model
sys_dyn = simplify(inv(M)*( C_rb*nu - D*nu -g_eta+  [u1; u2; u3; u4; u5; u6]));

sys=[sys_kin;sys_dyn];

syms m_t xg Ixx Iyy Izz Xu Xuu Yv Yvv Zw Zww Kp Kpp Mq Mqq Nr Nrr B real
theta = [m_t; xg; Ixx; Iyy; Izz; Xu; Xuu; Yv; Yvv; Zw; Zww; Kp; Kpp; Mq; Mqq; Nr; Nrr; B];







