# Backend

### Create virtual environment

<kbd> command </kbd> + <kbd>Shift</kbd> + <kbd>P</kbd> => Python: Create Environment => Venv => select python version (3.12.1)

Get in env

```shell
#MAC
source .venv/bin/activate

#WIN
.venv/Scripts/activate
```

### Install requirements

```shell
pip install -r requirements.txt

pip install channels["daphne"]  #?? on my mac didn't work (Edi) ??

# worked on mac
pip install channels
pip install daphne
```

### Run backend

```shell

cd backend

python manage.py runserver
```

### Test connection in browser console

```javascript
const chatSocket = new WebSocket("ws://localhost:8000/ws/chat/");

chatSocket.onopen = function () {
  chatSocket.send("");
};

chatSocket.onclose = function () {
  console.log("Conection closed");
};

chatSocket.onmessage = function (event) {
  const message = JSON.parse(event.data);
  console.log("Received message:", message);
};
```

### Test connection in postman

In Headers add

```
origin:http://127.0.0.1:8000
```
