# Planar-Endoatmospheric-Missile-Guidance

Consider a Pursuer(missile) P and Evader E according to the interception geometry according to the following diagram:
![image](https://user-images.githubusercontent.com/86003669/210012410-5225b244-c085-4498-a38c-44cbca16a706.png)

{oA = a fixed point at sea level}\
Altitude(w.r.t. oA) Pursuer P = h<sub>P</sub>\
Altitude(w.r.t. oA) Evader E = hh<sub>E</sub>\
downrange distance P = dh<sub>P</sub>\
downrange distance E = dh<sub>E</sub> 


## Pursuer Model:

Let the pursuer be an AIM120C5 beyond-visual-range (BVR) air-to-air missile, also knownas the advanced medium-range air-to-air missile (AMRAAM).

Assumptions :

AMRAAM has a constant mass mP= 130 kg, which corresponding to its mass with half of itsrocket fuel.

We assume that AMRAAM is equipped with a boost-sustain rocket motor whose thrust profile is given by

The drag coefficient is given as follows:

C<sub>d,P</sub> (M<sub>P</sub>) = pchip(M<sub>P</sub>,i,C<sub>d,P</sub>,i,M<sub>P</sub>)

We get this data from the model specifications

M<sub>P,i</sub>  = [0 0.6 0.8 1 1.2 2 3 4 5],
C<sub>d,P,i</sub>  = [0.016 0.016 0.0195 0.045 0.039 0.0285 0.024 0.0215 0.020].

S<sub>P</sub>  (ref. area) = 2.3 m<sup>2

![image](https://user-images.githubusercontent.com/86003669/210036265-d3ecf97b-92ee-4ade-8225-236099a2b715.png)


## Evader Model:

Let the evader be an F-16 fighter jet.

Assumptions :

F-16 has a constant mass m<sub>E</sub>  = 10000 kg.

Thrust profile for the F-16 be given by

T<sub>E</sub>  (hE) = (ρ(h<sub>E</sub> ))/(ρ(0)) x 76310 N {approximation of the maximum dry thrust at the altitude h<sub>E}.

The drag coefficientis given as follows:

C<sub>d,E(M<sub>E) = pchip(M<sub>E,i,C<sub>d,E,i,M<sub>E)

We get this data from the model specifications

M<sub>E,i</sub>  = [0 0.9 1 1.2 1.6 2],
C<sub>d,E,i</sub>  = [0.0175 0.019 0.05 0.045 0.043 0.038].

S<sub>E</sub>  (ref. area) = 28 m<sup>2

![image](https://user-images.githubusercontent.com/86003669/210036236-26654863-25ff-4606-9ea5-b7fbd28268d2.png)

Usually for random initial conditions or the specific initial conditions prescribed in MATLAB Driver Code, would indicate a high altitude BVR engagement scenario. So, in order to curtail it here for the sake of representation we terminate the engagement if any one of the following **"fuzing"** conditions are satisfied:

1. t \> 500 s
2. R(t) \< 10 m ; either R(t) crosses 0 or ̇R(t) \> 0
3. h<sub>P</sub> (t) \< 0 ; h<sub>E</sub> (t) \< 0
4. V<sub>P</sub> (t) \< 0 ; V<sub>E</sub>(t) \< 0

## Case I:

### FOR KINEMATIC ENGAGEMENT:
 
![image](https://user-images.githubusercontent.com/86003669/210036184-9d2c4b2b-7c2c-4b96-846f-b6b495c58834.png)

Guidance Law for Pursuer: n<sub>z,P</sub> = −3(|R(dot)|) ̇β(dot) subject to: |n<sub>z,P</sub>|\< 40 g.

Conditions at the start of the engagement simulation:

γ<sub>P</sub>(0) = 0 rad, γ<sub>E</sub>(0) = π rad; h<sub>P</sub>(0) = 10000 m, h<sub>E</sub>(0) = 10000 m; d<sub>P</sub>(0) = 0 m, d<sub>E</sub>(0) = 30000 m.

V<sub>P</sub> (t)= 900 m/s; V<sub>E</sub> (t)= 450 m/s

#### <ins>Output for kinematic engagement:</ins>

![image](https://user-images.githubusercontent.com/86003669/210036193-8c821ecb-ef46-4b9b-bddb-4044f7f1a158.png)

       Result: Detonation = 1;

               Miss Distance = 0.8077 m

 
### FOR DYNAMIC ENGAGEMENT:
 
![image](https://user-images.githubusercontent.com/86003669/210036156-549a810b-5330-43f8-8c81-4242180aeb43.png)

Gravity Corrected Guidance Law for Pursuer: n<sub>z,P</sub> = −3(|R(dot)|) ̇β(dot) – gcos(γ<sub>p</sub>)  subject to: |n<sub>z,P</sub>|\< 40 g.

                                  
#### <ins>Output for dynamic engagement:</ins>

![image](https://user-images.githubusercontent.com/86003669/210036028-7bad912d-925d-4659-9949-a2b9e1a36175.png)


     Result: Detonation = 0;

             Miss Distance = 1.0872e+05 m

Conditions at the start of the engagement simulation:

γ<sub>P</sub>(0) = 0 rad, γ<sub>E</sub>(0) = π rad; h<sub>P</sub>(0) = 10000 m, h<sub>E</sub>(0) = 10000 m; d<sub>P</sub>(0) = 0 m, d<sub>E</sub>(0) = 30000 m.

V<sub>P</sub> (0)= 450 m/s; V<sub>E</sub> (0)= 450 m/s

 
#### <ins>Pursuer and Evader speeds comparison plot:</ins>

![image](https://user-images.githubusercontent.com/86003669/210035997-df57edae-c246-49bb-9daa-157eac67c6f5.png)

 
 
 

## Case II:

To further test the validity of dynamic engagement, in order to justify its interception capability, we take another set of assumptions:

{ Conditions at the start of the engagement simulation:
γ<sub>P</sub>(0) = 0 rad, γ<sub>E</sub>(0) = π rad; h<sub>P</sub>(0) = 10000 m, h<sub>E</sub>(0) = 10000 m; d<sub>P</sub>(0) = 0 m, d<sub>E</sub>(0) = 30000 m, V<sub>P</sub> (0)= 450 m/s; V<sub>E</sub> (0)= 450 m/s}

- When we take the gravity corrected guidance law (as described above) and evader maneuver as:

![image](https://user-images.githubusercontent.com/86003669/210035980-1b7805cb-5bd3-4466-8372-d3a6695ab556.png)

 
#### <ins> Output Trajectory Plot:</ins>

![image](https://user-images.githubusercontent.com/86003669/210035971-09947191-6001-44b2-9a26-50d0f35474dd.png)

        Result: Detonation = 1; (No interception/wide-impact detonation{data imperative})

                Miss Distance = 3.0126e+04 m


 
 
#### <ins> Output Velocity Plot:</ins>

![image](https://user-images.githubusercontent.com/86003669/210035957-6fde057d-d14f-405e-8461-e72e15d1319f.png)

- When we take the gravity corrected guidance law (as described above) and evader maneuver as:

![image](https://user-images.githubusercontent.com/86003669/210035948-f629d2a0-db64-46f0-b80e-3b634c0e464c.png)

#### <ins> Output Trajectory Plot:</ins>

![image](https://user-images.githubusercontent.com/86003669/210035940-fc720e7d-71f1-4b2a-8c16-b0dcd376324e.png)


         Result: Detonation = 1;

                 Miss Distance = 9.3248e-04 m

 
 
#### <ins> Output Velocity Plot:</ins>
![image](https://user-images.githubusercontent.com/86003669/210035914-012bbd49-99bf-41b8-be99-8598ed1477bc.png)
