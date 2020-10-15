#!/bin/bash                             


srcdir=$1
flv_cnt=0
total_cnt=0
predir=
list_alldir(){  
    for file2 in `ls -a $1`
    do  
        if [ x"$file2" != x"." -a x"$file2" != x".." ];then  
            if [ -d "$1/$file2" ];then
		predir=$file2
                list_alldir "$1/$file2" 
            else
		((total_cnt++))
                origin="$1/$file2"
		target=`basename $origin`
		echo "target:" $target
                flv_file=${target##*.}
	        file_name=${target%.*}
                if [ $flv_file == "flv" ]; then
                    if [  $cpdstdir ];then
			if [ ! -d "$cpdstdir/$predir" ];then
			    mkdir "$cpdstdir/$predir"
			fi
		        echo "copy $origin to $cpdstdir/$predir"
                        cp -r $origin  $cpdstdir/$predir 
		     else
                         echo "convert $origin to $cnvsrcdir/$predir/$file_name.mp4 with H264 encoded"
                         ./ffmpeg_with264 -i $origin -vf scale=800:600 -c:v libx264 $cnvsrcdir/$predir/${file_name}_800x600.mp4
                         ./ffmpeg_with264 -i $origin  -c:v libx264 $cnvsrcdir/$predir/${file_name}_3200x2400.mp4
		     fi
		    ((flv_cnt++))
	    	else
                    echo $"$1/$file2" "not flv file, ignored!"
                fi
            fi
        fi
    done

    echo "Count: flv files=$flv_cnt total_files=$total_cnt"
}

#create a new dir
mkdir levis_h264_mp4
cpdstdir=levis_h264_mp4

echo "Duplicate all flv files to $$cpdstdir"
list_alldir ${srcdir}
ls -a $cpdstdir

echo "Convert all flv files to MP4 with h264 encoded"
cnvsrcdir=$cpdstdir
cpdstdir=
flv_cnt=0
total_cnt=0
list_alldir $cnvsrcdir
