#get the counts for each sample within each peak                                                                                                                                                           
export PEAKFILE=ctr.idr.optimal_set.sorted.merged.bed
export TAGALIGNF=ctr.tagAlign.files.txt
export numfiles=$(cat $TAGALIGNF | wc -l)

echo $numfiles
for i in $(seq 1 $numfiles)
do
    cur_sample_name=$(head -n $i $TAGALIGNF | tail -n1 | cut -f1)
    echo $cur_sample_name > counts.$cur_sample_name.txt
    cur_tagalign=$(head -n $i $TAGALIGNF | tail -n1 | cut -f2)
    echo "$cur_sample_name $cur_tagalign"
    sbatch -p akundaje,euan,normal,owners -o logs/$cur_sample_name.o -e logs/$cur_sample_name.e -J $cur_sample_name --mem=150G get_tagalign_coverage_over_merged_peak_file.sh $PEAKFILE $cur_tagalign $cur_sample_name 
done
