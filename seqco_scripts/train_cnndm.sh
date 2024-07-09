# --init-from-pretrained-doc-model \导入预训练模型进行微调
# --pretrained-doc-model-path=/data/xiehong/SeqCo/cnndm_bart/bart.large/model.pt \从https://github.com/facebookresearch/fairseq/tree/main/examples/bart下载预训练模型

# momentum-contrast-loss-ratio  使用生成摘要的解码器隐藏状态计算的相似性损失权重（LD_sim(Y, Ŷ)）
# byol-ratio   文档与模型生成摘要的相似性损失（LE_sim(X, Ŷ)）
# decoder-byol 金标准摘要与模型生成摘要的相似性损失（LE_sim(Y, Ŷ)）
# gold-gen-byol 文档与金标准摘要的相似性损失（LE_sim(X, Y)）
# symmetrical  是否对比损失对称
# cross-byol  是否启用对比损失

python train.py data/cnn_dm-bin \
    --max-sentences=1 \
    --task finetune_summarization \
    --save-dir=resutls/LE_sim_Y,Yhat/cnndm_models/ \
    --init-from-pretrained-doc-model \
    --pretrained-doc-model-path=/data/xiehong/SeqCo/cnndm_bart/bart.large/model.pt \
    --no-epoch-checkpoints \
    --source-lang article --target-lang summary \
    --layernorm-embedding \
    --share-all-embeddings \
    --share-decoder-input-output-embed \
    --share-encoders \
    --load-decoders \
    --lambda-parallel-config=1 \
    --lambda-denoising-config=0 \
    --lambda-otf-bt-config=0 \
    --momentum-contrast-loss-ratio=0 \
    --byol-ratio=0 \
    --decoder-byol=1 \
    --momentum-contrast-beta=0.99 \
    --parallel-byol-ratio=0 \
    --gold-gen-byol=0 \
    --symmetrical=True \
    --cross-byol=True \
    --pg-ratio=0 \
    --required-batch-size-multiple 1 \
    --arch backsum_transformer_bart_large \
    --criterion label_smoothed_cross_entropy \
    --label-smoothing 0.1 \
    --dropout 0.1 --attention-dropout 0.1 \
    --weight-decay 0.01 \
    --optimizer adam --adam-betas "(0.9, 0.999)" --adam-eps 1e-08 \
    --clip-norm 0.1 \
    --lr-scheduler polynomial_decay --lr 4e-05 --total-num-update 40000 --warmup-updates 2000 \
    --memory-efficient-fp16  --update-freq 4 \
    --skip-invalid-size-inputs-valid-test \
    --num-workers=0 \
    --find-unused-parameters \
    --ddp-backend=no_c10d \
    --log-interval=50 2>&1 | tee resutls/LE_sim_Y,Yhat/cnndm_models/log.txt
