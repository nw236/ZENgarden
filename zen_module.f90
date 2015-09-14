module zenvar
implicit none

integer, parameter :: noPhases=2
integer, parameter :: noComponents=2


real*8 ::  frac(2)
real*8 ::  moleA(2), moleB(2)
real*8 ::  muA(noPhases)
real*8 ::  muB(noPhases)
real*8 ::  muO(noPhases,noComponents)
real*8 ::  MA, MB



contains


!
subroutine initThermData
  integer phase, component

  phase = 1
  muO(phase,1)=5000.0
  muO(phase,2)=8000.0

  phase = 2
  muO(phase,1)=9000.0
  muO(phase,2)=4000.0
end subroutine




!
function chemPot(phase,component,m,Temp) result(mu)
  implicit none
  integer :: phase       ! phase selector
  integer :: component   ! component selector
  real*8  :: m       ! molefraction
  real*8  :: Temp    ! Temperature
  real*8	:: mu
  
  ! function could be improved by calculation all 
  !   chemp.Pot. for all component of a phase, Fewer function calls.

  mu = muO(phase,component) + 8.314*Temp*log(m)
end function




!
subroutine GibbsE(G,phase,m,Temp)
  implicit none
  integer :: phase   ! phase selector
  real*8  :: m       ! molefraction
  real*8  :: Temp    ! Temperature
  real*8	:: G       ! Gibbs Energy

  !mu = muO(phase) + 8.314*Temp*log(molefraction)
end subroutine





end module