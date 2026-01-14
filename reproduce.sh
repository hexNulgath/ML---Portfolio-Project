#!/bin/bash
# reproduce.sh
echo "1. Installing requirements..."
pip install -r requirements.txt

echo "2. Running analysis..."
jupyter nbconvert --execute notebooks/analysis.ipynb

echo "3. Outputs available in results/"