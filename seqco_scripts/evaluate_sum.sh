export CLASSPATH=/data/xiehong/SeqCo/stanford-corenlp-4.5.7/stanford-corenlp-4.5.7.jar

base_dir=/data/xiehong/SeqCo/resutls/LE_sim_Y,Yhat/cnndm_models/55.140.4.2/
checkpoint='_best'

cat data/cnn_dm/test.target | java edu.stanford.nlp.process.PTBTokenizer -ioFileList -preserveLines > $base_dir/test.target.tokenized
cat $base_dir/test.$checkpoint.hypo | java edu.stanford.nlp.process.PTBTokenizer -ioFileList -preserveLines > $base_dir/test.$checkpoint.tokenized

files2rouge $base_dir/test.$checkpoint.tokenized $base_dir/test.target.tokenized -s $base_dir/test.$checkpoint.rouge --ignore_empty_reference