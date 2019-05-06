virtualenv env
env/bin/pip install -r requirements.txt
env/bin/python setup.py develop
git clone https://github.com/code4romania/ckanext-dataportaltheme.git
cd ckan-dataportaltheme/
/mnt/d/SERVER/PythonProject/ubuntu/ckan-2.8.2-theme/env/bin/python setup.py develop
cd ..
cp ckan/config/who.ini who.ini
env/bin/paster serve development.ini