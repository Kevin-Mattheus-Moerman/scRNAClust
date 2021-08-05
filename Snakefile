import os

DATA_DIRECTORY = config['DIRECTORIES']['DATA_DIRECTORY']
OUTDIR = config['DIRECTORIES']['OUTPUT_DIR']
PREPROCESS_DIR = config['DIRECTORIES']['PREPROCESS_DIRECTORY']
LOG_DIR = os.path.join(OUTDIR, 'log')

# rule preprocess_cef_conv:
#     output:
#         os.path.join(PREPROCESS_DIR,'ceftype_{}.cef'.format(config['DATA_NAME']))

#     shell:
#         'Rscript {config[SOFTWARE][PREPROCESS_CEF_CONVERT]} ' 
#         '--data_output_directory {config[DIRECTORIES][PREPROCESS_DIRECTORY]} '
#         '--console_output_directory {config[LOG][PREPROCESS_LOG]}/cef_conv.out '
#         '--input_directory {config[DIRECTORIES][DATA_DIRECTORY]} ' 
#         '--name_dataset {config[DATA_NAME]}'

rule preprocess_data:
    output:
        os.path.join(PREPROCESS_DIR,'{}_pre.csv'.format(config['DATA_NAME']))

    shell:
        'Rscript {config[SOFTWARE][PREPROCESS_DATA]} ' 
        '--data_output_directory {config[DIRECTORIES][PREPROCESS_DIRECTORY]} '
        '--console_output_directory {config[LOG][PREPROCESS_LOG]}/cef_conv.out '
        '--input_directory {config[DIRECTORIES][DATA_DIRECTORY]} ' 
        '--name_dataset {config[DATA_NAME]}'


    # Removed seed from the Rscript    
    # '--seed {config[PARAMS][GENERATE_SYNTHETIC][seed]} '

# rule euclidean_clust:
#     input:
#         meth_file=os.path.join(DATA_DIRECTORY, 'data/data_incomplete.tsv.gz'),
#         regions_file=os.path.join(DATA_DIRECTORY, 'data/regions_file.tsv.gz')
#     output:
#         os.path.join(NPM_DIRECTORY, 'EuclideanClust_clusters_region_based_maxk_{}.tsv.gz'.format(config['PARAMS']['NPM']['max_k'])),
#         os.path.join(NPM_DIRECTORY, 'EuclideanClust_cell_order_region_based_maxk_{}.tsv.gz'.format(config['PARAMS']['NPM']['max_k']))
#     resources:
#         h_vmem=default_mem
#     params:
#         qsub_out=os.path.join(LOG_DIR, 'euclidean_qsub_out'),
#         qsub_err=os.path.join(LOG_DIR, 'euclidean_qsub_err')
#     shell:
#         'Rscript {config[SOFTWARE][hclust_software]} '
#         '--method euclidean '
#         '--index {config[PARAMS][NPM][index]} '
#         '--max_k {config[PARAMS][NPM][max_k]} '
#         '--output_directory {NPM_DIRECTORY} '
#         '--methylation_file {input.meth_file} '
#         '--regions_file {input.regions_file} '
#         '--impute {config[PARAMS][NPM][impute]} '
#         '--use_cache {config[PARAMS][NPM][use_cache]}'

# rule hamming_clust:
#     input:
#         meth_file=os.path.join(DATA_DIRECTORY, 'data/data_incomplete.tsv.gz'),
#         regions_file=os.path.join(DATA_DIRECTORY, 'data/regions_file.tsv.gz')
#     output:
#         os.path.join(NPM_DIRECTORY, 'HammingClust_clusters_CpG_based_maxk_{}.tsv.gz'.format(config['PARAMS']['NPM']['max_k'])),
#         os.path.join(NPM_DIRECTORY, 'HammingClust_cell_order_CpG_based_maxk_{}.tsv.gz'.format(config['PARAMS']['NPM']['max_k']))
#     resources:
#         h_vmem=default_mem
#     params:
#         qsub_out=os.path.join(LOG_DIR, 'hamming_qsub_out'),
#         qsub_err=os.path.join(LOG_DIR, 'hamming_qsub_err')
#     shell:
#         'Rscript {config[SOFTWARE][hclust_software]} '
#         '--method hamming '
#         '--index {config[PARAMS][NPM][index]} '
#         '--max_k {config[PARAMS][NPM][max_k]} '
#         '--output_directory {NPM_DIRECTORY} '
#         '--methylation_file {input.meth_file} '
#         '--regions_file {input.regions_file} '
#         '--impute {config[PARAMS][NPM][impute]} '
#         '--use_cache {config[PARAMS][NPM][use_cache]}'

