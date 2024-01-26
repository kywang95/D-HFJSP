# D-HFJSP
This is the MATLAB realization of the scheduling problem and memetic algorithms proposed in *A Syntactic problem Solver Learning Landscape Structures for Clinical Scheduling*.

In the paper, we first formulated the scheduling of medical tests as a distributed scheduling problem in heterogeneous, flexible job shop environment (D-HFJSP), and establish a mixed integer programming (MIP) model. Then, we designed an adaptive problem solver under the guidance of landscape analysis. In addition, a new search strategy was designed to be well suited to the instance by leveraging landscape characteristics. The MATLAB functions of Gurobi MIP, fitness landscape analysis, the syntactic problem solvers, conventional combinatorial methods, hyperheuristics, and the NEH-type constructive heuristics and are described as follows. 

* ***You can simply run main_MIP.m to obtain the results of MIP, main_acfdc.m and main_LON.m to obtain the analyses of fitness landscape, and main_basic_s_parallel_cputime.m to obtain the results of other algorithms.***

The framework of matlab code is shown in D-HFJSP_framework_of_code.png and described as follows.

* ***MIP***
	* **main_MIP.m**: The main function of using MIP to solve D-HFJSP. The function **D-HFJSP_MIP** is sourced. Create *solution_(filename).dat* containing two structures, i.e., 'mip_solution' (MTAT obtained with Gurobi solver) and 'gurobi_info' (the information generated during search).
	* **D-HFJSP_MIP.m**: The mixed integer programming of D-HFJSP, including the objective and all the constraints. Input: the 'data' of the instance; output: 'solution' (mip_solution) and 'model_para' (gurobi_info) in struct format. The function **input_func** is sourced.
	* **input_func.m**: Input: 'data' of the instance; Output: information including 'job_number', 'operation', 'factory', 'machine_number', 'capacity', 'machine_job_link', 'process_time' of the instance (parameters in Appendix A of the paper). 

* ***Syntactic Problem Solver***

