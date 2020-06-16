# 17th_OCR_T_L_POS

A global pipeline fo 17th c. documents: pdf -> ocr -> tokenization -> lemmatization -> POS-tagging

Requirements
============
torch==1.3.1
torchvision==0.4.2

To do
=====
Create two virtual environments:
- ~/venc/kraken/ --> kraken 
- ~/venv/pie/ --> pie-extended

Download these libraries:
- pdftoppm --> used to split a pdf into png images (unix system: sudo apt-get poppler-utils)
- kraken --> used to process the ocr (pip3 install kraken)
- pie-extended --> used to tokenizer, lemmatize and POS-tag OCR results (pip3 install pie-extended)

Models used in this pipeline
============================
- OCR : Simon Gabay, Thibault Clérice, Christian Reul. OCR17: Ground Truth and Models for 17th c. French Prints (and hopefully more). 2020. ⟨hal-02577236⟩
- Lemmatizer : (Paper not accepted for now)  https://github.com/e-ditiones/LEM17/releases/tag/v0.1
- Tokenizer, POS-tagger and Morphogical Analyser : "fr" model downloaded by pie-extended module as follow: pip-extended download fr
