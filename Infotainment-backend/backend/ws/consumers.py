import json
import asyncio
import random
from channels.generic.websocket import AsyncWebsocketConsumer

class ChatConsumer(AsyncWebsocketConsumer):
    isConected = False

    async def connect(self):
        try:
            await self.accept()
            self.isConected = True
            asyncio.ensure_future(self.send_periodic_messages())
        except Exception as e:
            print(e) 

    async def disconnect(self, _):
        try:
            self.isConected = False
            pass
        except Exception as e:
                print(e) 

    async def receive(self, text_data):
        try:
            await self.send(text_data=json.dumps({
                    "speed": random.randint(0, 100),
                    "mph": random.randint(1000, 3000),
                }))
        except Exception as e:
            print(e) 

    async def send_periodic_messages(self):
        try:
            while self.isConected:
                await self.send(text_data=json.dumps({
                    "speed": random.randint(0, 100),
                    "mph": random.randint(1000, 3000), 
                }))
                await asyncio.sleep(0.5)
        except Exception as e:
            print(e) 

