#!/usr/bin/env nextflow

/*
 * Defines the pipeline inputs parameters (giving a default value for each for them) 
 * Each of the following parameters can be specified as command line options
 */
fastq_r1 = "s3://1000genomes/phase3/data/HG00243/sequence_read/SRR099964_1.filt.fastq.gz"
fastq_r2 = "s3://1000genomes/phase3/data/HG00243/sequence_read/SRR099964_2.filt.fastq.gz"
fasta = "s3://broad-references/hg38/v0/Homo_sapiens_assembly38.fasta"
fai = "s3://broad-references/hg38/v0/Homo_sapiens_assembly38.fasta.fai"
bwaIndexes = ["s3://broad-references/hg38/v0/Homo_sapiens_assembly38.fasta.64.amb", "s3://broad-references/hg38/v0/Homo_sapiens_assembly38.fasta.64.ann", "s3://broad-references/hg38/v0/Homo_sapiens_assembly38.fasta.64.bwt", "s3://broad-references/hg38/v0/Homo_sapiens_assembly38.fasta.64.pac", "s3://broad-references/hg38/v0/Homo_sapiens_assembly38.fasta.64.sa", "s3://broad-references/hg38/v0/Homo_sapiens_assembly38.fasta.amb", "s3://broad-references/hg38/v0/Homo_sapiens_assembly38.fasta.ann", "s3://broad-references/hg38/v0/Homo_sapiens_assembly38.fasta.bwt", "s3://broad-references/hg38/v0/Homo_sapiens_assembly38.fasta.pac", "s3://broad-references/hg38/v0/Homo_sapiens_assembly38.fasta.sa"]
chromosomes = Channel.from("chr19", "chr20", "chr21", "chr22")


process BwaMap {
    // directives
    // a container images is required
    container "776722213159.dkr.ecr.sa-east-1.amazonaws.com/bwa"

    // compute resources for the Batch Job
    cpus 8
    memory '8 GB'

    input:
    file fastq_r1, file fastq_r2, file fasta, file bwaIndexes


    output:
    """
    bwa mem -t 8 -p $fasta $fastq_r1 $fastq_r2 -o teste.sam
    """
}
