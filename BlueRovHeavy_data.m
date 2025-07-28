
T=30; %simulation time
Ts=0.01; % sampling time
%% Struct with the BlueROV2 Data

BLUEROV_DATA = struct();

BLUEROV_DATA.m_t = 11.5;
BLUEROV_DATA.W = 112.8;
BLUEROV_DATA.B = 114.8;
BLUEROV_DATA.r_cb = [0 0 0]';
BLUEROV_DATA.r_cg = [0 0 0.02]';

BLUEROV_DATA.I = diag([0.16 0.16 0.16]);
BLUEROV_DATA.SCG = [0 -0.02 0;
                    0.02 0 0;
                    0 0 0];





BLUEROV_DATA.tau_k = [0.707 0.707 -0.707 -0.707 0 0 0 0;
                     -0.707 0.707 -0.707 0.707 0 0 0 0;
                      0 0 0 0 -1 1 1 -1;
                      0.06 -0.06 0.06 -0.06 -0.218 -0.218 0.218 0.218;
                      0.06 0.06 -0.06 -0.06 0.120 -0.120 0.120 -0.120;
                     -0.1888 0.1888 0.1888 -0.1888 0 0 0 0];

BLUEROV_DATA.e1 = [1; 0; 0];
BLUEROV_DATA.e2 = [0; 1; 0];
BLUEROV_DATA.e3 = [0; 0; 1];
BLUEROV_DATA.I3 = eye(3);

BLUEROV_DATA.X_udot = 5.5;
BLUEROV_DATA.Y_vdot = 12.7;
BLUEROV_DATA.Z_wdot = 14.57;
BLUEROV_DATA.K_pdot = 0.12;
BLUEROV_DATA.M_qdot = 0.12;
BLUEROV_DATA.N_rdot = 0.12;


% Added mass matrix (negativa per convenzione)
BLUEROV_DATA.M_A = diag([ ...
    BLUEROV_DATA.X_udot, ...
    BLUEROV_DATA.Y_vdot, ...
    BLUEROV_DATA.Z_wdot, ...
    BLUEROV_DATA.K_pdot, ...
    BLUEROV_DATA.M_qdot, ...
    BLUEROV_DATA.N_rdot ...
]);

% Rigid-body mass and inertia matrix
m = BLUEROV_DATA.m_t;
z_g = BLUEROV_DATA.r_cg(3);
Ixx = BLUEROV_DATA.I(1,1);
Iyy = BLUEROV_DATA.I(2,2);
Izz = BLUEROV_DATA.I(3,3);

BLUEROV_DATA.M_rb = [ ...
    m,    0,    0,    0,     m*z_g,   0;
    0,    m,    0,   -m*z_g, 0,       0;
    0,    0,    m,    0,     0,       0;
    0,  -m*z_g, 0,    Ixx,   0,       0;
    m*z_g, 0,   0,    0,     Iyy,     0;
    0,    0,    0,    0,     0,       Izz
];

% Total mass matrix (rigid body + added mass)
BLUEROV_DATA.M = BLUEROV_DATA.M_rb + BLUEROV_DATA.M_A;








BLUEROV_DATA.Xu = 4.03;
BLUEROV_DATA.Yv = 6.22;
BLUEROV_DATA.Zw = 5.18;
BLUEROV_DATA.Kp = 0.07;
BLUEROV_DATA.Mq = 0.07;
BLUEROV_DATA.Nr = 0.07;

BLUEROV_DATA.Xuu = 18.18;
BLUEROV_DATA.Yvv = 21.66;
BLUEROV_DATA.Zww = 36.99;
BLUEROV_DATA.Kpp = 1.55;
BLUEROV_DATA.Mqq = 1.55;
BLUEROV_DATA.Nrr = 1.55;



BLUEROV_DATA.K = [40 40 40 40 40 40 40 40]';


