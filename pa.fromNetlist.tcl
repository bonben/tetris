
# PlanAhead Launch Script for Post-Synthesis floorplanning, created by Project Navigator

create_project -name tetris -dir "/home/leonardon/Projets/VHDL/tetris/planAhead_run_1" -part xc6slx16csg324-2
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "/home/leonardon/Projets/VHDL/tetris/tetris.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {/home/leonardon/Projets/VHDL/tetris} {ipcore_dir} }
set_property target_constrs_file "Nexys3_Master.ucf" [current_fileset -constrset]
add_files [list {Nexys3_Master.ucf}] -fileset [get_property constrset [current_run]]
link_design
