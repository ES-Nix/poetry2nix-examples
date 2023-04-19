from flask import Flask

app = Flask(__name__)

@app.route('/')
def index():
    return 'Hello world!!'

def main():
    app.run(host='0.0.0.0')


if __name__ == '__main__':
    main()


