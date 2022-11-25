https://github.com/atingupta2005/jenkins-python-test

```
sudo apt-get install -y python3-venv
sudo chmod 777 /p_venv
python3 -m venv /p_venv
source /p_venv/bin/activate
pip install pytest-html
pip install pytest-cov
pip install coverage

pytest --html=report.html
pytest --cov main.py 
coverage run main.py 
coverage report -m
```