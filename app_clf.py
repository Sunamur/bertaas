from flask import Flask, request
from transformers import pipeline
import logging



logging.basicConfig(filename='error.log',level=logging.DEBUG)
app = Flask(__name__)

global clf
clf=None


@app.route('/download', methods=['GET'])
def get_clf():
    global clf
    if clf is None:
        print('clf was none!')
        clf = pipeline("zero-shot-classification", model='joeddav/xlm-roberta-large-xnli')
    return clf



@app.route('/get_class', methods=['POST'])
def get_class():
    req_data = request.get_json()
    clf = get_clf()
    sequence = req_data['sequence']
    candidate_labels = req_data['candidate_labels']
    hypothesis_template = req_data.get('hypothesis_template',"Этот текст про {}.")
    multi_class = req_data.get('multi_class',True)
    answer_only = int(req_data['answer_only'])
    
    ans = clf(sequence, candidate_labels, hypothesis_template=hypothesis_template, multi_class=True)
    if answer_only:
        return ans['labels'][0]
    else:
        return ans