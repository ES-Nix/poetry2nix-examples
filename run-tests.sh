

rm -fr .venv

poetry config virtualenvs.in-project true
poetry config virtualenvs.path .
poetry install

ls -al .venv/lib/python3.8/site-packages/ | grep yaml || echo 'Package yaml not found!'