# rule pearson_clust:
#     input:
#         meth_file=os.path.join(DATA_DIRECTORY, 'data/data_incomplete.tsv.gz'),
#         regions_file=os.path.join(DATA_DIRECTORY, 'data/regions_file.tsv.gz')
#     output:
#         os.path.join(NPM_DIRECTORY, 'PearsonClust_clusters_CpG_based_maxk_{}.tsv.gz'.format(config['PARAMS']['NPM']['max_k'])),
#         os.path.join(NPM_DIRECTORY, 'PearsonClust_cell_order_CpG_based_maxk_{}.tsv.gz'.format(config['PARAMS']['NPM']['max_k']))
#     resources:
#         h_vmem=default_mem
#     params:
#         qsub_out=os.path.join(LOG_DIR, 'pearson_qsub_out'),
#         qsub_err=os.path.join(LOG_DIR, 'pearson_qsub_err')
#     shell:
#         'Rscript {config[SOFTWARE][hclust_software]} '
#         '--method pearson '
#         '--index {config[PARAMS][NPM][index]} '
#         '--max_k {config[PARAMS][NPM][max_k]} '
#         '--output_directory {NPM_DIRECTORY} '
#         '--methylation_file {input.meth_file} '
#         '--regions_file {input.regions_file} '
#         '--impute {config[PARAMS][NPM][impute]} '
#         '--use_cache {config[PARAMS][NPM][use_cache]}'

# rule density_cut:
#     input:
#         meth_file=os.path.join(DATA_DIRECTORY, 'data/data_incomplete.tsv.gz'),
#         regions_file=os.path.join(DATA_DIRECTORY, 'data/regions_file.tsv.gz')
#     output:
#         os.path.join(NPM_DIRECTORY, 'DensityCut_clusters_Region_based_maxPC_{}.tsv.gz'.format(config['PARAMS']['NPM']['max_k']))
#     resources:
#         h_vmem=default_mem
#     params:
#         qsub_out=os.path.join(LOG_DIR, 'densitycut_qsub_out'),
#         qsub_err=os.path.join(LOG_DIR, 'densitycut_qsub_err')
#     shell:
#         'Rscript {config[SOFTWARE][hclust_software]} '
#         '--method densitycut '
#         '--max_k {config[PARAMS][NPM][max_k]} '
#         '--output_directory {NPM_DIRECTORY} '
#         '--methylation_file {input.meth_file} '
#         '--regions_file {input.regions_file} '
#         '--impute {config[PARAMS][NPM][impute]} '
#         '--use_cache {config[PARAMS][NPM][use_cache]}'

# rule process_npm_methods:
#     input:
#         hfile=os.path.join(NPM_DIRECTORY, 'EuclideanClust_clusters_region_based_maxk_{}.tsv.gz'.format(config['PARAMS']['NPM']['max_k'])),
#         pfile=os.path.join(NPM_DIRECTORY, 'HammingClust_clusters_CpG_based_maxk_{}.tsv.gz'.format(config['PARAMS']['NPM']['max_k'])),
#         peafile=os.path.join(NPM_DIRECTORY, 'PearsonClust_clusters_CpG_based_maxk_{}.tsv.gz'.format(config['PARAMS']['NPM']['max_k'])),
#         dfile=os.path.join(NPM_DIRECTORY, 'DensityCut_clusters_Region_based_maxPC_{}.tsv.gz'.format(config['PARAMS']['NPM']['max_k']))
#     output:
#         htempfile=temp(os.path.join(NPM_DIRECTORY, 'htempfile')),
#         ptempfile=temp(os.path.join(NPM_DIRECTORY, 'ptempfile')),
#         peatempfile=temp(os.path.join(NPM_DIRECTORY, 'peatempfile')),
#         dtempfile=temp(os.path.join(NPM_DIRECTORY, 'dtempfile')),
#         idtempfile=temp(os.path.join(NPM_DIRECTORY, 'idtempfile'))
#     resources:
#         h_vmem=default_mem
#     params:
#         k_1=config['PARAMS']['NPM']['max_k']+1,
#         qsub_out=os.path.join(LOG_DIR, 'process_npm_qsub_out'),
#         qsub_err=os.path.join(LOG_DIR, 'process_npm_qsub_err')
#     shell:
#         'gunzip -c {input.hfile} | cut -f1 > {output.idtempfile}; '
#         'gunzip -c {input.hfile} | cut -f2-{params.k_1} > {output.htempfile}; '
#         'gunzip -c {input.pfile} | cut -f2-{params.k_1} > {output.ptempfile}; '
#         'gunzip -c {input.peafile} | cut -f2-{params.k_1} > {output.peatempfile}; '
#         'gunzip -c {input.dfile} | cut -f2 > {output.dtempfile}; '

