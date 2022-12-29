# Planar-Endoatmospheric-Missile-Guidance

Consider a Pursuer(missile) P and Evader E according to the interception geometry according to the following diagram:
![image](https://user-images.githubusercontent.com/86003669/210012410-5225b244-c085-4498-a38c-44cbca16a706.png)

{oA = a fixed point at sea level}\
Altitude(w.r.t. oA) Pursuer P = hP\
Altitude(w.r.t. oA) Evader E = hE\
downrange distance P = dP\
downrange distance E = dE 


Pursuer Model:

Let the pursuer be an AIM120C5 beyond-visual-range (BVR) air-to-air missile, also known as the advanced medium-range air-to-air missile (AMRAAM).
Assumptions : 
AMRAAM has a constant mass mP = 130 kg, which corresponding to its mass with half of its rocket fuel. 
We assume that AMRAAM is equipped with a boost-sustain rocket motor whose thrust profile is given by
TP(t) ={█(11,000 N,0 s ≤t < 10 s,@1,800 N,10 s ≤t < 30 s,@ 0 N,                  t > 30 s.)┤
The drag coefficient is given as follows:
Cd,P(MP) = pchip(MP,i,Cd,P,i,MP)
We get this data from the model specifications
MP,i = [ 0  0.6  0.8  1  1.2  2  3  4  5 ], 
Cd,P,i = [ 0.016 0.016 0.0195 0.045 0.039 0.0285 0.024 0.0215 0.020 ]. 
SP (ref. area) = 2.3 m2
 
Evader Model:

Let the evader be an F-16 fighter jet. 
Assumptions : 
F-16 has a constant mass mE = 10000 kg. 
Thrust profile for the F-16 be given by
TE(hE) = (ρ(hE))/(ρ(0))x76310 N  { approximation of the maximum dry thrust at the altitude hE}.
The drag coefficient is given as follows:
Cd,E(ME) = pchip(ME,i,Cd,E,i,ME)
We get this data from the model specifications
ME,i = [ 0  0.9  1  1.2  1.6  2 ],
Cd,E,i = [ 0.0175 0.019 0.05 0.045 0.043 0.038 ].
SE (ref. area) = 28 m2
 

Usually for random initial conditions or the specific initial conditions prescribed in MATLAB Driver Code, would indicate a high altitude BVR engagement scenario. So, in order to curtail it here for the sake of representation we  terminate the engagement if any one of the following “fuzing” conditions are satisfied:
	t > 500 s
	R(t) < 10 m ; either R(t) crosses 0 or  ̇R(t) > 0
	hP(t) < 0 ;   hE(t) < 0
	VP(t) < 0 ;   VE(t) < 0

For kinematic engagement:
nz,E(t) ={█(-8g,0 s ≤t < 9 s,@0g,9 s ≤  t < 10 s,@-6g,10 s ≤t ≤ 22 s,@0g,t > 22 s,@                 )┤

Guidance Law for Pursuer:  nz,P = −3(|R|) ̇β ̇  subject to: |nz,P|< 40 g.


For dynamic engagement:

 nz,E(t) ={█(-6g,0 s ≤t ≤ 26 s,@g,t> 26 s,@                 )┤

Gravity Corrected Guidance Law for Pursuer:  nz,P = −3(|R|) ̇β ̇ – gcos(γp) 
subject to: |nz,P|< 40 g.

Now uconsidering all the assumptions above we derived the Kinematic and Dynamic differential equations , we get a set of trajectories for pursuer, evader and their interception and/or detonation

Output:
For kinematic engagement:
 
For dynamic engagement:
 

Pursuer and Evader speeds comparison plot:
 

Conditions at the start of the engagement simulation:
γP(0) = 0 rad, γE(0) = π rad; hP(0) = 10000 m, hE(0) = 10000 m;  dP(0) = 0 m, dE(0) = 30000 m.
Kinematic:
VP (t)= 900 m/s; VE (t)= 450 m/s

Dynamic:
VP (0)= 450 m/s; VE (0)= 450 m/s



