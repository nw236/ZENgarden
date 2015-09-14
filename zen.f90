program zen
use zenvar
implicit none

real*8		::   moleATotal, moleBTotal
real*8		::	 temp, dz
real*8		::	 jA, jB
real*8      ::   dt
real*8      ::   Vm
real*8      ::   vel
real*8      ::   cA, cB

integer     ::   phase
integer, parameter :: phaseA=1, phaseB=2
integer		::	 i
integer		::	 outUnit


! Compile using:
! gfortran -static -ofast zen_module.f90 zen.f90

!
! Init
 call initThermData
 
 ! characteristic distance
 dz = 1.0
 dt = 1.0E-4
 
 !set phase fractions
 frac(1)=0.5
 frac(2)=1.0-frac(1)

 ! Set total composition of point
 moleATotal = 0.5
 moleA(1) = moleATotal
 moleA(2) = moleATotal

 ! Set total composition of point
 moleBTotal = 1.0 - moleATotal
 moleB(1) = moleBTotal
 moleB(2) = moleBTotal

 ! Mobilities
 MA = 1.0E-0
 MB = 1.0E-0 
 
 
 temp = 1000.0

 Vm = 1.0
 vel = 0.0
 
 outUnit=12
 open(unit=outUnit,file="CalcRes.dat")
 write(outUnit,*) '# cAtotal,  cBtotal,  muA(1),  muB(1),  moleA(1),  moleB(1),  muA(2),  muB(2),  moleA(2),  moleB(2),  vel'
 write(outUnit,1000) moleATotal,moleBTotal,muA(1),muB(1),moleA(1),moleB(1),muA(2),muB(2),moleA(2),moleB(2),vel


!
! relax...
 do i=1, 10

   ! calc chemical potentials
   phase = phaseA
   !muA(phase)= muAO(phase) + 8.314 * temp *log(moleA(phase))
   !muB(phase)= muBO(phase) + 8.314 * temp *log(moleB(phase))
   muA(phase) = chemPot(phase,1,moleA(phase),temp)
   muB(phase) = chemPot(phase,2,moleA(phase),temp)

   phase = phaseB
   !muA(phase)= muAO(phase) + 8.314 * temp *log(moleA(phase))
   !muB(phase)= muBO(phase) + 8.314 * temp *log(moleB(phase))
   muA(phase) = chemPot(phase,1,moleA(phase),temp)
   muB(phase) = chemPot(phase,2,moleA(phase),temp)
  
   ! Calc flux between phases
   jA = -1.0 * MA * moleATotal * (muA(phaseB)-muA(phaseA)) / dz
   jB = -1.0 * MB * moleBTotal * (muB(phaseB)-muB(phaseA)) / dz

   ! Calc change in composition
   cA = moleAtotal * dt/dz *jA
   cB = moleBtotal * dt/dz *jB

!   print*, cA, cB, jA, jB
   
   ! update compositions
   phase = 1
   moleA(phase) = moleA(phase) - cA 
   moleB(phase) = moleB(phase) - cB 

   phase = 2
   moleA(phase) = moleA(phase) + cA 
   moleB(phase) = moleB(phase) + cB 
   
   
   vel = Vm * (jA + jB)
   print*, vel, jA, jB
   
   
   ! output
   moleATotal = frac(1)*moleA(1) + frac(2)*moleA(2)
   moleBTotal = frac(1)*moleB(1) + frac(2)*moleB(2)
   write(outUnit,1000) moleATotal,moleBTotal,muA(1),muB(1),moleA(1),moleB(1),muA(2),muB(2),moleA(2),moleB(2),vel
 
 end do

call flush(outUnit)

close(12)
! 11
 !1000 format (2f6.2,2(2e15.3,2f6.3),f6,3)
 1000 format (2f6.2,2(2e18.6,2f9.5),f6.2)
 
end program