* **Landscape Analysis**
    * **main_acfdc.m** : The main function of AC and FDC. The functions **inputbm**, **nwk_ss_landscape_ac**,  **nwk_ss_landscape_fdc** are sourced. Create 2 files:
	    * *data_AC_(InstanceName)\_(InterationTimes).dat* with structure 's1_cost_ac' (AC(s)), 's1_ac' (MTAT along the random walk), 's1_method_No_ac' (the Neiborhoods in SS), 's1_trend' (the descending curve). 	
	    * *data_FDC_(InstanceName)\_(InterationTimes).dat* with structure 's1_dis_opt' (the distance from the local optima to the global optima), 's1_dif_opt' (the difference in MTAT of the local optima and the global optima), 's1_fdc' (fdc value), 's1_trend' (the descending curve). 
	* **main_LON.m**: The main function of the Local Optima Network. The functions **inputbm**, **nwk_ss_LON**,  **nwk_ss_rand_LON**, and **Graph3D** are sourced. Create 3 files:
	    * *data\_(InstanceName)\_(NeighborhoodName)\_(InterationTimes).dat* with structures 's_cost' (MTAT of the local optima) and 's_solution' (the local search optima). 	
	    * *data\_(InstanceName)\_(NeighborhoodName)\_(InterationTimes)\_nodes.csv* containing all the nodes of LON. 
	    * *data\_(InstanceName)\_(NeighborhoodName)\_(InterationTimes)\_links.csv* containing all the links of LON.
	
	* **inputbm.m**: Construct the original data into a structure with parameters. 
		* Input: 'data' (the data loaded directly from *INSTANCE_BT_IT_Idx.txt*)
		* Output: 'datacell' (a structure with m (number of machines), c (capacity of machines), t (processing time), Specimen (type of specimens)

	* **nwk_ss_landscape_ac.m**: The function to obtain AC along the random walk of multiple SSs. 
		* Input:  'maxb' (the maximum number of the primal reference set), 'data' (the data structure), 'max_nfe' (the maximum iteration times), 't0SA' (the initial temperature of SA), 'method' (called neighborhood: Swap, Inverse, Insert, Block-based Insert)
		* Output: 'ac' (AC(s)), 'cost_ac' (MTAT along the random walk), 'method_No_ac' (the Neiborhoods in SS), 'trend' (the descending curve
		* The functions **input_block**, **intial_order_RAER**,  **RAER**, **COST**, **r_distance**, **combination_method**, **ite_lssa_ac**, **ite_lsmeta_ac** are sourced.
	* 	**nwk_ss_landscape_fdc.m**: The function to obtain FDC  of multiple SSs. 
		* Input: 'maxb' (the maximum number of the primal reference set), 'data' (the data structure), 'max_nfe' (the maximum iteration times), 't0SA' (the initial temperature of SA), 'method' (called neighborhood: Swap, Inverse, Insert, Block-based Insert)
		* Output: 'dis_opt' (the distance from the local optima to the global optima), 'dif_opt' (the difference in MTAT of the local optima and the global optima), 'fdc' (fdc value), 'trend' (the descending curve)
		* The functions **input_block**, **intial_order_RAER**,  **RAER**, **COST**, **r_distance**, **combination_method**, **ite_lssa_ac**, **ite_lsmeta_ac** are sourced.

	* **nwk_ss_LON.m**: The function to perform an independent run of LON from the initial solution generated by NEH heuristic and combination method. 
		* Input: 'maxb' (the maximum number of the primal reference set), 'data' (the data structure), 't0SA' (the initial temperature of SA), 'method' (called neighborhood: Swap, Inverse, Insert, Block-based Insert)
		* Output: 'final_best_value' (MTAT of the best solution), 'final_best_solution' (the best-so-far solution), 'cost' (MTAT of all the local optima), 'solution' (all the local optima)
		* The functions **input_block**, **intial_order_RAER**,  **RAER**, **COST**, **r_distance**, **combination_method**, **ite_ls_operator** are sourced.
	* **nwk_ss_rand_LON.m**: The function to perform an independent run of LON from the randomly generated initial solution. 
		* Input: 'data' (the data structure), 't0SA' (the initial temperature of SA), 'method' (called neighborhood: Swap, Inverse, Insert, Block-based Insert)
		* Output: 'final_best_value' (MTAT of the best solution), 'final_best_solution' (the best-so-far solution), 'cost' (MTAT of all the local optima), 'solution' (all the local optima)
		* 'dis_opt' (the distance from the local optima to the global optima), 'dif_opt' (the difference in MTAT of the local optima and the global optima), 'fdc' (fdc value), 'trend' (the descending curve)
		* The functions **input_block**, **COST**, **ite_ls_operator** are sourced.
    
	* **input_block.m**: Generate the block of each specimen based on the capability of machines. Input: the 'data' structure; Output: the 'data' structure with block permutation in 3rd row of data.Specimen. * The function **maxgcd** is sourced. 
	* **intial_order_RAER.m**: Generate a set of diverse solutions based on the input permutation. Input: 'seed_solution' (the seed solution of diversification generator), 'upper_bound' (the upper bound of diversification generator); Output: 'ini_order' (a collection of random solutions for NEH heuristic).
	* **NEH.m**: NEH heuristic algorithm for diversification generation method. Input: 'data' (the data structure); Output: 'cost' (the MTAT of the proposed solution), 'tran_solution' (the solution generated with NEH). The function **COST** is sourced. 
	* **RAER.m**: NEH-B heuristic algorithm for diversification generation method. Input: 'data' (the data structure), 'r_sequence' (the randomly generated initial sequence); Output: 'cost' (the MTAT of the proposed solution), 'all_solution' (the solution generated with NEH-B). The function **COST** is sourced. 
	* **COST.m**: Decode the VSS into a schedule. Input: 'SS0' (VSS), 'data' (the parameters of the instance), ('transport', which has not been considered in this paper); Output: 'Cost' (MTAT).
	* **r_distance.m**: Calculate the Job precedence rule-based distance metric between two permutations. Input: two VSSs; Output: the JPR distance of two inputs.
	* **combination_method.m**: The function of solution combination to generate a new trial solution by splicing the reference solutions in subset.
		* **Input**: 'slct_subset' (the combination subsets), 'type' (the type of combination method), 'data' (the data structure)
		* **Output**: 'new_pop' (the new population generated by path relinking), 'new_pop_cost' (the fitness of new population)
		* The function **COST** is sourced. 

	* **ite_lssa_ac.m**: the improvement method of SS-SWP (-INV, -INS, -INB).
	    * Input: 't0SA' (the temperature of simulated annealing), 'startvalue' (the cost function of start point), 'startsolution' (the start point in search process), 'data' (the data structure), 'bestsf' (the best-so-far MTAT), 'nrand_walk' (random walk steps), 'method' (the adopted neighborhood)
	    * Output: 'endvalue' (the terminal solution in the search process), 'endsolution' (the cost function of terminal point), 'ls_trend' (the descending curve), 'nfesa' (the number of evaluations), 'cost_ac' (MTAT of the solutions in random walk)  
	    * The functions **swap**, **insert**, **inverse**, **insert_block**, **COST** are sourced. 
	* **ite_lsmeta_ac.m**: the improvement method of SS-ML.
	    * Input: 't0SA' (the temperature of simulated annealing), 'startvalue' (the cost function of start point), 'startsolution' (the start point in search process), 'data' (the data structure), 'bestsf' (the best-so-far MTAT), 'probability' (the probability of the neighborhoods to be called), 'nrand_walk' (random walk steps)
	    * Output: 'endvalue' (the terminal solution in the search process), 'endsolution' (the cost function of terminal point), 'ls_trend' (the descending curve), 'nfels' (the number of evaluations), 'method_No' (the neighborhood adopted in the search process), 'cost_ac' (MTAT of the solutions in random walk)  
	    * The functions **Roulette**, **swap**, **insert**, **inverse**, **insert_block**, **COST** are sourced. 
	* **ite_ls_operator.m**: the improvement method of SS-SWP (-INV, -INS, -INB).
	    * Input: 't0SA' (the temperature of simulated annealing), 'startvalue' (the cost function of start point), 'startsolution' (the start point in the search process), 'data' (the data structure), 'bestsf' (the best-so-far MTAT), 'method' (the adopted neighborhood)
	    * Output: 'endvalue' (the terminal solution in the search process), 'endsolution' (the cost function of terminal point), 'ls_trend' (the descending curve), 'nfesa' (the number of evaluations)  
	    * The functions **swap**, **insert**, **inverse**, **insert_block**, **COST** are sourced. 

	* **swap.m**: The function of Swap. Input: ’old_perm‘ (the permutation before being swapped), 'data' (the data structure); Output: (the permutation generated by Swap)
	* **insert.m**: The function of Insert. Input: ’old_perm‘ (the permutation before Insert), 'data' (the data structure); Output: (the permutation generated by Insert)
	* **inverse.m**: The function of Inverse. Input: ’old_perm‘ (the permutation before Inverse), 'data' (the data structure); Output: (the permutation generated by Inverse)
	* **insert_block.m**: The function of Block-based Insert. Input: ’old_perm‘ (the permutation before Block-based Insert), 'data' (the data structure); Output: (the permutation generated by Block-based Insert)

	* **Roulette.m**: Select an individual from the population following Roulette strategy. Input: 'P' (the probability to be selected of each individual), 'num' (the number of individuals to be picked out); Output: 'Select' (return the individuals selected following Roulette strategy)

	* **maxgcd.m**: Get the greatest common divisor of two numbers.


* **SS, FTA, SA, GA and PSO**
	* **main_basic_s_parallel_cputime.m**:  The main function of solving D-HFJSP with SS (FTA, SA, GA, PSO)-SWP (-INV, -INS, -INB, -ML). The functions **inputbm**, **nwk_ss (sa, fta, pso, ga)** are sourced. Multiple cores are required in this experiment. Create *data\_(CaseIndex)\_iter\_(InterationTimes).dat* with Structures: 
		*	's1_final_best_value': the best-so-far MTAT in each iteration
		*	's1_final_best_solution': the best-so-far solution in each iteration
		*	's1_nfe': the iteration times 
		*	's1_cput': the CPU time (by cputime)
		*	's1_totalt': the CPU time (by tic/toc)
		*	's1_trend': the descending curve

	* **nwk_ss.m**: The main function of SS-SWP (-INV, -INS, and -INB). 
		* Input: 'maxb' (the maximum number of the primal reference set), 'data' (the data structure), 'max_nfe' (the maximum iteration times), 'maxd' (the terminal condition on the maximum distance), 't0SA' (the initial temperature of SA), 'method' (called neighborhood: Swap, Inverse, Insert, Block-based Insert)
		* Output: 'final_best_value' (the best-so-far MTAT), 'final_best_solution' (the best-so-far solution), 'nfe' (the iteration times), 'cput' (the CPU time (by cputime)), 'totalt' (the CPU time (by tic/toc)), 'trend' (the descending curve)
		* The functions **input_block**, **intial_order_RAER**,  **RAER**, **COST**, **r_distance**, **combination_method**, **local_search_sa** are sourced. 
	* **nwk_sa.m**: The main function of SA-SWP (-INV, -INS, and -INB). 
		* Input: 'maxb', 'data', 'max_nfe', 'maxd', 't0SA', 'method' (their meanings are the same as those in **nwk_ss.m**)
		* Output: 'final_best_value', 'final_best_solution', 'nfe', 'cput', 'totalt', 'trend' (their meanings are the same as those in **nwk_ss.m**)
		* The functions **input_block**, **COST**, **local_search_sa** are sourced. 
	* **nwk_fta.m**: The main function of FTA-SWP (-INV, -INS, and -INB). 
		* Input: 'maxb', 'data', 'max_nfe', 'maxd', 't0SA', 'method' (their meanings are the same as those in **nwk_ss.m**)
		* Output: 'final_best_value', 'final_best_solution', 'nfe', 'cput', 'totalt', 'trend' (their meanings are the same as those in **nwk_ss.m**)
	* **nwk_ga.m**: The main function of GA-SWP (-INV, -INS, and -INB). 
		* Input: 'maxb', 'data', 'max_nfe', 'maxd', 't0SA', 'method' (their meanings are the same as those in **nwk_ss.m**)
		* Output: 'final_best_value', 'final_best_solution', 'nfe', 'cput', 'totalt', 'trend' (their meanings are the same as those in **nwk_ss.m**)
	* **nwk_pso.m**: The main function of PSO-SWP (-INV, -INS, and -INB). 
		* Input: 'maxb', 'data', 'max_nfe', 'maxd', 't0SA', 'method' (their meanings are the same as those in **nwk_ss.m**)
		* Output: 'final_best_value', 'final_best_solution', 'nfe', 'cput', 'totalt', 'trend' (their meanings are the same as those in **nwk_ss.m**)
		* The functions **input_block**, **COST**, **local_search_sa** are sourced.
		
    * **local_search_sa.m**: the improvement method of SS-SWP (-INV, -INS, -INB).
	    * Input: 't0SA' (the temperature of simulated annealing), 'startvalue' (the cost function of start point), 'startsolution' (the start point in search process of local_search_sa), 'data' (the data structure), 'bestsf' (the best-so-far MTAT), 'method' (the adopted neighborhood)
	    * Output: 'endvalue' (the terminal solution in search process of local_search_sa), 'endsolution' (the cost function of terminal point), 'ls_trend' (the descending curve), 'nfesa' (the number of evaluations)  
	    * The functions **swap**, **insert**, **inverse**, **insert_block**, **COST** are sourced. 
	
* ***Hyperheuristics***
	* **main_basic_s_parallel_cputime.m**:  The main function of solving D-HFJSP with meta-Lamarckian, and other Hyperheuristics. The functions **inputbm**, **nwk_ss (ga, pso, fta, sa)_meta**, **nwk_HH_SR(BS, RPD)_SA(NA, AM, GDEL, LACC** are sourced. Multiple cores are required in this experiment. Create *data\_(CaseIndex)\_iter\_(InterationTimes).dat* with Structures: 
		*	's1_final_best_value': the best-so-far MTAT in each iteration
		*	's1_final_best_solution': the best-so-far solution in each iteration
		*	's1_nfe': the iteration times 
		*	's1_cput': the CPU time (by cputime)
		*	's1_totalt': the CPU time (by tic/toc)
		*	's1_trend': the descending curve
		*	's1_Pro_record' (only for SS-ML): the probability of the Roulette in meta-Lamarckian
		
		* **nwk_ss_meta.m**: The main function of SS-ML.
		* Input: 'maxb', 'data', 'max_nfe', 't0SA' (their meanings are the same as those in **nwk_ss.m**)
		* Output:  'final_best_value', 'final_best_solution', 'nfe', 'cput', 'totalt', 'trend' (their meanings are the same as those in **nwk_ss.m**), 'Pro_record' (the probability of the Roulette)
		* The functions **input_block**, **intial_order_RAER**,  **RAER**, **COST**, **r_distance**, **combination_method**, **local_search_meta_initialization**, **local_search_meta** are sourced. 
	* **nwk_sa_meta.m**: The main function of SA-ML.
		* Input: 'data', 'max_nfe', 't0SA' (their meanings are the same as those in **nwk_ss.m**)
		* Output:  'final_best_value', 'final_best_solution', 'nfe', 'cput', 'totalt', 'trend' (their meanings are the same as those in **nwk_ss.m**), 'Pro_record' (the probability of the Roulette)
		* The functions **input_block**, **COST**, **local_search_meta_initialization**, **local_search_meta** are sourced. 
	* **nwk_fta_meta.m**: The main function of FTA-ML.
		* Input: 'data', 'max_nfe', 't0SA' (their meanings are the same as those in **nwk_ss.m**)
		* Output:  'final_best_value', 'final_best_solution', 'nfe', 'cput', 'totalt', 'trend' (their meanings are the same as those in **nwk_ss.m**), 'Pro_record' (the probability of the Roulette)
		* The functions **input_block**, **COST**, **local_search_meta_initialization**, **local_search_meta** are sourced. 
	* **nwk_ga_meta.m**: The main function of GA-ML.
		* Input: 'data', 'max_nfe', 't0SA' (their meanings are the same as those in **nwk_ss.m**)
		* Output:  'final_best_value', 'final_best_solution', 'nfe', 'cput', 'totalt', 'trend' (their meanings are the same as those in **nwk_ss.m**), 'Pro_record' (the probability of the Roulette)
		* The functions **input_block**, **COST**, **local_search_meta_initialization**, **local_search_meta** are sourced. 
	* **nwk_pso_meta.m**: The main function of PSO-ML.
		* Input: 'data', 'max_nfe', 't0SA' (their meanings are the same as those in **nwk_ss.m**)
		* Output:  'final_best_value', 'final_best_solution', 'nfe', 'cput', 'totalt', 'trend' (their meanings are the same as those in **nwk_ss.m**), 'Pro_record' (the probability of the Roulette)
		* The functions **input_block**, **COST**, **local_search_meta_initialization**, **local_search_meta** are sourced. 
	* **nwk_HH_SR(BS, RL, RPD)_SA(IO, NA, AM, GDEL, LACC).m**: The main function of Hyperheuristics (SR-SA, SR-IO, SR-NA, SR-AM, SR-GDEL, SR-LACC, BS-SA, BS-IO, BS-NA, BS-AM, BS-GDEL, BS-LACC, RL-SA, RL-IO, RL-NA, RL-AM, RL-GDEL, RL-LACC, RPD-SA, RPD-IO, RPD-NA, RPD-AM, RPD-GDEL, RPD-LACC).
		* Input: 'data', 'max_nfe', 't0SA' (their meanings are the same as those in **nwk_ss.m**)
		* Output:  'final_best_value', 'final_best_solution', 'cput'(their meanings are the same as those in **nwk_ss.m**), 'Pro_record' (the probability of the Roulette)
		* The functions **input_block**, **Roulette** and **COST** are sourced. 
		
    * **local_search_sa.m**: the improvement method of SS-SWP (-INV, -INS, -INB).
	    * Input: 't0SA' (the temperature of simulated annealing), 'startvalue' (the cost function of start point), 'startsolution' (the start point in search process of local_search_sa), 'data' (the data structure), 'bestsf' (the best-so-far MTAT), 'method' (the adopted neighborhood)
	    * Output: 'endvalue' (the terminal solution in search process of local_search_sa), 'endsolution' (the cost function of terminal point), 'ls_trend' (the descending curve), 'nfesa' (the number of evaluations)  
	    * The functions **swap**, **insert**, **inverse**, **insert_block**, **COST** are sourced. 
	* **local_search_meta_initialization.m**: the training stage of the Meta-Lamarckian learning enhanced simulated annealing for improvement.
		* Input: 't0SA' (the temperature of simulated annealing), 'startvalue' (the cost function of start point), 'startsolution' (the start point in search process), 'data' (the data structure), 'bestsf' (the best-so-far MTAT), 'method' (the adopted neighborhood)
	    * Output: 'endvalue' (the terminal solution in search process of improvement method), 'endsolution' (the cost function of terminal point), 'reward' (the reward of each neighborhood after the improvement method), 'ls_trend' (the descending curve), 'nfe' (the number of evaluations), 'Pro_record_ls' (the probability of the Roulette)
	    * The functions **swap**, **insert**, **inverse**, **insert_block**, **COST** are sourced. 
	* **local_search_meta.m**: the non-training stage of the Meta-Lamarckian learning enhanced simulated annealing for improvement.
		* Input: 't0SA' (the temperature of simulated annealing), 'reward' (the reward of each neighborhood before the improvement method), 'startvalue' (the cost function of start point), 'startsolution' (the start point in the search process of improvement method), 'data' (the data structure), 'bestsf' (the best-so-far MTAT), 'probability' (the probability of the neighborhoods to be called)
	    * Output: 'endvalue' (the terminal solution in search process of local_search_sa), 'endsolution' (the cost function of terminal point), 'reward' (the reward of each neighborhood after the improvement method), 'ls_trend' (the descending curve), 'nfels' (the number of evaluations), '' 'Pro_record_ls' (the probability of the Roulette)
	    * The functions **Roulette**, **local_search_sa** are sourced. 
		
* ***Heuristics***
	* **main_basic_s_parallel_cputime.m**:  The main function of solving D-HFJSP with NEH and NEH-B. The functions **inputbm**, **nwk_heuristic_NEH_cput**,  **nwk_heuristic_NEHB_cput** are sourced. Multiple cores are required in this experiment. Create *data\_(CaseIndex)\_iter\_(InterationTimes).dat* with Structures: 
		*	's1_final_best_value': the best-so-far MTAT in each iteration
		*	's1_final_best_solution': the best-so-far solution in each iteration
		*	's1_nfe': the iteration times 
		*	's1_cput': the CPU time (by cputime)
		*	's1_totalt': the CPU time (by tic/toc)
		*	's1_trend': the descending curve

		* **nwk_heuristic_NEH_cput.m**: The main function of NEH. 
		* Input:'data' (the data structure)
		* Output: 'final_best_value' (the best-so-far MTAT), 'final_best_solution' (the best-so-far solution), 'nfe' (the iteration times), 'cput' (the CPU time (by cputime)), 'totalt' (the CPU time (by tic/toc))
		* The functions **input_block** is sourced. 
	* **nwk_heuristic_NEHB_cput.m**: The main function of NEH-B. 
		* Input: 'maxb' (the maximum number of the primal reference set), 'data' (the data structure)
		* Output: 'final_best_value' (the best-so-far MTAT), 'final_best_solution' (the best-so-far solution), 'nfe' (the iteration times), 'cput' (the CPU time (by cputime)), 'totalt' (the CPU time (by tic/toc))
		* The functions **input_block** is sourced. 


***Notice***: 
1. When running **main_MIP.m**, the folder `../statistical_analysis/MIP/` will be newly-built, if it does not exist. 
2. When running **main_basic_s_parallel.m**, folders `../statistical_analysis/(NeighBorhoodName)/simu_(CaseNum)` will be newly-built, if it does not exist. 
3. When running **main_acfdc.m**, folders `../FLA/ac/` and `../FLA/fdc/` will be newly-built, if it does not exist.
4. When running **main_LON.m**, the folder `../FLA/LON/(NeighBorhoodName)/` will be newly-built, if it does not exist. 
5. The benchmark problems should be put in folder `../benchmark/`. All the benchmark problems are available in *K. Wang, B. Liu, [Benchmark for real-practice distributed scheduling in heterogeneous, flexible job shop](https://www.researchgate.net/publication/357004534_Benchmark_for_real-practice_distributed_scheduling_in_heterogeneous_flexible_job_shop). Technical Report, Academy of Mathematics and Systems Science, Chinese Academy of Sciences, Beijing, China.*
6. The MATLAB program of Backtracking Search Hyper-heuristic (BSHH) and Q-Learning Hyper-heuristic (QLHH) were transferred from the Pascal code implemented by Ziqi Zhang, Kunming University of Science and Technology, and thus we did not make code of these two hyperheuristics public. Please inquire Dr. Zhang if necessary.


***Environment requirement***:
* MATLAB 2020b
* Gurobi v9.5.0
* yalmiptest




