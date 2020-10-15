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
                list_alldir "$1/$file2" 
            else
		((total_cnt++))
                origin="$1/$file2"
		target=`basename $origin`
		echo "target:" $target
                flv_file=${target##*.}
	        file_name=${target%.*}
                if [ $flv_file == "flv" ]; then
		    echo "remove $origin"
                    rm -r $origin
		    ((flv_cnt++))
	    	else
                    echo $"$1/$file2" "not flv file, ignored!"
                fi
            fi
        fi
    done

    echo "Count: flv files=$flv_cnt total_files=$total_cnt"
}

echo "Remove all flv files"
list_alldir ${srcdir}
