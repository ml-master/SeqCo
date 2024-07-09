

This is an implementation of the SeqCo (**Seq**uence Level **Co**ntrastive Learning for Text Summarization) model described in [Sequence Level Contrastive Learning for Text Summarization](https://www.aaai.org/AAAI22Papers/AAAI-7314.XuS.pdf) (In AAAI 2022)

#### 环境配置

```
pip install requirements.txt

# For rouge-1.5.5.pl
sudo apt-get update
sudo apt-get install expat
sudo apt-get install libexpat-dev -y

# For files2fouge
git clone https://github.com/pltrdy/files2rouge.git
cd files2rouge
python setup_rouge.py
python setup.py install
```

#### 数据集处理和预训练模型下载

1. 从 [https://github.com/facebookresearch/fairseq/tree/main/examples/bart](https://github.com/facebookresearch/fairseq/tree/main/examples/bart)  上下载bart.large.pt 到目录cnndm_bart/bart.large/ 下；

2. 从[Stanford CoreNLP](https://stanfordnlp.github.io/CoreNLP/)下载Stanford CoreNLP，然后然后执行：

   ```
   export CLASSPATH=/path/to/stanford-corenlp-full-2016-10-31/stanford-corenlp-3.7.0.jar
   ```

3. 运行`cnn-dailymail/gossip2cnndm.py`和`cnn-dailymail/make_datafiles.py`处理gossipcop_v3-7_integration_based_legitimate_tn300.json数据集；

4. 运行`sh seqco_scripts/bpe_preprocess.sh`. 
    在 `seqco_scripts/bpe_preprocess.sh`中, 需要更改`--inputs`为你存储`test.source` and `test.target`的路径；

5. 最后执行`sh seqco_scripts/binarize.sh`

#### 更改`seqco_scripts/train_cnndm.sh`中的参数配置然后执行

`sh seqco_scripts/train_cnndm.sh`

#### 生成摘要

`sh seqco_scripts/infer_cnndm.sh`

#### 评估

`sh seqco_scripts/evaluate_sum.sh `

#### 实验结果

每个实验的loss迭代保存在resutls/.../cnndm_models/log.txt中，评估结果在picture中

![](picture/result.png)

### Citation

```
@article{xu2021sequence,
  title={Sequence Level Contrastive Learning for Text Summarization},
  author={Xu, Shusheng and Zhang, Xingxing and Wu, Yi and Wei, Furu},
  journal={arXiv preprint arXiv:2109.03481},
  year={2021}
}
```
