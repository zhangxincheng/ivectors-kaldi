#!/bin/bash

. ./cmd.sh
. ./path.sh
. utils/parse_options.sh



if [ -d data/test ] ; then
	rm -r data/test
fi

prepare_data.sh /wmh/tools/4.Diarization   data/test

if [ -d mfcc_hires ] ; then
	rm -r mfcc_hires  exp/log
fi

steps/make_mfcc.sh --mfcc-config conf/mfcc_hires.conf --cmd "$train_cmd" --nj 1 data/test exp/log mfcc_hires || exit 1;

utils/fix_data_dir.sh data/test



