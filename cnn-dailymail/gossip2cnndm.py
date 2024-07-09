import json
import os

def process_text(text):
    sentences = text.split('. ')
    processed_text = '.\n\n'.join(sentences)
    if not processed_text.endswith('.'):
        processed_text += '.'
    return processed_text

def process_generated_text(text):
    sentences = text.split('. ')
    processed_sentences = [f"@highlight\n\n{sentence.strip()}" for sentence in sentences if sentence.strip()]
    if processed_sentences[-1].endswith('.'):
        processed_sentences[-1] = processed_sentences[-1][:-1]  # Remove the trailing period from the last sentence
    processed_text = '\n\n'.join(processed_sentences)
    return processed_text

def process_json(input_file, output_dir):
    with open(input_file, 'r', encoding='utf-8') as f:
        data = json.load(f)
    
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)

    for key, entry in data.items():
        doc_1_text = entry['doc_1_text']
        doc_2_text = entry['doc_2_text']
        generated_text_t01 = entry['generated_text_t01']
        
        processed_doc_1_text = process_text(doc_1_text)
        processed_doc_2_text = process_text(doc_2_text)
        processed_generated_text_t01 = process_generated_text(generated_text_t01)

        result = processed_doc_1_text + "\n\n" + processed_doc_2_text + "\n\n" + processed_generated_text_t01
        
        output_file = os.path.join(output_dir, f"{key}.story")
        with open(output_file, 'w', encoding='utf-8') as f:
            f.write(result)

input_file = r"C:\Users\xh182\Downloads\gossipcop_v3-7_integration_based_legitimate_tn300.json"  # �뽫��·���滻Ϊ���ʵ��·��
output_dir = r"G:\gossipcop"  # �뽫��·���滻Ϊ��ϣ������.story�ļ���Ŀ¼
process_json(input_file, output_dir)


import random

# ���������ļ��к��ļ����б���·��
data_dir = r'G:\gossipcop'
output_dir = r'G:url_lists'

# ȷ�����Ŀ¼����
os.makedirs(output_dir, exist_ok=True)

# ��ȡ���� .story �ļ���
all_filenames = [f for f in os.listdir(data_dir) if f.endswith('.story')]

# ���û��ֵ�����
train_size = 5500
val_size = 240

# ��������ļ����б�
random.shuffle(all_filenames)

# �������ݼ�
train_filenames = all_filenames[:train_size]
val_filenames = all_filenames[train_size:train_size + val_size]
test_filenames = all_filenames[train_size + val_size:]

# �����ļ����б��ļ�
def save_filenames_to_file(filenames, filename):
    with open(os.path.join(output_dir, filename), 'w', encoding='utf-8') as f:
        for fname in filenames:
            f.write(f"{fname}\n")

save_filenames_to_file(train_filenames, "all_train.txt")
save_filenames_to_file(val_filenames, "all_val.txt")
save_filenames_to_file(test_filenames, "all_test.txt")

print("File lists saved successfully.")
