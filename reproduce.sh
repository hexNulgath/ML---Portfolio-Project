#!/bin/bash
# reproduce.sh
echo "1. Installing requirements..."
pip install -r requirements.txt

echo "2. Running analysis..."
jupyter nbconvert --to notebook --execute --inplace notebooks/MOVEIT.ipynb

echo "3. Outputs available in results/"