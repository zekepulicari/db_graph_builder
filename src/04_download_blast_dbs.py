"""
This script uses the update_blastdb.pl from BLAST+ to download 
different BLAST databases (nt, refseq_rna, refseq_representative_genomes, 16S, etc).
The information can be used later by local_blast.py to run BLAST locally selecting 
the desired database using the -db flag.
"""

import subprocess
import argparse
from pathlib import Path


def list_available_dbs():
    """
    List all available BLAST databases from NCBI.
    """
    subprocess.run(["update_blastdb.pl", "--showall"], check=True)


def download_blast_db(db_name: str, outdir: str):
    """
    Download and decompress an NCBI BLAST database.
    """
    outdir = Path(outdir).expanduser().resolve()
    outdir.mkdir(parents= True, exist_ok= True)

    cmd = [
        "update_blastdb.pl",
        db_name,
        "--decompress",
        "-o", str(outdir)
    ]

    subprocess.run(cmd, check= True)
    print(f"Downloaded: {db_name}. Stored at {outdir}")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Download NCBI BLAST databases")
    parser.add_argument(
        "-d", "--db",
        help="Database name (e.g. nt, refseq_rna, 16S_ribosomal_RNA)"
    )
    parser.add_argument(
        "-o", "--outdir",
        default="./dbs",
        help="Output directory for databases (default: ./dbs)"
    )

    args = parser.parse_args()

    if args.db:
        download_blast_db(args.db, args.outdir)
    else:
        list_available_dbs()