# rule join_npm_methods:
#     input:
#         htempfile=os.path.join(NPM_DIRECTORY, 'htempfile'),
#         ptempfile=os.path.join(NPM_DIRECTORY, 'ptempfile'),
#         peatempfile=os.path.join(NPM_DIRECTORY, 'peatempfile'),
#         dtempfile=os.path.join(NPM_DIRECTORY, 'dtempfile'),
#         idtempfile=os.path.join(NPM_DIRECTORY, 'idtempfile')
#     output:
#         os.path.join(NPM_DIRECTORY, 'initial_inputs.tsv.gz')
#     resources:
#         h_vmem=default_mem
#     params:
#         qsub_out=os.path.join(LOG_DIR, 'join_npm_qsub_out'),
#         qsub_err=os.path.join(LOG_DIR, 'join_npm_qsub_err')
#     shell:
#         'paste {input.idtempfile} {input.htempfile} {input.ptempfile} {input.peatempfile} {input.dtempfile} | gzip -c - > {output}'

# rule euclidean_eval:
#     input:
#         true_clusters_file=os.path.join(DATA_DIRECTORY, 'data/true_clone_membership.tsv.gz'),
#         hfile=os.path.join(NPM_DIRECTORY, 'EuclideanClust_clusters_region_based_maxk_{}.tsv.gz'.format(config['PARAMS']['NPM']['max_k']))
#     output:
#         os.path.join(NPM_DIRECTORY, "results_EuclideanClust.txt")
#     resources:
#         h_vmem=default_mem
#     params:
#         qsub_out=os.path.join(LOG_DIR, 'euclidean_eval_qsub_out'),
#         qsub_err=os.path.join(LOG_DIR, 'euclidean_eval_qsub_err')
#     shell:
#         'evaluate_clustering '
#         '--true_clusters_file {input.true_clusters_file} '
#         '--true_prevalences {config[PARAMS][ALL][prevalences]} '
#         '--predicted_clusters_file {input.hfile} '
#         '--clusters_are_probabilities False '
#         '--results_file {output}'

# rule hamming_eval:
#     input:
#         true_clusters_file=os.path.join(DATA_DIRECTORY, 'data/true_clone_membership.tsv.gz'),
#         pfile=os.path.join(NPM_DIRECTORY, 'HammingClust_clusters_CpG_based_maxk_{}.tsv.gz'.format(config['PARAMS']['NPM']['max_k']))
#     output:
#         os.path.join(NPM_DIRECTORY, "results_HammingClust.txt")
#     resources:
#         h_vmem=default_mem
#     params:
#         qsub_out=os.path.join(LOG_DIR, 'hamming_eval_qsub_out'),
#         qsub_err=os.path.join(LOG_DIR, 'hamming_eval_qsub_err')
#     shell:
#         'evaluate_clustering '
#         '--true_clusters_file {input.true_clusters_file} '
#         '--true_prevalences {config[PARAMS][ALL][prevalences]} '
#         '--predicted_clusters_file {input.pfile} '
#         '--clusters_are_probabilities False '
#         '--results_file {output}'

