#!/bin/sh

# Pré-requis
# Deux environnements virtuels:
# - ~/venc/kraken/ --> kraken 
# - ~/venv/pie/ --> pie-extended
# Librairie : pdftoppm --> split d'un pdf en une suite d'images png (pour télécharger: sudo apt-get poppler-utils)
# Changer le lemmatiseur de pie-extended par celui appris par Simon Gabay

# Modèle OCR :
# Simon Gabay, Thibault Clérice, Christian Reul. OCR17: Ground Truth and Models for 17th c. French Prints (and hopefully more). 2020. ⟨hal-02577236⟩

# Lemmatiseur :
# Article pas encore accepté à DDH. Pour l'instant, voir : https://github.com/e-ditiones/LEM17/releases/tag/v0.1

# 1. Découper le pdf en images png
echo "1. Découper le pdf en images png"
for file in `ls ./pdf/*.pdf`; do echo $file;pdftoppm -png $file $file; done

# 2. déplacer les images dans le dossier png
echo "2. déplacer les images dans le dossier png"
mkdir png
for file in pdf/*.png; do mv $file ./png/; done

# 3. supprimer les images générées pas Gallica et les vides
echo "3. supprimer les images générées pas Gallica et les vides"
for file in `ls ./png/*.png`; do python3 remove_generated_images.py $file; done

# 4. activation de l'environnement virtuel kraken
echo "4. activation de l'environnement virtuel kraken"
. ~/venv/kraken/bin/activate

#5. binarisation des images
echo "5. binarisation des images"
kraken -I "./png/*.png" -o _bin.png binarize

#6. segmentation et OCR
echo "6. segmentation et OCR"
FILE=models/kraken_CORPUS17_SimonGabay.mlmodel

if test -f "$FILE"; then
    echo "$FILE exists."
else
    mkdir models
    #wget https://github.com/e-ditiones/OCR17/raw/master/Models/Kraken.mlmodel -O $FILE 
    wget https://zenodo.org/record/3826894/files/OCR17.zip?download=1 -O $FILE
    fi

kraken -I "./png/*_bin.png" -o .txt segment ocr -m ./models/kraken_CORPUS17_SimonGabay.mlmodel

#7. déplacer les fichiers textes dans le dossier txt
echo "7. déplacer les fichiers textes dans le dossier txt"
mkdir txt
for file in png/*.txt; do mv $file ./txt/; done

# 8. Activation de l'environnement virtuel pie
echo "8. Activation de l'environnement virtuel pie"
. ~/venv/pie/bin/activate

# 9. Utilisation de pie-extended
echo "9. Utilisation de pie-extended"
for file in `ls ./txt/*.txt`; do pie-extended tag fr $file; done

# 10. déplacer les pie dans le dossier pie
echo "10. déplacer les pie dans le dossier pie"
mkdir pie
for file in `ls ./txt/*-pie.txt`; do mv $file ./pie; done
