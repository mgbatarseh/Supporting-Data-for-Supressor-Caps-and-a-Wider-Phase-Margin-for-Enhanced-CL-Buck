%components based on duty cycle, ripples, output voltage and current
L=109.195*10^-6;
C=750*10^-9;
Vin=14;
r=0.1;
R=5

%Compensator design, based on phase margin, wc 
prompt = 'What is the phase margin? ';
phasemargin=input(prompt)

prompt = 'What is  wc new? ';
wcnew=input(prompt);
display(wcnew);

prompt = 'What is the magnitude of Gc at wc new in dbs? ';
dbwcnew=input(prompt);

prompt = 'What is the angle of Gc at wc new? ';
angleGc=input(prompt);

%resonance frequency
magwcnew=10^(dbwcnew/20);
resonance=(L*C)^-0.5;
display(resonance);

%phi boost
boost=-90+phasemargin-angleGc;
display(boost);

%Kboost
xy=(45+(boost/4));
display(xy);
Kboost=tand(xy);
display(Kboost);

%zero frequency(rad/s)
wz=wcnew/Kboost;
display(wz);

%pole frequency (rad/s)
wp=wcnew*Kboost;
display(wp);

%magnitude of Gc
magGc=1/(0.556*0.2*magwcnew);
display(magGc);

%Kc calculation
kc=(magGc*wz)/Kboost;
display(kc);

%powerstage transfer function

g=tf('s');
powerstage=(Vin*(1+g*r*C))/(L*C*(g^2+g*((R*C)^-1+(r*L^-1))+(L*C)^-1));
subplot(3,1,1)
margin(powerstage)

%Gc transfer function
Gc=(kc*(1+g*(wz^-1))^2)/(g*(1+g*(wp^-1))^2);
display(Gc);

%Openloop Transfer Function
openloop=(powerstage*Gc*0.556*0.2);

%closedloop Transfer Funtion, Margin and Step 
closedloop=5*(openloop/(1+openloop));
subplot(3,1,2);
margin(closedloop);

subplot(3,1,3);
step(closedloop);

%openloop=powerstage*Gc*0.556;
%closedloop=openloop/(1+0.2*openloop);
%subplot(5,1,2);
%margin(closedloop);
%closedloop=powerstage/(1+powerstage*0.2*0.556);
%subplot(3,1,3);
%margin(closedloop);

%compensator components
prompt = 'What is the magnitude of R1 (e.g.100k)? ';
R1=input(prompt);

C2=(wz)/(kc*wp*R1);
display(C2);

C1=(C2*((wp/wz)-1));
display(C1);

R2=1/(wz*C1);
display(R2);

R3=R1/((wp/wz)-1);
    display(R3);
C3=1/(wp*R3);
display(C3);

