module cell_to_edge_module

  use bl_types

  implicit none
  
  private

  public :: cell_to_edge
  
contains
  
  subroutine cell_to_edge(n,s0_cell,s0_edge)

    use bl_constants_module
    use geometry, only: r_start_coord, r_end_coord

    integer        , intent(in   ) :: n
    real(kind=dp_t), intent(in   ) :: s0_cell(0:)
    real(kind=dp_t), intent(inout) :: s0_edge(0:)
    
    real(kind=dp_t)                ::  s0min,s0max,tmp
    integer                        ::  r
    
    s0_edge(r_start_coord(n)) = s0_cell(r_start_coord(n))
    s0_edge(r_end_coord(n)+1) = s0_cell(r_end_coord(n))
    
    s0_edge(r_start_coord(n)+1) = &
         HALF*(s0_cell(r_start_coord(n))+s0_cell(r_start_coord(n)+1))
    s0_edge(r_end_coord(n)) = &
         HALF*(s0_cell(r_end_coord(n))+s0_cell(r_end_coord(n)-1))

    do r=r_start_coord(n)+2,r_end_coord(n)-1
       tmp = 7.d0/12.d0 * (s0_cell(r  ) + s0_cell(r-1)) &
            -1.d0/12.d0 * (s0_cell(r+1) + s0_cell(r-2))
       s0min      = min(s0_cell(r),s0_cell(r-1))
       s0max      = max(s0_cell(r),s0_cell(r-1))
       s0_edge(r) = min(max(tmp,s0min),s0max)
    end do
    
  end subroutine cell_to_edge
  
end module cell_to_edge_module