# rule pearson_eval:
#     input:
#         true_clusters_file=os.path.join(DATA_DIRECTORY, 'data/true_clone_membership.tsv.gz'),
#         peafile=os.path.join(NPM_DIRECTORY, 'PearsonClust_clusters_CpG_based_maxk_{}.tsv.gz'.format(config['PARAMS']['NPM']['max_k']))
#     output:
#         os.path.join(NPM_DIRECTORY, "results_PearsonClust.txt")
#     resources:
#         h_vmem=default_mem
#     params:
#         qsub_out=os.path.join(LOG_DIR, 'pearson_eval_qsub_out'),
#         qsub_err=os.path.join(LOG_DIR, 'pearson_eval_qsub_err')
#     shell:
#         'evaluate_clustering '
#         '--true_clusters_file {input.true_clusters_file} '
#         '--true_prevalences {config[PARAMS][ALL][prevalences]} '
#         '--predicted_clusters_file {input.peafile} '
#         '--clusters_are_probabilities False '
#         '--results_file {output}'

# rule densitycut_eval:
#     input:
#         true_clusters_file=os.path.join(DATA_DIRECTORY, 'data/true_clone_membership.tsv.gz'),
#         dfile=os.path.join(NPM_DIRECTORY, 'DensityCut_clusters_Region_based_maxPC_{}.tsv.gz'.format(config['PARAMS']['NPM']['max_k']))
#     output:
#         os.path.join(NPM_DIRECTORY, "results_DensityCut.txt")
#     resources:
#         h_vmem=default_mem
#     params:
#         qsub_out=os.path.join(LOG_DIR, 'densitycut_eval_qsub_out'),
#         qsub_err=os.path.join(LOG_DIR, 'densitycut_eval_qsub_err')
#     shell:
#         'evaluate_clustering '
#         '--true_clusters_file {input.true_clusters_file} '
#         '--true_prevalences {config[PARAMS][ALL][prevalences]} '
#         '--predicted_clusters_file {input.dfile} '
#         '--clusters_are_probabilities False '
#         '--results_file {output}'

# rule epiclomal_basic:
#     input:
#         true_clusters_file=os.path.join(DATA_DIRECTORY, 'data/true_clone_membership.tsv.gz'),
#         meth_file=os.path.join(DATA_DIRECTORY, 'data/data_incomplete.tsv.gz'),
#         initial_clusters_file=os.path.join(NPM_DIRECTORY, 'initial_inputs.tsv.gz')
#     output:
#         directory(os.path.join(EPI_BASIC_DIR, '{run}'))
#     resources:
#         h_vmem=high_mem
#     params:
#         qsub_out=os.path.join(LOG_DIR, 'epi_basic_{run}_qsub_out'),
#         qsub_err=os.path.join(LOG_DIR, 'epi_basic_{run}_qsub_err')
#     shell:
#         '(echo "==================================="; '
#         'echo "Running EpiclomalBasic RUN {wildcards.run}"; '
#         'echo "==================================="; '
#         'epiclomal Basic-GeMM '
#         '--out_dir {output} '
#         '--repeat_id {wildcards.run} '
#         '--K {config[PARAMS][EPICLOMAL][K]} '
#         '--mu_has_k {config[PARAMS][EPICLOMAL][mu_has_k]} '
#         '--true_prevalences {config[PARAMS][ALL][prevalences]} '
#         '--config_file {config[PARAMS][EPICLOMAL][config_file]} '
#         '--true_clusters_file {input.true_clusters_file} '
#         '--methylation_file {input.meth_file} '
#         '--initial_clusters_file {input.initial_clusters_file})'

