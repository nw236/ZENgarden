module zenvar
implicit none

real*8 ::  frac(2)
real*8 ::  moleA(2), moleB(2)
real*8 ::  muA(2), muAO(2)
real*8 ::  muB(2), muBO(2)
real*8 ::  MA, MB



contains

!
subroutine chemPot(mu,phase,m,Temp)
integer :: phase   ! phase selector
real*8  :: m       ! molefraction
real*8  :: Temp    ! Temperature
real*8	:: mu

!mu = muO(phase) + 8.314*Temp*log(molefraction)

end subroutine

!
subroutine initThermData

 muAO(1)=5000.0
 muAO(2)=8000.0

 muBO(1)=9000.0
 muBO(2)=4000.0

end subroutine


end module