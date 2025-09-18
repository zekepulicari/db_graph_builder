# db_graph_builder
This repository is dedicated to the documentation and collection of scripts for building connection graphs for databases and empirical data.

## Requirements
- Anaconda Distribution: to install Python and R dependencies
- Cytoscape: to build graphs

### Install environment
`conda create -n graph_env -c conda-forge -c anaconda -c bioconda  notebook pandas numpy matplotlib seaborn scikit-posthocs scikit-learn ipykernel statsmodels r-base samtools entrez-direct blast`

#### Add the conda environment as a kernel
`python -m ipykernel install --user --name graph_env --display-name "Python (graph_env)"`

### Install Cytoscape
You can download Cytoscape [here](https://cytoscape.org/download.html).

## Inputs
This project use three main sources of information:
- NCBI Database: 16S_ribosomal_RNA (in this case)
- MiDAS Database
- BIOSPAS Consortium Data

### To obtain the NCBI Database, run:
Please use `python download_blast_dbs.py` to see the available NCBI databases. Then, to download the desired database, run `python src/download_blast_dbs.py -d 16S_ribosomal_RNA` and will stored it in `db_graph_builder/src/dbs` by default.

### To obtain the MiDAS Database
Use `wget https://www.midasfieldguide.org/files/downloads/taxonomies/QIIME.txt%20MiDAS%205.3.txt` to obtain the Taxonomy information of MiDAS.

## Steps
1. Download the MiDAS Database and BLAST 16S database.
2. Use `01_merging_dfs.R` to complete the `todas.final.an.0.03.rep.subsample.an.T` using the information from MiDAS.
3. Complete the _unclassified_ species using the FASTA files in the input folder and running `local_blast.py`. **I prepared the final dataframe adding the other variables in the ./input folder: `FQ_enzim_agras_hong_func_CLASIF`.**
4. Run `02_corr_analysis.R` using the `./inputs/FQ_enzim_agras_hong_func_CLASIF` file to obtain the different correlation values. **I also prepared the outputs and they are named like this `FQ_enzim_agras_hong_func_CLASIF_{treatment_name}(Filtro_0,7)`.**
5. Use Cytoscape to build the graphs using the co-ocurrence information.
6. Download topological features using Cytoscape and analyze the data using the Jupyter `06_topological_analysis.ipynb` (the interpretation of the results are stored inside the .ipynb files). 

### Now, we can go after our objective using the Cytoscape tool: Identify patterns through co-occurrence graphs to determine the effect of agricultural practices on the interactions between soil microorganisms 
<img width="1270" height="1287" alt="image" src="https://github.com/user-attachments/assets/80530fba-5bd4-4fc5-be3d-803c96426c1d" />

#### Cytoscape provides information about topological features of the graphs. You can download that information and run the statistical tests using the `06_topological_analysis.ipynb` script. **I prepared three topological outputs and they are saved in the `outputs/` folder.**

| Feature                   | Test            | Statistic | p-value  |
|----------------------------|----------------|-----------|----------|
| Neighborhood Connectivity  | Kruskal–Wallis | 1.300022  | 0.522040 |
| Closeness Centrality       | Kruskal–Wallis | 15.735507 | 0.000383 |
| Clustering Coefficient     | Kruskal–Wallis | 6.551141  | 0.037795 |

We compared the distribution of three network topological metrics across treatments (AN, BP, MP). To determine if treatments showed significant differences, we first checked normality and variance homogeneity. Since assumptions were not fully met, we used the Kruskal–Wallis test (non-parametric alternative to ANOVA). Interpretation of the results are saved in the `06_topological_analysis.ipynb` Jupyter Notebook. 
