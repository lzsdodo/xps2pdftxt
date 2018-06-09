#!/bin/bash

src_dir=$1

if [ "$#" -ne "1" ]; then
    echo "Error args num: $#."
    exit 2
fi

out_dir="./output"

done_dir="$out_dir/done_xps"
err_dir="$out_dir/err_xps"
pdf_dir="$out_dir/pdf"
txt_dir="$out_dir/txt"

done_xps2pdf_log="$out_dir/done_xps2pdf.log"
err_xps2pdf_log="$out_dir/err_xps2pdf.log"
done_pdf2txt_log="$out_dir/done_pdf2txt.log"
err_pdf2txt_log="$out_dir/err_pdf2txt.log"

if [ -d $src_dir ]; then

    echo "Folder $src_dir exists."
    cd $src_dir

    if [ -d "$out_dir" ]; then
        mv "$out_dir" "$outdir_$(date +%H:%M:%S)"
        mkdir -p "$out_dir"
    else
        mkdir -p "$out_dir"
    fi

    mkdir -p "$done_dir"
    mkdir -p "$pdf_dir"
    mkdir -p "$txt_dir"
    mkdir -p "$err_dir"

    touch "$done_xps2pdf_log"
    touch "$done_pdf2txt_log"
    touch "$err_xps2pdf_log"
    touch "$err_pdf2txt_log"

    echo "Start converting xps files......"
    for f in *
    do
      case "$f" in
        *.xps)
            fname="${f%.xps*}"
            echo "Converting $fname..."

            xpstopdf "$f" "$pdf_dir/$fname.pdf" || echo "Error xps to pdf..."

            if [ -f "$pdf_dir/$fname.pdf" ]; then
                echo "$f" >> "$done_xps2pdf_log"
                cp "$f" "$done_dir"

                textract "$pdf_dir/$fname.pdf" >> "$txt_dir/$fname.txt"

                if [ -f "$txt_dir/$fname.txt" ]; then
                    echo "$fname.pdf" >> "$done_pdf2txt_log"
                else
                    echo "$fname.pdf" >> "$err_pdf2txt_log" 
                fi

            else
                echo "$f" >> "$err_xps2pdf_log"
                cp "$fname.xps" "$err_dir"
            fi
            ;;
        *)  ;;
      esac
    done

else
    echo "Folder \"$src_dir\" not exists."
    echo "Create folder xps for you..."
    echo "Please copy all *.xps files to this folder."
    echo "Then run this script again."
    echo -e "\n    mv /your/path/*.xps ./xps/"
    echo -e "    bash run.sh ./xps/\n"
    mkdir -p ./xps

fi
