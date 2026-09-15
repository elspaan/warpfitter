Template folder for warpfitter loop. Copy contents and paste in disk folder, then
adjust accordingly. Add .fits files prior to running the scripts. This folder is 
set up for working with a Discminer fit result. 

Should contain:
* velocity_residuals/azimuthal_velocity_residuals_<disk_name>/ folders where the 
  azimuthal velocity residuals will be stored
* log_pars_<diskname_etc>_0steps.txt file, following Discminer output format
  (0 steps is naming convention, make sure to change from original file name)
* three bash scripts to automate loop
    - run_prep_only.sh 
    - run_fit_only.sh 
    - submit_all_iters_noslurm.sh (no SLURM system) or submit_all_iters.sh (SLURM-based system)
* warpfitter files
    - warp_fitter.py 
    - utils.py 
    - mpl_setup.py
* Discminer files
    - preparedata.py (?)
    - fit_<disk>.py
    - .fits files (datacubes) (both raw and clipped?)
    - parfile.json with best fit params