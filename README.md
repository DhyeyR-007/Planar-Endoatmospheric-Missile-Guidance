# Planar-Endoatmospheric-Missile-Guidance

Consider a Pursuer(missile) P and Evader E according to the interception geometry according to the following diagram:
![image](https://user-images.githubusercontent.com/86003669/210012410-5225b244-c085-4498-a38c-44cbca16a706.png)

{oA = a fixed point at sea level}\
Altitude(w.r.t. oA) Pursuer P = hP\
Altitude(w.r.t. oA) Evader E = hE\
downrange distance P = dP\
downrange distance E = dE 



**Pursuer Model:**

Let the pursuer be an AIM120C5 beyond-visual-range (BVR) air-to-air missile, also knownas the advanced medium-range air-to-air missile (AMRAAM).

Assumptions :

AMRAAM has a constant mass mP= 130 kg, which corresponding to its mass with half of itsrocket fuel.

We assume that AMRAAM is equipped with a boost-sustain rocket motor whose thrust profile is given by

The drag coefficient is given as follows:

Cd,P(MP) = pchip(MP,i,Cd,P,i,MP)

We get this data from the model specifications

MP,i = [0 0.6 0.8 1 1.2 2 3 4 5],
Cd,P,i = [0.016 0.016 0.0195 0.045 0.039 0.0285 0.024 0.0215 0.020].

SP (ref. area) = 2.3 m2

![](RackMultipart20221230-1-rzs2vh_html_d541a83a8d22f5ee.png)

**Evader Model:**

Let the evader be an F-16 fighter jet.

Assumptions :

F-16 has a constant mass mE = 10000 kg.

Thrust profile for the F-16 be given by

TE(hE) = x76310 N {approximation of the maximum dry thrust at the altitude hE}.

The drag coefficientis given as follows:

Cd,E(ME) = pchip(ME,i,Cd,E,i,ME)

We get this data from the model specifications

ME,i = [0 0.9 1 1.2 1.6 2],
Cd,E,i = [0.0175 0.019 0.05 0.045 0.043 0.038].

SE (ref. area) = 28 m2

![](RackMultipart20221230-1-rzs2vh_html_3962b543a9c5299a.png)

Usually for random initial conditions or the specific initial conditions prescribed in MATLAB Driver Code, would indicate a high altitude BVR engagement scenario. So, in order to curtail it here for the sake of representation we terminate the engagement if any one of the following **"fuzing"** conditions are satisfied:

1. t \> 500 s
2. R(t) \< 10 m ; either R(t) crosses 0 or ̇R(t) \> 0
3. hP(t) \< 0 ; hE(t) \< 0
4. VP(t) \< 0 ; VE(t) \< 0

**Case I:**

_ **FOR KINEMATIC ENGAGEMENT:** _

Guidance Law for Pursuer: nz,P = −3subject to: |nz,P|\< 40 g.

Conditions at the start of the engagement simulation:

γP(0) = 0 rad, γE(0) = π rad; hP(0) = 10000 m, hE(0) = 10000 m; dP(0) = 0 m, dE(0) = 30000 m.

VP (t)= 900 m/s; VE (t)= 450 m/s

Output for kinematic engagement:

![](RackMultipart20221230-1-rzs2vh_html_ab6f0c53f7f50fd5.png)

Result: Detonation = 1;

Miss Distance = 0.8077 m

_ **For dynamic engagement:** _

Gravity Corrected Guidance Law for Pursuer: nz,P = −3 – gcos(γp)

subject to: |nz,P|\< 40 g.

Output for dynamic engagement:

![](RackMultipart20221230-1-rzs2vh_html_9ae2cd4c8cdc86a7.png)

Result: Detonation = 0;

Miss Distance = 1.0872e+05 m

Conditions at the start of the engagement simulation:

γP(0) = 0 rad, γE(0) = π rad; hP(0) = 10000 m, hE(0) = 10000 m; dP(0) = 0 m, dE(0) = 30000 m.

VP (0)= 450 m/s; VE (0)= 450 m/s

Pursuer and Evader speeds comparison plot:

![](RackMultipart20221230-1-rzs2vh_html_eb3ef0a5d41bac1b.png)

**Case II:**

To further test the validity of dynamic engagement, in order to justify its interception capability, we take another set of assumptions:

# {
 Conditions at the start of the engagement simulation:

γP(0) = 0 rad, γE(0) = π rad; hP(0) = 10000 m, hE(0) = 10000 m; dP(0) = 0 m, dE(0) = 30000 m, VP (t)= 450 m/s; VE (t)= 450 m/s
# }

- When we take the gravity corrected guidance law (as described above) and evader maneuver as:

![](RackMultipart20221230-1-rzs2vh_html_b0c2ed2b9c4b669.png)

Output Trajectory Plot:

![](RackMultipart20221230-1-rzs2vh_html_73a62231132442ca.png)

Result: Detonation = 1; (No interception/wide-impact detonation{data imperative})

Miss Distance = 3.0126e+04 m

Output Velocity Plot:

![](RackMultipart20221230-1-rzs2vh_html_3a57963b638e8fea.png)

- When we take the gravity corrected guidance law (as described above) and evader maneuver as:

![](RackMultipart20221230-1-rzs2vh_html_3cabd0344fd4661a.png)

Output Trajectory Plot:

![](RackMultipart20221230-1-rzs2vh_html_f4427be142f5e3c1.png)

Result: Detonation = 1;

Miss Distance = 9.3248e-04 m

Output Velocity Plot:

![](RackMultipart20221230-1-rzs2vh_html_519fae13c8048af5.png)

![](RackMultipart20221230-1-rzs2vh_html_9e542894855a8a8.png)

