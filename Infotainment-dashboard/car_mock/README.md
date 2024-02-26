# CarMock logic


## Quickstart

Everything should be executed from `car_mock` directory. 

Requirements: [Docker](https://www.docker.com/) & [Python 3.7+](https://www.python.org/downloads/).

Create PostgreSQL DB instance:
    
    source scripts/start_db.sh

Create DB schema using file: `scripts/db_schema_creation.sql`.

Download AWS IoT certificates & keys, and configure path to the certs inside `config.py` file.

Install Python requirements inside virtual environment:

    # create & activate env
    python3 -m venv venv
    source venv/bin/activate

    # install requirements
    pip install -r requirements.txt

(Optional) Socket connection `IP` and `port`, default: `127.0.0.1:<free_random_port>`.
When using external `SocketServer` comment out that line in `car.py` file.

(Optional) Configure logging to `file` and `console` with:
    
    # console & file
    logging_config(folder=os.path.join('logs'))

    # only console
    logging_config(folder=None)

Run program:

    python car.py
