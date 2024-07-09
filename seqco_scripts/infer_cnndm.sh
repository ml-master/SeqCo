modeldir=./resutls/LE_sim_Y,Yhat/cnndm_models/
checkpoint=_best

datadir=data/cnn_dm-bin
raw_test=data/cnn_dm/test
raw_valid=data/cnn_dm/val
# *.summary is identical to *.target, *.article is identical to *.source

min_len=55
max_len=140
beam=4
lenpen=2
outputdir=./resutls/LE_sim_Y,Yhat/cnndm_models/$min_len.$max_len.$beam.$lenpen
source=article
target=summary

mkdir -vp $outputdir

python inference_for_summarization.py \
	--data-path=$datadir \
	--raw-test=$raw_test \
	--raw-valid=$raw_valid \
	--output-dir=$outputdir \
	--model-dir=$modeldir \
	--source=$source \
	--target=$target \
	--max-gene-length=140 \
	--min-len=55 \
	--lenpen=2 \
	--beam=$beam \
	--checkpoint=$checkpoint
