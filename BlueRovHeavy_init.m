folderName =fullfile(pwd, 'Utilities');
if  ~exist(folderName, 'dir') % Check if the folder doesnt  exist    
    mkdir(folderName); % Create the folder
end

%% Load Physical Parameters' struct
run BlueRovHeavy_data.m;

%% Gains for FEEDBAC LINEARIZATION  Control
Kf_D=43;
Kf_P=78;

%% Gains for SLIDING MODE Control
Ks_S=8;
Ks_D=67;

Lambda=58*eye(6);

%% Symbolic Kinematic Model (Quaternion Representation)

syms q0 q1 q2 q3 dq0 dq1 dq2 dq3 real

q = [q0; q1; q2; q3];
dq = [dq0; dq1; dq2; dq3];


Rq=[1-2*(q2^2+q3^2) 2*(q1*q2-q3*q0) 2*(q1*q3+q2*q0);
    2*(q1*q2+q3*q0) 1-2*(q1^2+q3^2) 2*(q2*q3-q1*q0);
    2*(q1*q3-q2*q0) 2*(q2*q3+q1*q0) 1-2*(q1^2+q2^2)];

Tq=0.5*[-q1,-q2,-q3;
    q0,-q3,q2;
    q3,q0,-q1;
    -q2,q1,q0];

J_q=[Rq,zeros(3,3);zeros(4,3),Tq];

J_qdot=simplify(jacobian(J_q(:),q)*dq);
J_qdot = reshape(J_qdot, size(J_q)); 

J_qdot_func=matlabFunction(J_qdot,'File',string(folderName)+'/compute_Jdot','Vars',{q0, q1, q2, q3, dq0, dq1, dq2, dq3});