# rule epiclomal_region:
#     input:
#         true_clusters_file=os.path.join(DATA_DIRECTORY, 'data/true_clone_membership.tsv.gz'),
#         meth_file=os.path.join(DATA_DIRECTORY, 'data/data_incomplete.tsv.gz'),
#         initial_clusters_file=os.path.join(NPM_DIRECTORY, 'initial_inputs.tsv.gz'),
#         regions_file=os.path.join(DATA_DIRECTORY, 'data/regions_file.tsv.gz'),
#         slsbulk_file=os.path.join(DATA_DIRECTORY, 'data/bulk_data_sample_1.tsv.gz')
#     output:
#         directory(os.path.join(EPI_REGION_DIR, '{run}'))
#     resources:
#         h_vmem=high_mem
#     params:
#         qsub_out=os.path.join(LOG_DIR, 'epi_region_{run}_qsub_out'),
#         qsub_err=os.path.join(LOG_DIR, 'epi_region_{run}_qsub_err')
#     shell:
#         '(echo "==================================="; '
#         'echo "Running EpiclomalRegion RUN {wildcards.run}"; '
#         'echo "==================================="; '
#         'epiclomal Region-GeMM '
#         '--out_dir {output} '
#         '--repeat_id {wildcards.run} '
#         '--K {config[PARAMS][EPICLOMAL][K]} '
#         '--mu_has_k {config[PARAMS][EPICLOMAL][mu_has_k]} '
#         '--true_prevalences {config[PARAMS][ALL][prevalences]} '
#         '--config_file {config[PARAMS][EPICLOMAL][config_file]} '
#         '--true_clusters_file {input.true_clusters_file} '
#         '--methylation_file {input.meth_file} '
#         '--initial_clusters_file {input.initial_clusters_file} '
#         '--regions_file {input.regions_file} '
#         '--slsbulk_iterations {config[PARAMS][EPICLOMAL][slsbulk_iterations]} '
#         '--slsbulk_file {input.slsbulk_file} '
#         '--check_uncertainty {config[PARAMS][EPICLOMAL][check_uncertainty]})'

# rule eval_basic:
#     input:
#         regions_file=os.path.join(DATA_DIRECTORY, 'data/regions_file.tsv.gz'),
#         true_clusters_file=os.path.join(DATA_DIRECTORY, 'data/true_clone_membership.tsv.gz'),
#         true_epigenotypes_file=os.path.join(DATA_DIRECTORY, 'data/true_clone_epigenotypes.tsv.gz'),
#         meth_file=os.path.join(DATA_DIRECTORY, 'data/data_incomplete.tsv.gz'),
#         dependency=expand(os.path.join(EPI_BASIC_DIR, '{run}'), run=run)
#     output:
#         directory(EVAL_BASIC_DIR)
#     resources:
#         h_vmem=default_mem
#     params:
#         qsub_out=os.path.join(LOG_DIR, 'eval_basic_qsub_out'),
#         qsub_err=os.path.join(LOG_DIR, 'eval_basic_qsub_err')
#     shell:
#         'Rscript {config[SOFTWARE][eval_software]} '
#         '--output_dir {output} '
#         '--input_dir {EPI_BASIC_DIR} '
#         '--true_clusters_file {input.true_clusters_file} '
#         '--true_epigenotypes_file {input.true_epigenotypes_file} '
#         '--methylation_file {input.meth_file} '
#         '--regions_file {input.regions_file} '
#         '--model_name basic'

# rule eval_region:
#     input:
#         regions_file=os.path.join(DATA_DIRECTORY, 'data/regions_file.tsv.gz'),
#         true_clusters_file=os.path.join(DATA_DIRECTORY, 'data/true_clone_membership.tsv.gz'),
#         true_epigenotypes_file=os.path.join(DATA_DIRECTORY, 'data/true_clone_epigenotypes.tsv.gz'),
#         meth_file=os.path.join(DATA_DIRECTORY, 'data/data_incomplete.tsv.gz'),
#         dependency=expand(os.path.join(EPI_REGION_DIR, '{run}'), run=run)
#     output:
#         directory(EVAL_REGION_DIR)
#     resources:
#         h_vmem=default_mem
#     params:
#         qsub_out=os.path.join(LOG_DIR, 'eval_region_qsub_out'),
#         qsub_err=os.path.join(LOG_DIR, 'eval_region_qsub_err')
#     shell:
#         'Rscript {config[SOFTWARE][eval_software]} '
#         '--output_dir {output} '
#         '--input_dir {EPI_REGION_DIR} '
#         '--true_clusters_file {input.true_clusters_file} '
#         '--true_epigenotypes_file {input.true_epigenotypes_file} '
#         '--methylation_file {input.meth_file} '
#         '--regions_file {input.regions_file} '
#         '--model_name region'