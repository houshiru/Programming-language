! Author: Shiru Hou, shou2015@my.fit.edu
! Author: Hung Tran, Tranh2015@my.fit.edu
! Course: CSE 4250, Fall 2017
! Project: Proj1, Spread of Epidemics

program try
    implicit none
!declare integer valude means population of n people
!declare real value x means epidemic for different values of α
    real :: x
    integer :: var = 0, i, n
    do while (var == 0)
! IOSTAT=var prenstent the file open state
!var>0 read error
!var=0 read correct
!var<0 read file end
        read(*,*,iostat=var) n,x
        if(var == 0) then
!call subroutine program
            call SpreadofEpidemics(n,x)
        end if
    end do
end program try

subroutine SpreadofEpidemics(n,x)
    ! This sub program caculate the value of γ= 1+ W⁡( −α⁢ e−α ) /α
    ! The out put value equal nγ
    implicit none
    integer :: n, q
    real :: x, y, m, diff, w, ww
    real, parameter :: e = 2.71828182846
    diff = 1
    !read(*,*) n, x
    y = -x * (e**(-x))
    w = 0
    ww = 0
    do while (diff > 0.00000001)
        ww = w - ( ((w*(e**w)) - y) / ( (e**w)*(w+1)-((w*(e**w))-y)*(w+2)/(2*w+2) ))
        diff = w - ww
        w = ww
    end do
    m = 1 + w/x
    q = NINT(m*n)
!q stands for nγ
    print*, q
    return
end subroutine SpreadofEpidemics



