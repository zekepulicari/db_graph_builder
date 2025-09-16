import subprocess
import argparse

def run_blast(input_fasta, db, output_file, evalue=1e-5, max_target_seqs=5, num_threads=6):
    """
    Run BLASTn on a fasta file against a given database.
    """
    cmd = [
        "blastn",
        "-query", input_fasta,
        "-db", db,
        "-out", output_file,
        "-outfmt", "6 qseqid sseqid pident length evalue bitscore staxids sscinames sblastnames",
        "-evalue", str(evalue),
        "-max_target_seqs", str(max_target_seqs),
        "-num_threads", str(num_threads)
    ]

    subprocess.run(cmd, check=True)
    print(f"BLAST finished. Results saved in {output_file}")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Run a blastn algotithm for taxonomy assignment")
    parser.add_argument("-i", "--input", required= True, help= "Input .fa file")
    parser.add_argument("-d", "--db", required= True, help= "BLAST database path")
    parser.add_argument("-o", "--output", required= True, help= "Output file")
    parser.add_argument("-e", "--evalue", default=1e-5, type=float, help="evalue threshold")
    parser.add_argument("-m", "--max_target_seqs", default=1, type=int, help="Number of max target sequences")
    parser.add_argument("-t", "--threads", default=4, type=int, help="Threads")

    args = parser.parse_args()

    run_blast(args.input, args.db, args.output, args.evalue, args.max_target_seqs, args.threads)
