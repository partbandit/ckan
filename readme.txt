virtualenv env
env/bin/pip install setuptools==36.1
env/bin/pip install -r dev-requirements.txt
env/bin/pip install -r requirements.txt
env/bin/python setup.py develop 
cd ckan-dataportaltheme/
/mnt/d/SERVER/PythonProject/JDS/ckan-jawa-barat/env/bin/python setup.py develop
cd ..
cd ckanext-pages/
/mnt/d/SERVER/PythonProject/JDS/ckan-jawa-barat/env/bin/python setup.py develop
cd ..
cp ckan/config/who.ini who.ini
env/bin/paster serve development.ini 