#!/bin/bash


if [ $# != 2 ]; then
  echo "Usage: $0 <audio-path> <out-dir>"
  echo " $0 wav transcript data/test"
  exit 1;
fi

audio_dir=$1
tmp_dir=$2

# data directory check
if [ ! -d $audio_dir ]; then
  echo "Error: $0 requires one directory arguments"
  exit 1;
fi

if [ -d $tmp_dir ]; then
  rm -r $tmp_dir
fi
mkdir -p $tmp_dir

# find wav audio file 
find $audio_dir -iname "*.wav" > $tmp_dir/wav.list


# Transcriptions preparation
echo Preparing $tmp_dir 

sed -e 's/.*\///g' -e 's/\.wav//g'  $tmp_dir/wav.list | \
  awk  '{printf("%s\t%s\n",$0,$0)}' |sort -u > $tmp_dir/utt2spk
cp $tmp_dir/utt2spk $tmp_dir/spk2utt
awk -F\\t '{print $1}' $tmp_dir/spk2utt > $tmp_dir/utt.list
paste $tmp_dir/utt.list $tmp_dir/wav.list > $tmp_dir/wav.scp
echo " data preparation succeeded"
exit 0;
