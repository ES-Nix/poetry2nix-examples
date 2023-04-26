import pandas as pd

from flask import Flask

app = Flask(__name__)

@app.route('/')
def index():
    return 'Hello world!!'

@app.route('/pandas')
def index():
    return pd.__version__

def main():
    app.run(host='0.0.0.0')


if __name__ == '__main__':
    main()


